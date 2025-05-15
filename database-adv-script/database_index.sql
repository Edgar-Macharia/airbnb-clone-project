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