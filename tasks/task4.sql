select
    'resume' as name,
    extract(year from resume.created_date) as year,
    extract(month from resume.created_date) as month,
    count(*) as count
from resume
group by year, month
order by count desc
limit 1;

select
    'vacancy' as name,
    extract(year from vacancy.created_date) as year,
    extract(month from vacancy.created_date) as month,
    count(*) as count
from vacancy
group by year, month
order by count desc
limit 1;
