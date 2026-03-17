
--Для создания откликов, которые подходят по заданию, а то я взял большой период,
--поэтому просто нет ни одной вакансии, подходящей по условию
insert into response(vacancy_id, resume_id, created_date)
select
    v.vacancy_id,
    (random() * 99999 + 1)::int,
    v.created_date + (random() * 7)::int
from vacancy v
cross join generate_series(1,20)
where v.vacancy_id in (1, 5, 10, 15, 20);


select
    v.vacancy_id,
    v.vacancy_title
from vacancy v
join response r on v.vacancy_id = r.vacancy_id
where r.created_date <= v.created_date + 7
group by v.vacancy_id, v.vacancy_title
having count(*) > 5
order by v.vacancy_id;