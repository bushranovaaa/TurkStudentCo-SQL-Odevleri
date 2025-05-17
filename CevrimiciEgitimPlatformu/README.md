# 🎓 PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı

🎓 PostgreSQL kullanarak Çevrimiçi Eğitim Platformu için profesyonel bir veritabanı tasarımı! Verilerin hızlı bir şekilde yönetilmesi, düzenlenmesi ve sorgulanması için tasarlanmış veritabanı yapısını keşfetmeye hazır mısın? Bu proje, hem temel SQL bilgilerini geliştirmen hem de büyük veri setlerinde hızlı sorgulamalar yapabilmen için mükemmel bir fırsat!

💡 Kullanıcılar kayıt olabilir, 📚 Eğitimlere katılabilir, 🎖 Sertifikalar kazanabilir, 📝 Blog gönderileri paylaşarak seviyelerini yükseltebilir!

## 💥 Projenin Amacı:

Bu projenin temel amacı, gerçek dünya senaryosuna uygun bir veritabanı tasarlayarak SQL becerilerini geliştirmek, veritabanı optimizasyon tekniklerini öğrenmek ve büyük veri setlerinde etkili sorgulamalar yapabilme yeteneği kazanmaktır. Veritabanı, çevrimiçi bir eğitim platformunun temel veri ihtiyaçlarını (kullanıcılar, kurslar, kayıtlar, sertifikalar, blog içerikleri) karşılayacak şekilde yapılandırılmıştır.

## ⚙️ Veritabanı Tasarımı:

Projede kullanılan PostgreSQL tasarımı, çevrimiçi eğitim platformundaki kullanıcıları, eğitimleri ve etkileşimleri verimli bir şekilde organize etmenize olanak tanır. Veritabanı, ilişkisel modelin gücünü kullanarak veri bütünlüğünü ve tutarlılığını sağlamayı hedefler. Tasarım, kapsamlı sorgulamalar ve hızlı veri analizi için optimize edilmiştir.

## 🎯 Proje Hedefleri:

- SQL Sorgularını Profesyonel Seviyede yazmak ve karmaşık veri manipülasyonları gerçekleştirmek.
- Veritabanı optimizasyonu ve performans arttırma tekniklerini (indeksleme, sorgu planı analizi vb.) anlamak ve uygulamak.
- Büyük veri setlerinde hızlı ve verimli sorgulamalar gerçekleştirmek için etkili veritabanı şemaları oluşturmak.
  
**🎓 Profesyonel bir veritabanı tasarımı oluştur! 🚀 Gerçek dünya senaryosunda PostgreSQL becerilerini geliştir! 📊 Veriyi yönet, analiz et ve optimize et!**

## 🏆 Veritabanı Şeması

**📌 Ana tablolar ve işlevleri:**

* **Üyeler (Members):** Kullanıcıların temel bilgileri (kullanıcı adı, e-posta, şifre, ad, soyad, kayıt tarihi) ve kayıt yönetimi için kullanılır. `username` ve `email` alanları benzersiz (`UNIQUE`) ve boş olamaz (`NOT NULL`).
* **Kategoriler (Categories):** Eğitimleri konu bazlı düzenlemek ve sınıflandırmak için kullanılır. Her kategorinin benzersiz bir adı (`category_name`) vardır.
* **Eğitimler (Courses):** Platformdaki eğitimlerin detaylarını (ad, açıklama, başlangıç/bitiş tarihi, eğitmen, kategori) içerir. `category_id` yabancı anahtarı ile `Categories` tablosuna bağlanır. Başlangıç tarihinin bitiş tarihinden önce olmasını sağlayan bir `CHECK` kısıtlaması bulunur.
* **Katılımlar (Enrollments):** Kullanıcıların hangi eğitimlere kaydolduğunu takip eder. `member_id` ve `course_id` yabancı anahtarları ile `Members` ve `Courses` tablolarına bağlanır. Bir kullanıcının aynı kursa birden fazla kez kaydolmasını engelleyen benzersiz bir kısıtlama (`unique_enrollment`) içerir.
* **Sertifikalar (Certificates):** Tamamlanan eğitimler için verilen sertifikaların bilgilerini (benzersiz kod, veriliş tarihi) içerir. Her sertifikanın benzersiz bir kodu (`certificate_code`) vardır. Ayrıca, hangi kursa ait olduğunu belirten bir `course_id` yabancı anahtarı eklenmiştir.
* **Sertifika Atamaları (CertificateAssignments):** Hangi kullanıcının hangi sertifikayı aldığını kaydeder. `member_id` ve `certificate_id` yabancı anahtarları ile `Members` ve `Certificates` tablolarına bağlanır. Bir kullanıcının aynı sertifikayı birden fazla kez almasını engelleyen benzersiz bir kısıtlama (`unique_cert_assignment`) içerir.
* **Blog Gönderileri (BlogPosts):** Kullanıcıların platformda paylaştığı blog yazılarını (başlık, içerik, yayınlanma tarihi, yazar) içerir. `author_id` yabancı anahtarı ile `Members` tablosuna bağlanır.

## 🔗 İlişkiler ve Kısıtlamalar:

Veritabanındaki tablolar arasındaki ilişkiler ve veri bütünlüğünü sağlayan kısıtlamalar aşağıda detaylandırılmıştır:

* ✅ **Birincil Anahtar (PK):** Her tablo için benzersiz bir kimlik sütunu (`id`, `SERIAL` ile otomatik artan) tanımlanmıştır.
* ✅ **Yabancı Anahtar (FK):** Tablolar arasındaki bağlantıları kurmak için kullanılır. Örneğin, `Enrollments` tablosundaki `member_id` sütunu `Members` tablosundaki `id` sütununa referans verir.
* ✅ **Tekil Anahtar (UK):** Belirli sütunlardaki değerlerin benzersiz olmasını sağlar. `Members` tablosundaki `username` ve `email`, `Categories` tablosundaki `category_name` ve `Certificates` tablosundaki `certificate_code` gibi alanlarda kullanılmıştır.
* ✅ **NOT NULL:** Bir sütunun boş bırakılamayacağını belirtir. Önemli alanlarda veri eksikliğini önler.
* ✅ **CHECK:** Bir sütuna girilecek değerler için belirli bir koşulun sağlanmasını zorunlu kılar. `Courses` tablosundaki `chk_dates` kısıtlaması gibi.

## ✨ Yapılan İyileştirmeler:

Proje, alınan geri bildirimler doğrultusunda veritabanı tasarımını ve işlevselliğini artıran aşağıdaki önemli iyileştirmeleri içermektedir:

* **Silme Davranışları (`ON DELETE`):** Tablolar arası ilişkilerde `FOREIGN KEY` tanımlarına `ON DELETE CASCADE` ve `ON DELETE SET NULL` kısıtlamaları eklenmiştir. Bu kısıtlamalar, ana tablodan bir kayıt silindiğinde ilişkili tablolardaki verilerin ne olacağını otomatik olarak yöneterek veritabanı tutarlılığını sağlar.
    * `ON DELETE CASCADE`: Bir üye, kurs, sertifika veya blog yazısı silindiğinde, bunlara doğrudan bağlı olan ilişkili kayıtlar (katılımlar, sertifika atamaları, blog yazıları) otomatik olarak silinir.
    * `ON DELETE SET NULL`: Bir kategori veya kurs silindiğinde, ilgili kurs veya sertifika kayıtlarındaki kategori veya kurs kimliği alanı `NULL` olarak ayarlanır (ilgili sütunlar `NOT NULL` olmadığı sürece).
* **Kurs-Sertifika İlişkisi:** `Certificates` tablosuna `course_id` adında yeni bir yabancı anahtar sütunu eklenmiştir. Bu ekleme sayesinde, her sertifikanın hangi kursu tamamlayarak kazanıldığı bilgisi veritabanı yapısı içinde net bir şekilde takip edilebilir hale gelmiştir.
* **İsimlendirme Standardı:** Tablo ve sütun adlarında tutarlı bir İngilizce isimlendirme standardı kullanılarak kodun okunabilirliği ve ekip çalışmasına uygunluğu artırılmıştır.

## 🔍 Şema Görselleştirme:

Veritabanı yapısını ve tablolar arası ilişkileri daha iyi anlamak için projenin kök dizininde bulunan **ER Diagram** ekran görüntüsü dosyasına göz atabilirsiniz. Bu diyagram, veritabanının görsel bir temsilini sunar.

## 🚀 Kurulum & Kullanım

📌 Bu projeyi PostgreSQL üzerinde çalıştırmak ve kullanmak için aşağıdaki adımları izleyebilirsiniz:

1.  **Projeyi klonlayın veya indirin:**
    ```bash
    git clone [https://github.com/bushranovaaa/TurkStudentCo-SQL-Odevleri.git](https://github.com/bushranovaaa/TurkStudentCo-SQL-Odevleri.git)
    cd TurkStudentCo-SQL-Odevleri/CevrimiciEgitimPlatformu -- Proje klasörüne gidin
    ```
    *(Not: Klonlama komutundaki depo adını kendi GitHub deponuzun adıyla güncellediğinizden emin olun.)*

2.  **PostgreSQL veritabanınızı oluşturun:**
    PostgreSQL sunucunuzda yeni bir veritabanı oluşturun. Örneğin `egitim_platformu` adında bir veritabanı oluşturabilirsiniz.
    ```sql
    -- psql komut satırı ile
    CREATE DATABASE egitim_platformu;
    ```

3.  **Veritabanı şemasını ve tabloları oluşturun:**
    Klonladığınız projenin içindeki `online_education_platform.sql` dosyasını kullanarak veritabanı şemasını ve tabloları oluşturun.
    ```bash
    -- psql komut satırı ile (veritabanı adını ve kullanıcı adını kendi ayarlarınıza göre değiştirin)
    psql -U your_username -d egitim_platformu -f online_education_platform.sql
    ```
    Bu komut, SQL dosyasındaki tüm `CREATE TABLE`, `ALTER TABLE` (eğer varsa) ve `INSERT INTO` komutlarını çalıştıracaktır.

4.  **Örnek verileri ekleyin ve test edin:**
    `online_education_platform.sql` dosyası zaten örnek verileri içeriyor. Veritabanınızın doğru kurulduğunu ve verilerin eklendiğini kontrol etmek için basit SQL sorguları çalıştırabilirsiniz.
    ```sql
    -- psql komut satırı ile
    psql -U your_username -d egitim_platformu
    -- Bağlandıktan sonra
    SELECT * FROM Members;
    SELECT * FROM Courses;
    -- vb.
    ```

**✨ Artık veritabanı çalıştırılmaya hazır! 💡**

## 🤝 Katkıda Bulunma:

Bu projeyi daha da geliştirmek için her türlü katkıya açığım! Eğer projeye katkıda bulunmak isterseniz, lütfen bir "issue" açarak veya "pull request" göndererek önerilerinizi veya geliştirmelerinizi paylaşın.

---

Bu proje, TurkStudentCo SQL Ödevi kapsamında geliştirilmiştir.
