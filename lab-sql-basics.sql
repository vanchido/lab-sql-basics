use bank;

select client_id from client
where district_id = 1
limit 5;

select max(client_id) from client
where district_id = 72;

select amount from loan
order by amount asc
limit 3;

select distinct status from loan
order by status asc;

select loan_id from loan
order by payments desc
limit 1;

select account_id, amount from loan
order by account_id asc
limit 5;

select account_id from loan
where duration = 60
order by amount asc
limit 5;

select distinct k_symbol from `order`
where nullif(k_symbol,'') is not null;

select order_id from `order`
where account_id = 34;

select distinct account_id from `order`
where order_id between 29540 and 29560;

select sum(amount) from `order`
where account_to = 30067122;

select trans_id, date, type, amount from trans
where account_id = 793
order by date desc
limit 10;

select district_id, count(client_id) from client
where district_id < 10
group by district_id
order by district_id asc;

select type, count(card_id) from card
group by type
order by count(card_id) desc;

select account_id, sum(amount) from loan
group by account_id
order by sum(amount) desc
limit 10;

select date, count(loan_id) from loan
where date < 930907
group by date
order by date desc;

select date, duration, count(loan_id) from loan
where date between 971201 and 971231
group by date, duration
order by date asc;

select account_id, type, sum(amount) from trans
where account_id = 396
group by type;

select account_id, 
case 
	when type = 'PRIJEM' then 'INCOMING'
    when type = 'VYDAJ' then 'OUTGOING'
end as 'transaction_type',
floor(sum(amount)) as total_amount
from trans
where account_id = 396
group by type;

select account_id, 
	(select floor(sum(amount)) from trans
	where account_id = 396 and type = 'PRIJEM') as 'PRIJEM',
    (select floor(sum(amount)) from trans
	where account_id = 396 and type = 'VYDAJ') as 'VYDAJ',
    ((select floor(sum(amount)) from trans where account_id = 396 and type = 'PRIJEM') 
    - (select floor(sum(amount)) from trans	where account_id = 396 and type = 'VYDAJ')) 
    as 'difference'
from trans
where account_id = 396
limit 1;

select account_id, 
	(select floor(sum(amount)) from trans
	where account_id = 9707 and type = 'PRIJEM') as 'PRIJEM',
    (select floor(sum(amount)) from trans
	where account_id = 9707 and type = 'VYDAJ') as 'VYDAJ',
    ((select floor(sum(amount)) from trans where account_id = 9707 and type = 'PRIJEM') 
    - (select floor(sum(amount)) from trans	where account_id = 9707 and type = 'VYDAJ')) 
    as 'difference'
from trans
where account_id = 9707
limit 1;

