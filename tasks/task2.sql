with regions as (
    select
        generate_series(1, 100) as id,
        'Регион ' || generate_series(1, 100) as name
)
insert into region (region_name)
select name from regions;


with cities as (
    select
        generate_series(1, 1000) as id,
        'Город' || generate_series(1, 1000) as name,
        (random() * 99 +1)::int as region_id
)
insert into city (city_name, region_id)
select name, region_id from cities;


with employers as (
    select
        generate_series(1, 1000) as id,
        'Компания ' || generate_series(1, 1000) as name,
        md5(random()::text) as description,
        (90000000000 + generate_series(1, 1000))::varchar as phone,
        'Компания' || generate_series(1, 1000) || '@mail.ru' as email,
        (random() * 99 + 1)::int as region_id,
        (random() * 999 + 1)::int as city_id
)
insert into employer (
    employer_name,
    employer_description,
    employer_phone,
    employer_email,
    employer_regionId,
    employer_cityId
)
select
    name,
    description,
    phone,
    email,
    region_id,
    city_id
from employers;


with people as (
    select
        generate_series(1, 5000) as id,
        'Имя ' || generate_series(1, 5000) as name,
        'Фамилия ' || generate_series(1, 5000) as lastName,
        'Отчество ' || generate_series(1, 5000) as middleName,
        (90000000000 + generate_series(1, 5000))::varchar as phone,
        'Человек ' || generate_series(1, 5000) || '@mail.ru' as email,
        '1950-01-01'::date + (random() * 18000)::int as birth_date,
        (random() * 99 + 1)::int as region_id,
        (random() * 999 + 1)::int as city_id,
        random() > 0.5 as has_drive,
        case (random() * 2)::int
            when 0 then 'Русский'
            when 1 then 'Английский'
            else 'Китайский'
        end as language
)
insert into person (
    person_firstName,
    person_lastName,
    person_middleName,
    person_phone,
    person_email,
    person_birth,
    person_regionId,
    person_cityId,
    person_drive,
    person_language
)
select
    name,
    lastName,
    middleName,
    phone,
    email,
    birth_date,
    region_id,
    city_id,
    has_drive,
    language
from people;


with specializations as (
    select
        generate_series(1, 50) as id,
        'Специализация ' || generate_series(1, 50) as spec_name,
        md5(random()::text) as description
)
insert into specialization (
    specialization_name,
    specialization_description
)
select
    spec_name,
    description
from specializations;


with vacancies as (
    select
        generate_series(1, 10000) as id,
        'Вакансия ' || generate_series(1, 10000) as title,
        md5(random()::text) as description,
        (random() * 300000 + 30000)::int as salary,
        case (random() * 3)::int
            when 0 then 'Нет опыта'
            when 1 then '1-3 года'
            when 2 then '3-6 лет'
            else 'Более 6 лет'
        end as experience,
        (random() * 999 + 1)::int as employer_id,
        (random() * 49 + 1)::int as specialization_id,
        (random() * 99 + 1)::int as region_id,
        (random() * 999 + 1)::int as city_id
)
insert into vacancy (
    vacancy_title,
    vacancy_description,
    vacancy_salary,
    vacancy_experience,
    employer_id,
    specialization_id,
    region_id,
    city_id
)
select
    title,
    description,
    salary,
    experience,
    employer_id,
    specialization_id,
    region_id,
    city_id
from vacancies;


with resumes as (
    select
        generate_series(1, 100000) as id,
        'Резюме ' || generate_series(1, 100000) as title,
        md5(random()::text) as description,
        (random() * 300000 + 30000)::int as salary,
        case (random() * 3)::int
            when 0 then 'Нет опыта'
            when 1 then '1-3 года'
            when 2 then '3-6 лет'
            else 'Более 6 лет'
        end as experience,
        (random() * 4999 + 1)::int as person_id,
        (random() * 49 + 1)::int as specialization_id,
        (random() * 99 + 1)::int as region_id,
        (random() * 999 + 1)::int as city_id
)
insert into resume (
    resume_title,
    resume_description,
    resume_salary,
    resume_experience,
    person_id,
    specialization_id,
    region_id,
    city_id
)
select
    title,
    description,
    salary,
    experience,
    person_id,
    specialization_id,
    region_id,
    city_id
from resumes;


with responses as (
    select
        generate_series(1, 30000) as id,
        (random() * 9999 + 1)::int as vacancy_id,
        (random() * 99999 + 1)::int as resume_id
)
insert into response (
    vacancy_id,
    resume_id
)
select
    vacancy_id,
    resume_id
from responses
on conflict (vacancy_id, resume_id) do nothing;


update vacancy
set
    compensation_from = greatest(0, vacancy_salary - (random() * 30000)::int),
    compensation_to = vacancy_salary + (random() * 40000 + 10000)::int
where vacancy_salary is not null;

update vacancy
set created_date = '2002-01-01'::date + (random() * 9125)::int
where created_date is null;

update resume
set created_date = '2002-01-01'::date + (random() * 9125)::int
where created_date is null;

update response r
set created_date = v.created_date + (random() * 60)::int
from vacancy v
where r.vacancy_id = v.vacancy_id;


