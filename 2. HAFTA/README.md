# SQL Bootcamp - 2. Hafta Ödevi

## Amaç
Bu ödevin amacı, veritabanı sorgulama becerilerini geliştirmek ve farklı SQL işlemlerini uygulamak. Turkstudentco’da veri bilimci olarak Chinook veritabanındaki Invoice tablosu üzerinde sorgular yazmak isteniyor.

## Sorular ve Çözümler

### 1. **Invoice tablosunda, tüm değerleri NULL olan kayıtların sayısını bulun.**

SQL Sorgusu:
```sql
SELECT COUNT(*) 
FROM Invoice 
WHERE invoice_id IS NULL 
  AND customer_id IS NULL 
  AND invoice_date IS NULL 
  AND billing_address IS NULL 
  AND billing_city IS NULL 
  AND billing_state IS NULL 
  AND billing_country IS NULL 
  AND billingpostal_code IS NULL 
  AND total IS NULL;
```

Açıklama: Bu sorgu, Invoice tablosundaki tüm değerleri NULL olan kayıtların sayısını bulur. COUNT(*) fonksiyonu, bu koşullara uyan tüm satırları sayar.

**Row Sayısı:** 1 (Bu sayı veritabanındaki kayıtlara göre değişebilir.)


2. Total değerlerinin iki katını görmek ve eski versiyonlarıyla karşılaştırmak.
SQL Sorgusu:

```sql
SELECT invoice_id, customer_id, total, total * 2 AS total_double
FROM Invoice
ORDER BY total_double DESC;
```
**Row Sayısı:** 1 ila 412 (Bu, veritabanındaki toplam fatura sayısına göre değişebilir.)

Açıklama: Bu sorgu, total kolonundaki değeri iki katına çıkararak yeni bir kolon oluşturur (total_double). Ardından, total_double kolonuna göre büyükten küçüğe sıralama yapılır.

## 3. Adres kolonundaki verileri soldan 3 karakter ve sağdan 4 karakter alarak birleştirin ve "Açık Adres" olarak yazın. 

Ayrıca, bu yeni açık adresi 2013 yılı ve 8. ay’a göre filtreleyin.
SQL Sorgusu:

```sql
SELECT 
    CONCAT(SUBSTRING(billing_address FROM 1 FOR 3), SUBSTRING(billing_address FROM LENGTH(billing_address) - 3 FOR 4)) AS "Açık Adres"
FROM Invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2013
  AND EXTRACT(MONTH FROM invoice_date) = 8;
```
**Row Sayısı:** 1 ila 7 (Ağustos 2013'teki faturalar sayısına bağlı olarak değişir.)

**Açıklama:** Bu sorgu, billing_address kolonundaki verilerin ilk 3 ve son 4 karakterini alır ve birleştirerek "Açık Adres" olarak adlandırır. Ayrıca, 2013 yılının Ağustos ayında yapılan kayıtları filtre
