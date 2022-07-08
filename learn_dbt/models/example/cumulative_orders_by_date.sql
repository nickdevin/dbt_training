{{ config(materialized='table') }}

select distinct
    o_orderdate,
    sum(o_totalprice)
        over (order by o_orderdate) as cumulative_price
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS"