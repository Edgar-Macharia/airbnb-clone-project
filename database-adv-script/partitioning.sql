-- Create partitioned Booking table
CREATE TABLE `Booking` (
    `booking_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `property_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_price` DECIMAL(8, 2) NOT NULL,
    `status` ENUM('pending', 'confirmed', 'cancelled') NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`booking_id`, `start_date`),
    INDEX idx_property_id (`property_id`),
    INDEX idx_user_id (`user_id`)
)
PARTITION BY RANGE (YEAR(`start_date`)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);