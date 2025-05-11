-- Insert sample users
INSERT INTO `User` (first_name, last_name, email, password_hash, phone_number, role, profile_image)
VALUES
('John', 'Doe', 'john@example.com', 'hashed_password1', '1234567890', 'guest', NULL),
('Jane', 'Smith', 'jane@example.com', 'hashed_password2', '0987654321', 'host', NULL),
('Alice', 'Johnson', 'alice@example.com', 'hashed_password3', '1122334455', 'guest', NULL),
('Bob', 'Brown', 'bob@example.com', 'hashed_password4', '5566778899', 'host', NULL),
('Admin', 'User', 'admin@example.com', 'hashed_password5', '9988776655', 'admin', NULL);

-- Insert sample properties
INSERT INTO `Property` (host_id, name, description, location, price_per_night)
VALUES
(2, 'Cozy Apartment in Downtown', 'A comfortable apartment in the heart of New York.', 'New York, NY', 100.00),
(4, 'Beach House', 'A beautiful house right on the beach in Miami.', 'Miami, FL', 150.00),
(2, 'Luxury Villa', 'A luxurious villa with stunning views in Los Angeles.', 'Los Angeles, CA', 200.00);

-- Insert sample bookings
INSERT INTO `Booking` (property_id, user_id, start_date, end_date, total_price, status)
VALUES
(1, 3, '2025-06-01', '2025-06-05', 400.00, 'confirmed'),
(2, 1, '2025-06-10', '2025-06-15', 750.00, 'pending'),
(3, 3, '2025-07-01', '2025-07-07', 1200.00, 'confirmed');

-- Insert sample reviews
INSERT INTO `Review` (property_id, user_id, rating, comment)
VALUES
(1, 3, 5, 'Great place, very clean and comfortable.');

-- Insert sample payments
INSERT INTO `Payment` (booking_id, amount, payment_method, payment_date)
VALUES
(1, 400.00, 'credit_card', '2025-05-20 00:00:00'),
(2, 750.00, 'paypal', '2025-05-25 00:00:00'),
(3, 1200.00, 'stripe', '2025-06-15 00:00:00');

-- Insert sample property images
INSERT INTO `Property_Images` (property_id, image_url)
VALUES
(1, 'https://example.com/images/property1_1.jpg'),
(1, 'https://example.com/images/property1_2.jpg'),
(2, 'https://example.com/images/property2_1.jpg'),
(2, 'https://example.com/images/property2_2.jpg'),
(2, 'https://example.com/images/property2_3.jpg'),
(3, 'https://example.com/images/property3_1.jpg');