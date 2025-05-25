# 🚀 **TurkStudentCo - Kapsamlı SQL Ödevleri ve Çevrimiçi Eğitim Platformu Veritabanı Mimarisi**

Merhaba ve projemize hoş geldiniz! 🎉 Bu depo, **TurkStudentCo SQL Eğitim Programı** kapsamında titizlikle hazırlanan SQL ödev setlerini ve özellikle **PostgreSQL tabanlı, detaylı bir Çevrimiçi Eğitim Platformu Veritabanı Mimarisi**ni sunmaktadır. Başlangıç seviyesinden en karmaşık senaryolara kadar, profesyonel bir veritabanı tasarımı ve yönetimi anlayışı kazanmanız hedeflenmektedir.

Bu proje, modern bir çevrimiçi eğitim platformunun gereksinimlerini karşılamak üzere, kapsamlı bir analiz ve işbirliği sürecinin ürünüdür. Amacımız, hem teorik bilgiyi pekiştirmek hem de gerçek dünya uygulamalarına yönelik pratik deneyim kazandırmaktır.

## 🏆 **Haftalık SQL Eğitim İçerikleri**

Eğitim programı, SQL'in temel prensiplerinden gelişmiş tekniklerine kadar geniş bir yelpazeyi kapsar:

🔹 **1. Hafta: SQL’e Giriş ve Temel Veritabanı Komutları**
- 💡 Veritabanı sorgulamanın temeli: `SELECT` komutunun kullanımı.
- 🔍 Veri filtreleme ve sıralama: `WHERE` ve `ORDER BY` cümleçleri.
- ⚡ Veri Manipülasyonu: `INSERT`, `UPDATE`, `DELETE` komutlarının etkin kullanımı.
- ✨ Veritabanı yapısı oluşturma: `CREATE TABLE` ile tablo tanımlama ve `DROP TABLE` ile kaldırma.

🔹 **2. Hafta: İleri Seviye Veri Filtreleme ve Gruplama**
- ✅ Verileri anlamlı gruplara ayırma: `GROUP BY` ve `HAVING` cümleçleri.
- 🚀 Tekrar eden kayıtları eleme: `DISTINCT` anahtar kelimesi.
- 🎯 Sorgu sonuçlarını sınırlama ve sayfalama: `LIMIT` ve `OFFSET` kullanımı.

🔹 **3. Hafta: Tablo Birleştirme (JOIN) İşlemleri ve Alt Sorgular**
- 🔗 İlişkisel veri tabanlarının gücü: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN` türleri ile tablo birleştirme.
- 🔍 Karmaşık veri çekme: Alt sorgular (Subqueries) ve `EXISTS`, `ANY`, `ALL` operatörleri.
- 💎 Verimli ve esnek sorgular: İç içe sorgular (`Nested Queries`) ile derinlemesine veri analizi.

🔹 **4. Hafta: Çevrimiçi Eğitim Platformu Veritabanı Mimarisi - Kapsamlı Şema Tasarımı**
Bu bölümde, PostgreSQL üzerinde geliştirilen Çevrimiçi Eğitim Platformu'nun **detaylı ve ilişkisel veritabanı şeması** sunulmaktadır. Tasarım, platformun tüm işlevsel gereksinimlerini karşılamak üzere modüler ve genişletilebilir bir yapıda oluşturulmuştur:

-   **Üyeler (Members)**: Platform kullanıcılarının (öğrenciler, eğitmenler, yöneticiler) temel kimlik, iletişim, profil ve rol bilgilerini barındırır.
-   **Kategoriler (Categories)**: Eğitim kurslarının sınıflandırılması için kullanılan kategorileri tanımlar.
-   **Eğitmenler (Instructors)**: Platformdaki eğitmenlerin özel bilgilerini (uzmanlık alanı, biyografi) `Members` tablosuyla ilişkilendirerek saklar.
-   **Eğitimler (Courses)**: Sunulan eğitimlerin başlık, açıklama, tarih aralıkları, eğitmen ve kategori bağlantıları gibi ana detaylarını içerir.
-   **Dersler (Lessons)**: Her bir kursun alt modüllerini oluşturan derslerin içerik, video URL'leri, süre ve kurs içindeki sıralama bilgilerini barındırır.
-   **Quizler (Quizzes)**: Derslere bağlı sınavlar ve değerlendirmeler için quiz bilgilerini tutar.
-   **Sorular (Questions)**: Quize ait soruların metnini ve soru tipini belirler.
-   **Cevaplar (Answers)**: Her bir soruya ait cevap seçeneklerini ve doğru cevabı işaretler.
-   **Katılımlar (Enrollments)**: Üyelerin hangi kurslara kayıt olduğunu ve kayıt tarihlerini izler.
-   **Üye İlerleme Takibi (MemberProgress)**: Üyelerin derslerdeki tamamlanma durumlarını, quiz puanlarını ve ilerleme tarihlerini kaydeder.
-   **Sertifikalar (Certificates)**: Başarıyla tamamlanan kurslar için verilen sertifikaların benzersiz kodlarını ve yayınlanma tarihlerini içerir.
-   **Sertifika Atamaları (CertificateAssignments)**: Üyelere atanan spesifik sertifikaları ve atama tarihlerini yönetir.
-   **Kurs Yorumları ve Değerlendirmeleri (Reviews)**: Üyelerin tamamladıkları kurslar hakkındaki yorumlarını, puanlamalarını ve geri bildirimlerini toplar.
-   **Blog Gönderileri (BlogPosts)**: Platformdaki blog içeriklerini (başlık, içerik, yazar) barındırır.
-   **Blog Yorumları (BlogComments)**: Blog gönderilerine yapılan yorumları, yorum yapan üyeyi ve yorum içeriğini kaydeder.

## 📊 **Varlık İlişki Diyagramı (ERD)**

Bu detaylı veritabanı mimarisinin görsel bir temsilini sunan Varlık İlişki Diyagramı (ERD), tablolar arası ilişkileri ve veri akışını net bir şekilde anlamanıza yardımcı olacaktır.

[Buraya ERD'nin Yüksek Çözünürlüklü Görsel Bağlantısını Koyun Veya dbdiagram.io Üzerindeki Projenize Bağlantı Verin]
(Örn: `https://i.imgur.com/your_erd_image.png` veya `https://dbdiagram.io/d/your_project_live_link`)

## 🔑 **Veritabanı Anahtarlarının Önemi:**

✅ **Birincil Anahtar (Primary Key - PK)**: Her bir tabloda benzersiz bir satır tanımlayıcısı olarak görev yapar. Veri tekrarını önler ve hızlı erişim sağlar.  
✅ **Yabancı Anahtar (Foreign Key - FK)**: Tablolar arasında referanssal bütünlüğü sağlayarak mantıksal ilişkileri kurar. Bu anahtarlar, veritabanı modelimizin tutarlılığını ve ilişkisel gücünü temin eder.

## 💡 **Projeyi Kullanmaya Başlama Rehberi**

Bu projeyi yerel ortamınızda kurmak ve kullanmak için aşağıdaki adımları takip edebilirsiniz:

1️⃣ **Depoyu Klonlayın veya İndirin:**

```bash
    git clone [https://github.com/bushranovaaa/TurkStudentCo-SQL-Odevleri.git](https://github.com/bushranovaaa/TurkStudentCo-SQL-Odevleri.git)
    cd TurkStudentCo-SQL-Odevleri/CevrimiciEgitimPlatformu
```

2️⃣ **Veritabanı Şemasını Oluşturun:**
- Projenin içerisinde yer alan database_schema.sql dosyasını (kapsamlı DDL kodlarımızı içeren) favori PostgreSQL istemciniz (örneğin PgAdmin, psql komut satırı) veya dbdiagram.io gibi bir veritabanı görselleştirme aracı üzerinden çalıştırarak tüm veritabanı yapısını anında oluşturabilirsiniz.
- Bu SQL dosyası, tüm tabloları, ilişkileri ve gerekli kısıtlamaları içermektedir.

3️⃣ **SQL Ödevlerini ve Sorguları Test Edin:**
- Hafta bazında düzenlenmiş örnek queries.sql dosyalarını inceleyerek ve çalıştırarak SQL bilginizi pekiştirebilir ve pratik yapabilirsiniz.

## 🎯 Projenin Temel Hedefleri
Bu kapsamlı proje sayesinde aşağıdaki ana hedeflere ulaşmanız amaçlanmaktadır:

- 🔥 SQL sorgularını en verimli ve profesyonel seviyede yazabilme yeteneği kazanmak.
- 🚀 Gerçekçi ve kompleks bir çevrimiçi eğitim platformu için veritabanı modellemesini baştan sona tasarlama ve başarıyla implemente etme deneyimi elde etmek.
- 📊 Veritabanı optimizasyonu, indeksleme stratejileri ve performans arttırma teknikleri konularında derinlemesine bilgi sahibi olmak.
- 📈 Büyük veri setlerinde hızlı, etkin ve ölçeklenebilir sorgulamalar gerçekleştirme becerisini geliştirmek.

## ✨ İletişim & Katkıda Bulunma
Projeye katkıda bulunmak, iyileştirmeler önermek veya yeni özellikler eklemek isterseniz, Pull Request (Çekme İsteği) göndermekten çekinmeyin. Fikirleriniz ve katkılarınız bu projenin gelişiminde büyük değer taşımaktadır.

[![GitHub](https://img.shields.io/badge/GitHub-000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/bushranovaaa)  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/bushranovaaa/)  
[![Mail](https://img.shields.io/badge/E-posta-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:kurtbusra956@gmail.com)  

Unutmayın: database_schema.sql dosyasını oluşturmayı ve ERD görselini veya linkini README.md'ye eklemeyi unutma!