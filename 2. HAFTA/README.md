# SQL Bootcamp - 2. Hafta Ödevi  

**Amaç**:

Bu ödevin amacı, *Chinook* veritabanında *Invoice* (Fatura) tablosu üzerinde SQL sorgulama becerilerini geliştirmek, farklı SQL işlemlerini uygulamak ve verileri anlamlandırmaktır.  

---

*1. Tüm değerleri NULL olan kayıtların sayısını bulun.*  

*SQL Sorgusu:*  
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

*Açıklama:*  
- Bu sorgu, *Invoice* tablosunda *tüm sütunları NULL olan* kayıtların sayısını belirler.  
- *COUNT(*)* fonksiyonu, belirtilen koşula uyan satırları sayar.  

*Row Sayısı:*  
> *0 veya 1* (Veritabanındaki verilere bağlı olarak değişebilir.)

---

*2. Total değerlerinin iki katını görmek ve eski versiyonlarıyla karşılaştırmak.*  

*SQL Sorgusu:*  
```sql
SELECT invoice_id, customer_id, total, total * 2 AS total_double
FROM Invoice
ORDER BY total_double DESC;
```

*Açıklama:*  
- *total* sütununun iki katını alarak *total_double* adlı yeni bir sütun oluşturur.  
- *ORDER BY total_double DESC* ile sonuçları büyükten küçüğe sıralar.  

*Row Sayısı:*
> *1 - 412* (Veritabanındaki toplam fatura sayısına göre değişebilir.)

---

*3. Adres kolonundaki verileri soldan 3 karakter ve sağdan 4 karakter alarak birleştirin ve "Açık Adres" olarak yazın.*  

- *2013 yılı Ağustos ayına* ait faturaları filtreleyin.  

*SQL Sorgusu:*  
```sql
SELECT 
    CONCAT(SUBSTRING(billing_address FROM 1 FOR 3), SUBSTRING(billing_address FROM LENGTH(billing_address) - 3 FOR 4)) AS "Açık Adres"
FROM Invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2013
  AND EXTRACT(MONTH FROM invoice_date) = 8;
```

*Açıklama:*  
- *billing_address* sütununun *ilk 3* ve *son 4* karakterini alır.  
- *CONCAT* fonksiyonu ile bu iki parçayı birleştirerek *"Açık Adres"* sütunu oluşturur.  
- *EXTRACT(YEAR FROM invoice_date) = 2013* ile *2013 yılı*, *EXTRACT(MONTH FROM invoice_date) = 8* ile *Ağustos ayı* filtrelenir.  

*Row Sayısı:*  
> *1 - 7* (2013 Ağustos ayında kaç fatura kesildiğine bağlı olarak değişebilir.)  

---

Bu ödevde, *Invoice* tablosunda farklı SQL sorguları kullanılarak veri analizi gerçekleştirilmiştir. 🚀
