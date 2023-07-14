use finance_analysis;
select * from accounts;
select * from branches;
select * from customers;
select * from transactions;

-- 1. What are the names of all the customers who live in New York?
select concat(firstname, " ", lastname) Name, city
from customers
where city = "New York";

-- 2. What is the total number of accounts in the Accounts table?
select count(accountid) accounts
from accounts;

-- 3. What is the total balance of all checking accounts?
select accounttype, sum(balance) balance
from accounts
where accounttype = "checking";

-- 4. What is the total balance of all accounts associated with customers who live in Los Angeles?
select sum(balance) total_balance,city
from accounts
inner join customers
using (customerid)
where city = "Los Angeles";

-- 5. Which branch has the highest average account balance?
select avg(balance), branchname
from accounts
inner join branches
using (branchid)
group by branchname
order by avg(balance) desc
limit 1;

-- 6. Which customer has the highest current balance in their accounts?
select customerid, concat(firstname, " ", lastname) Name, balance
from accounts
inner join customers
using (customerid)
group by customerid
order by balance desc
limit 1;

-- 7. Which customer has made the most transactions in the Transactions table?
select customerid, count(transactionid) transactions
from transactions
inner join accounts
using(accountid)
group by customerid
order by transactions desc;

-- 8.Which branch has the highest total balance across all of its accounts?
select branchname,sum(balance) balance
from accounts
inner join branches
using (branchid)
group by branchname
order by sum(balance) desc
limit 1;


-- 9. Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
select customerid, concat(firstname, " ", lastname) Name, sum(balance) total_balance
from accounts
inner join customers
using (customerid)
where accounttype in ("savings" and "checking")
group by accounttype
order by balance desc
limit 1; 

-- 10. Which branch has the highest number of transactions in the Transactions table?
select branchname, count(transactionid) transactions
from transactions
inner join accounts
using(accountid)
inner join branches
using(branchid)
group by branchname
order by transactions desc
limit 1;
