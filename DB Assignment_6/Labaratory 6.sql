
select *
from dealer
cross join client;

select dealer.name, client.name, client.city, client.priority, sell.id, sell.date, sell.amount
from dealer
inner join client on dealer.id = client.dealer_id inner join sell on client.id = sell.client_id;

select dealer.id, dealer.name, client.id, client.name
from dealer
inner join client on dealer.location = client.city;

select sell.id, sell.amount, client.name, client.city
from sell
inner join client on sell.client_id = client.id
where sell.amount between 100 and 500;

select distinct on (dealer.id) dealer.name, client.name
from dealer
left join client on dealer.id = client.dealer_id;

select client.name, client.city, dealer.id, dealer.name, dealer.charge
from dealer
left join client on dealer.id = client.dealer_id;

select client.name, client.city, dealer.id, dealer.name, dealer.charge
from dealer
left join client on dealer.id = client.dealer_id
where dealer.charge > 0.12;

select distinct on (client.id) client.id, client.name, client.city,
                               sell.id, sell.date, sell.amount,
                               dealer.id, dealer.name, dealer.charge
from client
left join sell on client.id = sell.client_id left join dealer on sell.dealer_id = dealer.id;

select dealer.id, dealer.name, client.id, client.name, client.priority, sell.id, sell.amount
from dealer
inner join client on dealer.id = client.dealer_id left join sell on client.id = sell.client_id;


create view clients as
select date, count(distinct client_id), avg(amount), sum(amount)
from sell
group by date;

create view dates as
select sum(amount)
from sell
group by date
order by sum(amount) desc limit 5;

create view sales as
select dealer_id, count(dealer_id), sum(amount), avg(amount)
from sell
where dealer_id != 0
group by dealer_id

create view earned_amount as
select dealer.location, dealer_id, sum(sell.amount * dealer.charge)
from dealer
left join sell on dealer.id = sell.dealer_id
group by dealer.location, dealer_id;

create view num_of_sales as
select count(sell.id), sum(amount), avg(amount), dealer.location
from sell
right join dealer on sell.dealer_id = dealer_id
group by dealer.location

create view expenses as
select sum(sell.id), sum(sell.amount), avg(sell.amount), client.city
from sell
left join client on client_id = client.id
group by client.city;

create view find as
select client.city
from client
inner join sell on client.id = sell.client_id
group by client.city
having sum(sell.amount) > (select sum(sell.amount)
                           from dealer
                           inner join sell on dealer.id = sell.dealer_id
                           where client.city = dealer.location
                           group by dealer.location);
