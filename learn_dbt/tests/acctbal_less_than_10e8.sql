select sum(c_acctbal)
from
	"SNOWFLAKE_SAMPLE_DATA"."TPCH_SF001"."CUSTOMER" as total_acctbal
having total_acctbal < power(10,8)