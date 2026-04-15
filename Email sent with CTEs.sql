WITH data AS(


SELECT DATE_TRUNC(DATE_ADD(ss.date, INTERVAL es.sent_date DAY), MONTH) AS sent_month,
id_message,id_account,
DATE_ADD(ss.date,INTERVAL es.sent_date DAY) AS real_date --message sending dates
FROM `DA.email_sent` es
JOIN `DA.account` a
ON es.id_account=a.id
JOIN `DA.account_session` acs
ON a.id=acs.account_id
JOIN `DA.session` ss
ON acs.ga_session_id=ss.ga_session_id),
acc_month AS(


SELECT id_account,COUNT(id_message) AS message,sent_month,
MIN(real_date),
 MAX(real_date) --letters by account and month
FROM data
GROUP BY sent_month, id_account),
months_total AS (


SELECT sent_month,
COUNT(id_message) AS total_message_month --всього листів місяць
FROM data
GROUP BY sent_month),
final AS (
  SELECT data.sent_month,data.id_account,message/total_message_month*100 AS sent_msg_percent_from_this_month,MIN(real_date) AS first_sent_date, MAX(real_date) AS last_sent_date
  FROM data
  JOIN acc_month
  ON data.sent_month = acc_month.sent_month AND data.id_account = acc_month.id_account
  JOIN months_total
  ON acc_month.sent_month=months_total.sent_month
 GROUP BY data.sent_month, data.id_account, message, total_message_month)


  SELECT sent_month,id_account,sent_msg_percent_from_this_month,first_sent_date,last_sent_date
  FROM final;
