{{ config(materialized='incremental', unique_key = 'd_date') }}
--  specifying unique_key instruct dbt which rows not to duplicate

select *
from
    "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."DATE_DIM"
where d_date <= current_date
{% if is_incremental() %}
    and d_date > (select max(d_date) from {{ this }})
{% endif %}

-- is_incremental() true if two conditions met:
    -- set up as incremental table with "materialized='incremental'"
    -- not first time model has been run
-- To check if it's the first time the model is being run, dbt
-- checks if the table already exists in our snowflake account.
-- Condition in if-statement checks that there are actually new
-- rows to add.
-- "this" = already existent target table in snowflake that we are
-- loading new data into.