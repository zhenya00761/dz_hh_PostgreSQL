select
    r.region_id,
    r.region_name,
    round(avg(v.compensation_from)) as avg_compensation_from,
    round(avg(v.compensation_to)) as avg_compensation_to,
    round(avg((v.compensation_from + v.compensation_to) / 2)) as avg_salary_from_and_to
from vacancy v
join region r on v.region_id = r.region_id
group by r.region_id, r.region_name
order by r.region_id