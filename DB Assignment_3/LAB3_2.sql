create table customers(
    id int primary key,
    full_name varchar(50) not null,
    timestamp timestamp not null,
    delivery_address text not null
);
create table products(
    id varchar primary key,
    name varchar not null unique,
    description text,
    price double precision not null check(price > 0)
);
create table orders(
    code int primary key,
    customer_id integer,
    total_sum double precision not null check(total_sum > 0),
    is_paid boolean not null,
    foreign key(customer_id) references customers(id)
);
create table order_items(
    order_code int,
    product_id varchar,
    quantity integer not null check(quantity > 0),
    constraint id primary key(order_code, product_id),
    foreign key(order_code) references orders(code),
    foreign key(product_id) references products(id)
);