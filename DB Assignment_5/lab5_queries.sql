select *
from warehouses;

select *
from boxes;

select *
from boxes
where value > 150;

select distinct on (contents) *
from boxes;

select warehouses as code, count(code) as boxes
from boxes
group by warehouses;

select warehouses as code, count(code) as boxes
from boxes
group by warehouses
having count(code) > 2;

INSERT INTO Warehouses(code, location, capacity) VALUES(6, 'New York', 3);

INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('H5RT', 'Papers', 200, 2);

UPDATE Boxes set value = value * 0.85 where code in
    (select code from boxes order by value desc limit 1 offset 2);

DELETE FROM Boxes where value < 150;

DELETE FROM boxes where warehouses in
    (select code from warehouses where location = 'New York')
returning *;