-- This is a DBT incremental materialization

{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)

SELECT 
{{ dbt_utils.generate_surrogate_key(['listing_id','review_date', 'reviewer_name', 'review_text']) }} AS review_id,
 *
    FROM src_reviews
    WHERE reviewer_name is not NULL

-- This part tell dbt how to increment
{% if is_incremental() %}
    AND review_date > (SELECT max(review_date) from {{ this }})
{% endif %}