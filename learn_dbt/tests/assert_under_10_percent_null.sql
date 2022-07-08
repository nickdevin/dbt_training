select
	sum(case when id is null then 1 else 0 end) / count(*) as null_percent
from {{ ref('my_first_dbt_model') }}
having null_percent > .1