SELECT COUNT(*)
FROM invoice
WHERE invoice_id IS NULL
  AND customer_id IS NULL
  AND invoice_date IS NULL
  AND billing_address IS NULL
  AND billing_city IS NULL
  AND billing_state IS NULL
  AND billing_country IS NULL
  AND billingpostal_code IS NULL
  AND total IS NULL;

  SELECT invoice_id, total,total * 2 AS total_double
  FROM invoice
  ORDER BY total_double DESC;

  SELECT CONCAT(SUBSTRING(billing_address FROM 1 FOR 3), SUBSTRING(billing_address FROM LENGTH(billing_address) - 3 FOR 4)) AS "Açık Adres"
  FROM invoice
  WHERE invoice_date >= '2013-08-01' AND invoice_date < '2013-09-01';