

CREATE TABLE region(
    region_id integer GENERATED ALWAYS AS IDENTITY primary key,
    region_name varchar(50) not null unique
);

CREATE TABLE city(
    city_id integer GENERATED ALWAYS AS IDENTITY primary key,
    city_name varchar(50) not null,
    region_id integer not null references region(region_id) ON DELETE CASCADE
);



CREATE TABLE employer(
    employer_id integer GENERATED ALWAYS AS IDENTITY primary key,
    employer_name varchar(100) not null,
    employer_description text not null,

    employer_phone varchar(15) unique not null,
    employer_email varchar(50) unique not null,

    employer_regionId integer not null references region(region_id),
    employer_cityId integer not null references city(city_id)
);

CREATE TABLE person(
    person_id integer GENERATED ALWAYS AS IDENTITY primary key,
    person_firstName varchar(20) not null,
    person_lastName varchar(20) not null,
    person_middleName varchar(20),

    person_phone varchar(12) unique not null,
    person_email varchar(50) unique not null,

    person_birth date not null,

    person_regionId integer not null references region(region_id),
    person_cityId integer not null references city(city_id),

    person_drive boolean default false,
    person_language varchar(50) not null
);

CREATE TABLE specialization(
    specialization_id integer GENERATED ALWAYS AS IDENTITY primary key,
    specialization_name varchar(100) not null unique,
    specialization_description text
);



CREATE TABLE vacancy(
    vacancy_id integer GENERATED ALWAYS AS IDENTITY primary key,
    vacancy_title varchar(150) not null,
    vacancy_description text not null,
    vacancy_salary integer,
    vacancy_experience text not null,

    employer_id integer not null references employer(employer_id) ON DELETE CASCADE,
    specialization_id integer not null references specialization(specialization_id) ON DELETE SET NULL,

    region_id integer not null REFERENCES region(region_id),
    city_id integer not null REFERENCES city(city_id)
);

CREATE TABLE resume(
    resume_id integer GENERATED ALWAYS AS IDENTITY primary key,
    resume_title varchar(150) not null,
    resume_description text not null,
    resume_salary integer,
    resume_experience text not null,

    person_id integer not null references person(person_id) ON DELETE CASCADE,
    specialization_id integer not null references specialization(specialization_id) ON DELETE SET NULL,

    region_id integer not null REFERENCES region(region_id),
    city_id integer not null REFERENCES city(city_id)
);

CREATE TABLE response(
    response_id integer GENERATED ALWAYS AS IDENTITY primary key,
    vacancy_id integer not null references vacancy(vacancy_id) ON DELETE CASCADE,
    resume_id integer not null references resume(resume_id) ON DELETE CASCADE,
    unique (vacancy_id, resume_id)
);

alter table vacancy
add column compensation_from integer check (compensation_from >= 0),
add column compensation_to integer check (compensation_to >= 0);

alter table vacancy
add column created_date date;

alter table resume
add column created_date date;

alter table response
add column created_date date;