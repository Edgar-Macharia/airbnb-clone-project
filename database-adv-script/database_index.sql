-- Property table: Index on location
CREATE INDEX idx_property_location ON `property` (`location`);

-- Property table: Index on price_per_night
CREATE INDEX idx_property_price_per_night ON `property` (`price_per_night`);

-- Property table: Composite index on location and price_per_night
CREATE INDEX idx_property_location_price ON `property` (`location`, `price_per_night`);

-- Booking table: Index on start_date
CREATE INDEX idx_booking_start_date ON `booking` (`start_date`);

-- Booking table: Index on status
CREATE INDEX idx_booking_status ON `booking` (`status`);

-- Booking table: Composite index on start_date and status
CREATE INDEX idx_booking_start_date_status ON `booking` (`start_date`, `status`);

-- Analyze Performance Before Indexes
EXPLAIN ANALYZE
SELECT 
    p.property_id AS property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_num
FROM 
    property p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    total_bookings DESC;


-- Check the performance AFTER adding the index
EXPLAIN ANALYZE
SELECT 
    p.property_id AS property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_num
FROM 
    property p
LEFT JOIN 
    bookings b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name
ORDER BY 
    total_bookings DESC;