-- Query to retrieve booking details with user details, property details, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM 
    booking b
INNER JOIN 
    user u ON b.user_id = u.user_id
INNER JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;

-- Query to analyze the initial query’s performance and identify inefficiencies
EXPLAIN
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM 
    booking b
INNER JOIN 
    user u ON b.user_id = u.user_id
INNER JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;

-- Refactored query to reduce execution time
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method
FROM 
    booking b
INNER JOIN 
    user u ON b.user_id = u.user_id
INNER JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2025-01-01'
ORDER BY 
    b.start_date DESC;