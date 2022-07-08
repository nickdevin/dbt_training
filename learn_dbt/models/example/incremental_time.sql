{{ config(materialized='incremental', unique_key = 'time_formatted') }}

select *, to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) time_formatted
from
    "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
where time_formatted <= current_time
{% if is_incremental() %}
    and time_formatted > (select max(time_formatted) from {{ this }})
{% endif %}