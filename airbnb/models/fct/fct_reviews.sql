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

SELECT *
    FROM src_reviews
    WHERE reviewer_name is not NULL

-- This part tell dbt how to increment
{% if is_incremental() %}
    AND review_date > (SELECT max(review_date) from {{ this }})
{% endif %}