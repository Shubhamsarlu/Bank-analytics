create database bank_analysis;
use bank_analysis;
select * from finance_1;
select * from finance_2;

#1 Total Loan Amount in Millions
select 
concat(round(sum(loan_amnt)/1000000)," Million") as Total_Loan_Amount 
from finance_1;

#2 Total loan issued 
select 
concat(round(count(id)/100,1)," K") as Total_No_of_Loans_issued 
from finance_1; 

#3 Average interest rate
SELECT 
    concat(round(AVG(int_rate), 2)," %" ) AS Average_Interest_Rate
FROM
    finance_1;

#4 Total Funded Amount
select 
concat(round(sum(funded_amnt)/1000000,3)," Million") as Total_Funded_Amount 
from finance_1;

#5 Total Revolving Balance
select 
concat(round(sum(revol_bal)/1000000,2)," Million") as Total_Revolving_Bal 
from finance_2;

#6 Total Number of Accounts
select 
concat(round(sum(total_acc)/1000,2)," k") as Total_No_of_Accounts 
from finance_2; 

#7 Yearwise loan Amount Status
select 
year(issue_d) as years,concat(round(sum(loan_amnt)/1000000)," M")  as Loan_Amount 
from finance_1
group by years
order by years;

#8 Grade and sub grade wise revol_bal
SELECT 
    grade,
    sub_grade,
    CONCAT(ROUND(SUM(revol_bal)/1000, 2), " K") AS Revolving_Balance
FROM finance_1 AS f1
INNER JOIN finance_2 AS f2 ON f1.id = f2.id
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade;

#9 Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT 
    verification_status,
    CONCAT(ROUND(SUM(total_pymnt)/100000, 2), "M") AS Total_Payment
FROM finance_1 f1
JOIN finance_2 f2 ON f1.id = f2.id
GROUP BY verification_status
ORDER BY Total_Payment DESC;

#10 State wise and month wise loan status
select 
addr_state, loan_status, count(loan_status) as loans
from finance_1
group by addr_state, loan_status
order by addr_state,loan_status ;

select 
monthname(issue_d) Month_Name,loan_status,count(f1.loan_status) as loan_status
from finance_1 as f1 join finance_2 as f2 on f1.id = f2.id
group by Month_Name,loan_status,month(issue_d)
order by month(issue_d) ;

#11 Home ownership Vs last payment date stats
SELECT 
    YEAR(Last_pymnt_d) AS Payment_Year,
   monthname(Last_pymnt_d) AS Payment_Month,
    home_ownership,
    COUNT(*) AS Total_Loans
FROM finance_1  f1
 JOIN finance_2  f2 ON f1.id = f2.id
WHERE Last_pymnt_d IS NOT NULL
GROUP BY Payment_Year, Payment_Month, home_ownership
ORDER BY Payment_Year DESC, monthname(Last_pymnt_d), home_ownership;

#12   Yearly Interest Received
SELECT 
    YEAR(last_pymnt_d) AS Received_Year,
    CONCAT(ROUND(SUM(total_rec_int)/1000000, 2), "M") AS Interest_Received
FROM finance_2
WHERE last_pymnt_d IS NOT NULL
GROUP BY YEAR(last_pymnt_d)
ORDER BY Received_Year IS NOT NULL;
#13  Top 5 States by customers
SELECT 
    addr_state AS State_Name,
    COUNT(*) AS Customers
FROM finance_1
GROUP BY addr_state
ORDER BY COUNT(*) DESC
LIMIT 5;


#14 Overall Report
select * from finance_1 f1
inner join finance_2 f2 on f1.id=f2.id;

