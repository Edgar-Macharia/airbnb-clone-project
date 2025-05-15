**Query 1: Retrieve Bookings with User and Property Details**

Bottleneck: Moderate row count scanned for start_date and status filters, even with `idx_booking_start_date_status`. Sorting (**ORDER BY start_date DESC**) may require filesort if the index isn’t fully utilized.

 **Suggested Changes** :

1. **Covering Index** : Create a covering index to include all selected Booking columns, reducing data access:
   sql

```
CREATE INDEX idx_booking_cover ON Booking (status, start_date, booking_id, total_price, property_id, user_id);
```

1. **Partitioning** : If not already partitioned, partition Booking by YEAR(start_date) to prune irrelevant years, reducing rows scanned.
2. **Tighter Filter** : Add a narrower date range (e.g., 1 month) if business logic allows, e.g., start_date >= '2025-06-01'.

**Query 2: Search Properties**

Bottleneck: Minimal; `idx_property_location_price` optimizes filtering and sorting, with low row count. No significant issues unless Property grows very large.

**Suggested Changes** :

1. **No Change Needed** : Current index is optimal. If location has low selectivity, consider a composite index with more selective columns first (e.g., price_per_night, location).
2. **Materialized View** : For frequently searched locations, create a materialized view to cache results.

**Query 3: Count Bookings per User**

Bottleneck: High cost due to full table scan on User and aggregation across all bookings. **LEFT JOIN** processes all users, even those with no bookings, increasing cost.

**Suggested Changes** :

1. **Index on Booking.user_id** : Already exists (`idx_user_id` or `foreign key index), but ensure it’s used.
2. **Filter Active Users** : Add a WHERE clause to exclude inactive users (e.g., WHERE u.created_at > '2024-01-01'), reducing User rows:

   ```
   WHERE u.created_at > '2024-01-01'
   ```

Create an index:

```
CREATE INDEX idx_user_created_at ON User (created_at);
```

3. Rewrite as INNER JOIN: If only users with bookings are needed, use INNER JOIN to skip users with zero bookings:

   ```
   INNER JOIN Booking b ON u.user_id = b.user_id
   ```
4. Summary Table: Create a summary table for booking counts, updated periodically:

```
CREATE TABLE User_Booking_Summary (
user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
total_bookings INT NOT NULL,
last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES User(user_id)
);
```
