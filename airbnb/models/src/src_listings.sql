-- This is a DBT model

WITH raw_lisitings AS (
SELECT * FROM {{ source('airbnb', 'listings') }}
)

SELECT 
    id as listing_id,
    name as listing_name,
    listing_url,
    room_type,
    minimum_nights,
    host_id,
    price AS price_str,
    created_at,
    updated_at
FROM
    raw_lisitings