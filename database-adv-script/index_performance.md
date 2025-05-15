**Objective:** Use EXPLAIN or ANALYZE to compare query performance before and after adding indexes, focusing on a representative query that benefits from the new indexes.

Query used for testing:

This query filters properties by location and price_per_night, joins with Booking on property_id, and filters bookings by start_date and status, sorting by price_per_night.

```
SELECT
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    b.booking_id,
    b.start_date,
    b.status
FROM
    property p
JOIN
    booking b ON p.property_id = b.property_id
WHERE
    p.location = 'New York, NY'
    AND p.price_per_night < 100.00
    AND b.start_date >= '2025-06-01'
    AND b.status = 'confirmed'
ORDER BY
    p.price_per_night ASC;
```



Results before adding indexes:

* Only default indexes exist:

  * Property: PRIMARY on property_id, index on host_id (foreign key).
  * Booking: PRIMARY on booking_id, indexes on property_id and user_id (foreign keys).
* No indexes on Property.location, Property.price_per_night, Booking.start_date, or Booking.status.

  **Performance Issues** :
* Full table scan on Property (high row count, e.g., 1000).
* No index for Booking filters (start_date, status), leading to row-by-row checks.
* Using filesort increases cost for sorting.

Results after adding Indexes:

* Indexes added: idx_property_location, idx_property_price_per_night, idx_property_location_price, idx_booking_start_date, idx_booking_status, idx_booking_start_date_status.
* MySQL optimizer chooses the best index (likely idx_property_location_price and idx_booking_start_date_status).

    **Performance Improvements** :

* Index scan on Property reduces rows scanned (e.g., 1000 to 50).
* Composite index idx_property_location_price optimizes WHERE and potentially ORDER BY, eliminating Using filesort.
* Index idx_booking_start_date_status reduces Booking row scans (e.g., 10 to 5).
