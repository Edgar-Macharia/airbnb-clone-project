Task 1: Retrieve All Bookings and Respective Users Using INNER JOIN


SELECT

b.booking_id,

b.start_date,

b.end_date,

b.total_price,

b.status,

u.user_id

FROM

bookingb

INNERJOIN

user u ON b.user_id = u.user_id;


Task 2: Retrieve All Properties and Their Reviews Using LEFT JOIN

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

propertyp

LEFTJOIN

reviewrONp.property_id = r.property_id

ORDERBY

p.property_idASC,

r.created_atDESC;


Task 3:Retrieve All Users and All Bookings Using FULL OUTER JOIN

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

useru

LEFTJOIN

bookingbONu.user_id = b.user_id

UNION

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

useru

RIGHTJOIN

bookingbONu.user_id = b.user_id

WHERE

u.user_idISNULL;
