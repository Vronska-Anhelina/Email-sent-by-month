SELECT
  year,
  month,
  SUM(revenue) AS revenue,
  SUM(cost) AS cost
FROM (SELECT EXTRACT(year FROM ss.date) AS year,
EXTRACT(month FROM ss.date) AS month,
SUM(pr.price) AS revenue,0 AS cost
FROM `data-analytics-mate.DA.order` o
JOIN `DA.session` ss
ON o.ga_session_id=ss.ga_session_id
JOIN `DA.product` pr
ON o.item_id=pr.item_id
group by year,month
UNION ALL
SELECT EXTRACT(year FROM psc.date) AS year,
EXTRACT(month FROM psc.date) AS month,
0 AS revenue,SUM(psc.cost) AS cost
FROM `DA.paid_search_cost` psc
group by year,month
)
GROUP BY year, month
ORDER BY year, month;
