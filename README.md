<<<<<<< HEAD
# 📌 TurkStudentCo - SQL Ödevleri  

Bu repo, *TurkStudentCo SQL Eğitim Programı* kapsamında yapılan ödevleri içerir. 📊  
Ödevler, SQL'in temel ve ileri seviye konularını kapsayarak veritabanı yönetimi becerilerini geliştirmek amacıyla hazırlanmıştır.  

---

📅 Haftalık İçerik  

🔹 *1. Hafta: SQL’e Giriş & Temel Komutlar*  
   - `SELECT`, `WHERE`, `ORDER BY` kullanımları  
   - `INSERT`, `UPDATE`, `DELETE` komutları  
   - *Tablo oluşturma (`CREATE TABLE`) ve silme (`DROP TABLE`)*  

🔹 *2. Hafta: Veri Filtreleme ve Sıralama*  
   - `GROUP BY` ve `HAVING` ile veri gruplama  
   - `DISTINCT` ile tekrar eden verileri engelleme  
   - `LIMIT` ve `OFFSET` kullanımı  

🔹 *3. Hafta: JOIN İşlemleri ve Alt Sorgular*  
   - `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN` kullanımı  
   - Alt sorgular (`Subqueries`) ve `EXISTS`, `ANY`, `ALL` komutları  
   - *Nested Queries (İç içe sorgular) ile veri çekme*  

🔹 *4. Hafta:


---

🚀 Nasıl Kullanılır?  

1. *Projeyi klonlayın veya indirin:*  
   ```bash
   git clone https://github.com/bushranovaaa/TurkStudentCo-SQL-Odevleri.git
   cd TurkStudentCo-SQL-Odevleri
   ```
2. *SQL dosyalarını çalıştırın:*  
   - MySQL veya PostgreSQL gibi bir veritabanı yöneticisi açın  
   - `schema.sql` dosyasını çalıştırarak veritabanını oluşturun  
   - `queries.sql` dosyası ile ödevleri test edin  

---

🎯 Hedefler  
Bu ödevler sayesinde:  
✅ *SQL sorgularını etkin bir şekilde yazabileceksin.*  
✅ *Veritabanı optimizasyonu yapmayı öğreneceksin.*  
✅ *Büyük veri setlerinde hızlı sorgulamalar gerçekleştirebileceksin.*  

---

📬 İletişim & Katkı  
Eğer projeye katkı sağlamak istersen *pull request* gönderebilirsin. 💡  
📩 *İletişim:* [kurtbusra956@gmail.com](mailto:kurtbusra956@gmail.com)
=======
# 🎓 PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı

Bu repo, PostgreSQL kullanılarak geliştirilmiş **Çevrimiçi Eğitim Platformu** veritabanı tasarımını içermektedir. Platform, kullanıcıların eğitimlere katılmasını, sertifikalar kazanmasını ve blog paylaşımlarıyla seviyelerini artırmasını sağlamayı amaçlamaktadır.

## 📌 Proje İçeriği

Projede aşağıdaki işlevleri destekleyen veritabanı yapısı oluşturulmuştur:

✅ **Kullanıcılar** üye olabilir, giriş yapabilir.  
✅ **Eğitimlere** katılıp tamamladıktan sonra sertifika kazanabilirler.  
✅ **Blog paylaşımı** yaparak platformda aktif rol alabilirler.  
✅ **Eğitimler**, kategorilere ayrılmış olup daha sistemli bir yapı sunar.

**Veritabanında bulunan tablolar**:

| Tablo               | Açıklama                                                                 |
|---------------------|--------------------------------------------------------------------------|
| **Members**          | Kullanıcı bilgileri (kullanıcı adı, e-posta, şifre, kayıt tarihi vb.).  |
| **Categories**       | Eğitimlerin ait olduğu kategori bilgileri (ör. yapayzeka, blokzincir).  |
| **Courses**          | Eğitim bilgileri (adı, açıklama, tarih aralığı, eğitmen bilgisi vb.).    |
| **Enrollments**      | Üyelerin eğitimlere kayıt bilgilerini yönetir (çok-çok ilişki).         |
| **Certificates**     | Kullanıcıların aldığı sertifika bilgilerini içerir.                      |
| **CertificateAssignments** | Hangi kullanıcının hangi sertifikayı aldığını gösterir.            |
| **BlogPosts**        | Kullanıcıların blog gönderileri paylaşmasını sağlar.                     |

📌 **Şema diyagramı** için `ER_Diagram.png` dosyasına bakabilirsiniz.

## 🛠 Kurulum ve Çalıştırma

Bu projeyi çalıştırmak için PostgreSQL yüklü olması gerekmektedir. Adımları takip ederek veritabanını oluşturabilirsin:

1️⃣ **Depoyu Klonla**  
```bash
git clone https://github.com/bushranovaaa/TurkStudentCo-SQL-Odevleri.git
cd TurkStudentCo-SQL-Odevleri
```

2️⃣ **PostgreSQL Sunucusunu Başlat**  
Eğer PostgreSQL yüklü değilse, [PostgreSQL'in resmi web sitesinden](https://www.postgresql.org/) indirebilirsin.

3️⃣ **Veritabanını Oluştur**  
```bash
psql -U postgres
CREATE DATABASE online_education;
```

4️⃣ **SQL Dosyasını Çalıştır**  
```bash
psql -U postgres -d online_education -f online_education_platform.sql
```

Bu komut ile tüm tablolar oluşturulacak ve ilişkiler kurulacaktır.

## 📊 Veritabanı Şema Görselleştirmesi

Projede oluşturulan tabloların ve ilişkilerin gösterildiği **ER diyagramı** şu şekildedir:

🖼 `ER_Diagram.png` dosyasını inceleyerek tablolar arası ilişkileri görselleştirebilirsin.

## 📂 Dosya Yapısı

```
TurkStudentCo-SQL-Odevleri/
│
├── README.md                # Açıklamalar ve kurulum adımları
├── online_education_platform.sql  # Veritabanı şeması SQL dosyası
└── ER_Diagram.png           # Veritabanı ilişkilerini gösteren diyagram
```

## 🏆 Değerlendirme Kriterleri

Projenin başarılı şekilde teslim edilebilmesi için aşağıdaki kriterlere dikkat edilmelidir:

✔️ **Veritabanı tasarımının doğruluğu ve tutarlılığı.**  
✔️ **İhtiyaçlara uygun tabloların ve ilişkilerin modellenmesi.**  
✔️ **Birincil Anahtar (PK), Yabancı Anahtar (FK) ve Benzersiz Anahtar (UK) kısıtlamalarının doğru kullanımı.**  
✔️ **Veritabanı şemasının görsel olarak anlaşılır şekilde sunulması.**  
✔️ **GitHub deposunun doğru yapılandırılması** (repo oluşturma, dosya yükleme, public yapma).

## 🤝 Katkıda Bulunma

Projeye katkıda bulunmak istersen şu adımları takip edebilirsin:

1️⃣ **Projeyi Forkla**  
2️⃣ **Yeni özellik ekleyip commit gönder**  
3️⃣ **Pull Request açarak değişikliklerini öner**

💡 **Öneriler veya hatalar** için Issues bölümüne geri bildirim bırakabilirsin.

---
>>>>>>> 47508d4 (Çevrimiçi Eğitim Platformu Projesi eklendi)
