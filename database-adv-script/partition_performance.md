**Report: Performance Improvements from Partitioning the Booking Table**

The Booking table was partitioned by range on YEAR(start_date) to optimize queries filtering by date ranges.The table was divided into yearly partitions (2024, 2025, 2026, and a future catch-all), with the primary key modified to include `start_date` and foreign keys removed due to MySQL limitations.

 **Performance Before Partitioning** :

* **EXPLAIN Output** :
* Booking table: type: range, rows: ~100,000 (e.g., 10% of 1 million rows), using idx_booking_start_date if present.
* Full index or table scan across all years, even with an index.
* Extra: Using where; Using index condition.
* **Issues** :
* High row count scanned (e.g., 100,000), including irrelevant years.
* Increased I/O and CPU usage for large datasets.
* Estimated cost: High (e.g., 100,000 operations).

 **Performance After Partitioning** :

* **EXPLAIN Output** :
* Booking table: partitions: p2025, type: range, rows: ~50,000 (e.g., half of 2025’s bookings).
* Only the p2025 partition scanned, pruning 2024, 2026, and future partitions.
* Extra: Using where; Using index condition.

    **Improvements** :

* **Partition Pruning** : Reduced dataset to 2025 bookings (e.g., 100,000 rows vs. 1 million), cutting I/O.
* **Fewer Rows Scanned** : From ~100,000 to ~50,000, as only relevant partition is accessed.
* **Lower Cost** : Estimated cost dropped (e.g., 50,000 operations), improving execution time.
* **Index Support** : Indexes on property_id and status further optimized joins and filters within the partition.
