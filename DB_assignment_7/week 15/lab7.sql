--#1 a
CREATE or replace FUNCTION inc(val integer) RETURNS integer AS
$$
BEGIN
    RETURN val + 1;
END;
$$
    LANGUAGE PLPGSQL;

select inc(inc(5));
--b

CREATE or replace FUNCTION sum_val(a integer, b integer) RETURNS integer AS
$$
BEGIN
    Return a + b;
END;
$$
    LANGUAGE PLPGSQL;


select sum_val(5,6);

--c
CREATE or replace FUNCTION isEven(val integer) RETURNS boolean AS
$$
BEGIN
    RETURN val % 2 = 0;
END;
$$
    LANGUAGE PLPGSQL;

select isEven(54);
select isEven(3);
select isEven(4);
select isEven(5465151);

--d
CREATE or replace FUNCTION password(pass varchar) RETURNS boolean AS
$$
BEGIN
    if pass LIKE '%[a-z]%[a-z]%' and pass LIKE '%[A-Z]%[A-Z]%' AND
       PASS LIKE '%[0-9]%[0-9]%' then return true;
    else return false;
    end if;

END;
$$
    LANGUAGE PLPGSQL;

select password(DiasMombekov003);
select password(esfwf);

--e
CREATE or replace FUNCTION va(a numeric,
                                    out square numeric,
                                    out cube numeric) AS
$$
BEGIN
    square = a * a;
    cube = a * a * a;
END;
$$
    LANGUAGE PLPGSQL;

select * from va(2);

create table table1(

);
create table table2(

);
create table table3(

);
create table table4(

);
create table table5(

);
--#2 a
create function current()
    returns trigger as
$$
begin
    raise notice '%',now();
    return new;
end;
$$
    language plpgsql;

create trigger current_t before insert on table1 for each row execute procedure current();

--b

create function age()
    returns trigger as
$$
begin
    raise notice '%', age(now(), new.t);
    return new;
end;
$$
    LANGUAGE plpgsql;

create trigger age_t before insert on table2 for each row execute procedure age();

--c
create function tax()
    returns trigger as
$$
begin
    new.cost = new.cost * 1.12;
    return new;
end;
$$
language plpgsql;

create trigger tax_t before insert on table3 for each row execute procedure tax();

--d
create function stop()
    returns trigger as
$$
begin
    raise exception 'Deletion is not allowed';
end;
$$
    language plpgsql;

create trigger stop_t before delete on table4 execute procedure stop();

--e
create function call()
    returns trigger as
$$
begin
    raise notice '%', password(new.s);
    raise notice '%', va(new.a);
    return new;
end;
$$
    language plpgsql;

create trigger call_t before insert on table5 for each row execute procedure call();

--3
create table work(
    id int,
    name varchar,
    date_of_birth date,
    age int,
    salary numeric,
    workexperience int,
    discount numeric
);
--a
create function
    inc(id int, name varchar, date_of_birth date, age int,
    inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
        salary = salary * 1.1;
    end loop;
    count = workexperience/5;
    for step in 1..count loop
        discount = discount * 1.01;
    end loop;
    insert into work values(id, name, date_of_birth, age, salary,
                            workexperience, discount);
end;
$$
    language plpgsql;

select *
from inc(1, 'Dias', '1987-05-30', 35, 900, 10);

--b
create or replace function
    pension(id int, name varchar, date_of_birth date, age int,
    inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    if age >= 40 then
        salary = salary * 1.15;

    end if;
    discount = 10;
    count = workexperience/2;
     for step in 1..count loop
        salary = salary * 1.1;
    end loop;
    count = workexperience/5;
    for step in 1..count loop
        discount = discount * 1.01;
    end loop;
    if workexperience > 8 then salary = salary * 1.15;
    end if;
    if workexperience > 8 then discount = 20;
    end if;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
    LANGUAGE plpgsql;

select *
from pension(2, 'Said', '1978-04-14', 44, 10000, 10);