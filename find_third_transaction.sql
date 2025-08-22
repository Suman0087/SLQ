CREATE TABLE transactions (
  user_id INT,
  spend DECIMAL(10,2),
  transaction_date TIMESTAMP
);

INSERT INTO transactions (user_id, spend, transaction_date)
VALUES
	(111, 100.50, '2022-01-08 12:00:00'),
  	(111, 55, '2022-01-10 12:00:00'),
  	(121, 36, '2022-01-18 12:00:00'),
  	(145, 24.99, '2022-01-26 12:00:00'),
  	(111, 89.60, '2022-02-05 12:00:00');

SELECT * FROM transactions;

-- Find user's third transaction
-- method 1
select user_id, spend, transaction_date  
from (
select user_id, spend, transaction_date,
row_number() over (partition by user_id order by transaction_date) as trans_count
from transactions
) as t
where trans_count = 3
-- method2
with transaction_count_cte as (
select user_id, spend, transaction_date,
row_number() over (partition by user_id order by transaction_date) as trans_count
from transactions
)

select user_id, spend, transaction_date from transaction_count_cte
where trans_count = 3