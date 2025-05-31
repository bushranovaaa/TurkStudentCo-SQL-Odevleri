# 📊 Tablo Oluşturma Adımları ve Veri Sözlüğü

Bu belge, PostgreSQL / pgAdmin ortamında tablo oluşturma sürecini ve oluşturulacak "invoices" tablosunun veri sözlüğünü içerir.

---

## 🔹 Tablo Oluşturma Adımları

### 1. Server Kaydı
- `Servers` üzerine sağ tıklanır.
- “Register Server” seçilir.

### 2. Server Adı Belirleme
- Açılan pencerede bir sunucu adı (örneğin `Localhost`) girilir.

### 3. Bağlantı Bilgileri
- `Connection` sekmesine geçilir.
- `Host`: `localhost`
- `Password`: Kurulum sırasında belirlediğin şifre yazılır.
- “Save Password” kutucuğu işaretlenip “Save” denir.

### 4. Database Üzerinden Table Ekleme
- Sol menüde database seçilir.
- `Schemas > Tables` yolunu takip et.
- “Tables” üzerinde sağ tıklayıp **Query Tool** açılır.

### 5. SQL Dosyasını Yükleyip Çalıştırma
- Query Tool’da üstteki dosya simgesine tıklanır.
- `hafta2.sql` veya `odev_csv_aktarma.sql` dosyası seçilir.
- Kodlar geldiğinde `F5` tuşuna basarak çalıştırılır.
- Tables klasöründe görünmüyorsa, sağ tıklayıp `Refresh` yapılır.

---

## 📑 Oluşturulacak Tablo: `invoices`

### 📌 SQL Kod Örneği

```sql
CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_date TIMESTAMP,
    billing_adress VARCHAR(50),
    billing_city VARCHAR(20),
    billing_state VARCHAR(10),
    billing_country VARCHAR(15),
    billing_postal_code VARCHAR(20),
    total FLOAT
);
```

---

## 📘 Veri Sözlüğü: `invoices` Tablosu

| Sütun Adı              | Veri Tipi    | Açıklama                                                                 |
|------------------------|--------------|--------------------------------------------------------------------------|
| `invoice_id`           | INT          | Fatura kimlik numarası. Her fatura için benzersiz bir değer.             |
| `customer_id`          | INT          | Müşteri kimlik numarası. Her müşteri için benzersiz bir değer.           |
| `invoice_date`         | TIMESTAMP    | Fatura tarihi ve saati.                                                  |
| `billing_adress`       | VARCHAR(50)  | Fatura adresi. Müşterinin fatura gönderim adresi.                        |
| `billing_city`         | VARCHAR(20)  | Fatura şehri. Müşterinin fatura şehri.                                   |
| `billing_state`        | VARCHAR(10)  | Fatura ili. Müşterinin fatura ili.                                       |
| `billing_country`      | VARCHAR(15)  | Fatura ülkesi. Müşterinin fatura adresinin bulunduğu ülke.              |
| `billing_postal_code`  | VARCHAR(20)  | Fatura posta kodu. Müşterinin fatura adresinin posta kodu.              |
| `total`                | FLOAT        | Fatura toplam tutarı.                                                    |

---

> 💡 Bu belgeyi `ver_sözlüğü.md` veya `tablo_olusturma_adimlari.md` adıyla kaydedip GitHub'a yükleyebilirsin.

---
