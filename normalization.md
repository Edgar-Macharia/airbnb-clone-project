# Database Normalization for Airbnb Clone Project

## Normalization Forms

* **First Normal Form (1NF)** : Attributes are atomic, with no repeating groups or multi-valued fields.
* **Second Normal Form (2NF)** : The table is in 1NF, and all non-key attributes fully depend on the entire primary key. Since all tables use single-attribute primary keys, 2NF is automatically satisfied.
* **Third Normal Form (3NF)** : The table is in 2NF, and no non-key attributes depend on other non-key attributes (no transitive dependencies).

## Table-by-Table Analysis

### 1. User Table

* **Primary Key** : **user_id**
* **Attributes** : **first_name**, **last_name**, **email**, **password_hash**, **phone_number**, **role**, **profile_image**, **created_at**
* **1NF** : All attributes are atomic (e.g., **phone_number** is a single string, **role** is an ENUM).
* **2NF** : No composite key, so no partial dependencies.
* **3NF** : All attributes depend directly on **user_id** (e.g., **email** describes the user). No transitive dependencies exist, as no attribute depends on another non-key attribute.
* **Conclusion** : In 3NF.

### 2. Property Table

* **Primary Key** : **property_id**
* **Attributes** : **host_id**, **name**, **description**, **location**, **price_per_night**, **created_at**, **updated_at**
* **1NF** : Attributes are atomic (e.g., **location** is a single string).
* **2NF** : Single primary key, so 2NF is satisfied.
* **3NF** : All attributes depend on **property_id**. **host_id** references **User**, but no attributes depend on **host_id** alone, avoiding transitive dependencies.
* **Conclusion** : In 3NF.

### 3. Booking Table

* **Primary Key** : **booking_id**
* **Attributes** : **property_id**, **user_id**, **start_date**, **end_date**, **total_price**, **status**, **created_at**
* **1NF** : All attributes are atomic.
* **2NF** : Single primary key.
* **3NF** : All attributes depend on **booking_id**. **total_price** could be derived from **price_per_night** and dates, but storing it is acceptable in 3NF if consistency is ensured via Django logic.
* **Conclusion** : In 3NF.

### 4. Payment Table

* **Primary Key** : **payment_id**
* **Attributes** : **booking_id**, **amount**, **payment_method**, **payment_date**
* **1NF** : All attributes are atomic.
* **2NF** : Single primary key.
* **3NF** : All attributes depend on **payment_id**. **amount** may align with **Booking.total_price**, but storing it is practical with consistency checks.
* **Conclusion** : In 3NF.

### 5. Review Table

* **Primary Key** : **review_id**
* **Attributes** : **property_id**, **user_id**, **rating**, **comment**, **created_at**
* **1NF** : All attributes are atomic.
* **2NF** : Single primary key.
* **3NF** : All attributes depend on **review_id**. **property_id** and **user_id** are foreign keys, but no attributes depend on them alone.
* **Conclusion** : In 3NF.

### 6. Message Table

* **Primary Key** : **message_id**
* **Attributes** : **sender_id**, **recipient_id**, **message_body**, **sent_at**
* **1NF** : All attributes are atomic.
* **2NF** : Single primary key.
* **3NF** : All attributes depend on **message_id**. **sender_id** and **recipient_id** are foreign keys, but no transitive dependencies exist.
* **Conclusion** : In 3NF.

### 7. Property_Images Table

* **Primary Key** : **image_id**
* **Attributes** : **property_id**, **image_url**
* **1NF** : All attributes are atomic.
* **2NF** : Single primary key.
* **3NF** : All attributes depend on **image_id**. **property_id** is a foreign key, but no attributes depend on it alone.
* **Conclusion** : In 3NF.

The schema is fully normalized to 3NF, with each table’s attributes depending directly on their primary keys and no transitive dependencies. This design supports the Airbnb clone’s requirements while ensuring data integrity.
