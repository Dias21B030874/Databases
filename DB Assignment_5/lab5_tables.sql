create table warehouses(
    code integer primary key,
    location varchar(255),
    capacity integer
);
create table boxes(
    code char(4) primary key,
    contents varchar(255),
    value real,
    warehouses integer references warehouses(code)
);