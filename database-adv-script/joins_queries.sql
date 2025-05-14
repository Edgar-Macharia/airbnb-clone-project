-- Query to get boookings with respective users
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id
FROM
    booking b
        INNER JOIN
    user u ON b.user_id = u.user_id;

-- Query to get all properties with respective reviews
    SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.user_id,
    r.created_at
FROM 
    property p
LEFT JOIN 
    review r ON p.property_id = r.property_id
ORDER BY 
    p.property_id ASC,
    r.created_at DESC;

    -- Query to get all users and all bookings
    SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM 
    user u
FULL OUTER JOIN 
    booking b ON u.user_id = b.user_id;