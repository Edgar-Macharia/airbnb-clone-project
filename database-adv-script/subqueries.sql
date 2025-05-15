-- Query to find all properties where the average rating is greater than 4
SELECT p.property_id, p.name
FROM property p
JOIN review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0;

-- Query to find users who have made more than 3 bookings
SELECT u.user_id, u.first_name
FROM user u
JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name
HAVING COUNT(*) > 3;