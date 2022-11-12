use bank;

#1
select client_id from client
where district_id = 1
limit 5;
#2
select max(client_id) from client
where district_id = 72;
#3
select amount from loan
order by amount asc
limit 3;
#4
select distinct status from loan
order by status asc;
#5
select loan_id from loan
order by payments desc
limit 1;
#6
select account_id, amount from loan
order by account_id asc
limit 5;
#7
select account_id from loan
where duration = 60
order by amount asc
limit 5;
#8
select distinct k_symbol from `order`
where nullif(k_symbol,'') is not null;
#9
select order_id from `order`
where account_id = 34;
#10
select distinct account_id from `order`
where order_id between 29540 and 29560;
#11
select sum(amount) from `order`
where account_to = 30067122;
#12
select trans_id, date, type, amount from trans
where account_id = 793
order by date desc
limit 10;
#13
select district_id, count(client_id) from client
where district_id < 10
group by district_id
order by district_id asc;
#14
select type, count(card_id) from card
group by type
order by count(card_id) desc;
#15
select account_id, sum(amount) from loan
group by account_id
order by sum(amount) desc
limit 10;
#16
select date, count(loan_id) from loan
where date < 930907
group by date
order by date desc;
#17
select date, duration, count(loan_id) from loan
where date between 971201 and 971231
group by date, duration
order by date asc;
#18
select account_id, type, sum(amount) from trans
where account_id = 396
group by type;
#19
select account_id, 
case 
	when type = 'PRIJEM' then 'INCOMING'
    when type = 'VYDAJ' then 'OUTGOING'
end as 'transaction_type',
floor(sum(amount)) as total_amount
from trans
where account_id = 396
group by type;
#20
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
#20
select account_id,
sum(case
	when type = 'PRIJEM' then floor(amount)
	end) as 'INCOMING',
sum(case
	when type = 'VYDAJ' then floor(amount)
	end) as 'OUTGOING',
(sum(case when type = 'PRIJEM' then floor(amount) end) 
- sum(case when type = 'VYDAJ' then floor(amount) end)) as 'difference'
from trans
where account_id = 396;
#21
select account_id,
(sum(case when type = 'PRIJEM' then floor(amount) end) 
- sum(case when type = 'VYDAJ' then floor(amount) end)) as 'difference'
from trans
group by account_id
order by difference desc
limit 10;

select account_id,
   round(sum(case when type = 'prijem' then amount else 0 end)) 
   - round(sum(case when type = 'vydaj' then amount else 0 end)) as balance
from bank.trans
group by account_id
order by balance DESC
limit 10;