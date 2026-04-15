#Calculate the percentage of emails sent to each account from the total number sent each month (number of emails sent to the account per month / total number of emails sent to all accounts per month).
#Determine the date of the first and last email sent for each account in the month.

SELECT DISTINCT
 sent_month,
 id_account,
 sent_msg_percent_from_this_month,
 first_sent_date,last_sent_date
FROM(
SELECT DISTINCT real_date,sent_month,id_account,
COUNT(*) OVER(PARTITION BY sent_month,id_account) AS sent_cnt,
COUNT(*) OVER (PARTITION BY sent_month) AS all_cnt,
COUNT(*) OVER(PARTITION BY sent_month,id_account)/COUNT(*) OVER (PARTITION BY sent_month)*100 AS sent_msg_percent_from_this_month,
 MIN(real_date) OVER (PARTITION BY id_account, sent_month) AS first_sent_date,
  MAX(real_date) OVER (PARTITION BY id_account, sent_month) AS last_sent_date
FROM(
SELECT DISTINCT id_account,
DATE_TRUNC(DATE_ADD(ss.date, INTERVAL es.sent_date DAY), MONTH) AS sent_month,id_message,
DATE_ADD(ss.date, INTERVAL es.sent_date DAY) AS real_date
FROM `DA.email_sent` es
JOIN `DA.account` acc
ON acc.id=es.id_account
JOIN `DA.account_session` acs
ON acc.id=acs.account_id
JOIN `DA.session` ss
ON acs.ga_session_id=ss.ga_session_id)sent_month_date)persantage;




