# 🎓 PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı

🎓 PostgreSQL kullanarak Çevrimiçi Eğitim Platformu için profesyonel bir veritabanı tasarımı! Verilerin hızlı bir şekilde yönetilmesi, düzenlenmesi ve sorgulanması için tasarlanmış veritabanı yapısını keşfetmeye hazır mısın? Bu proje, hem temel SQL bilgilerini geliştirmen hem de büyük veri setlerinde hızlı sorgulamalar yapabilmen için mükemmel bir fırsat!

💡 Kullanıcılar kayıt olabilir, 📚 Eğitimlere katılabilir, 🎖 Sertifikalar kazanabilir, 📝 Blog gönderileri paylaşarak seviyelerini yükseltebilir!

## 💥 Projenin Amacı:

Bu projede SQL'in temellerinden ileri seviyeye kadar kullanımlarını keşfedecek ve veritabanı optimizasyonu ile performans iyileştirme tekniklerini öğreneceksiniz! 🎯 Ayrıca, büyük veri setlerinde hızlı ve verimli sorgulamalar yapabilmek için güçlü teknikler geliştireceksiniz. Veritabanı tasarımında mükemmeliyet arayanlar için tam anlamıyla pratik bir uygulama!

## ⚙️ Veritabanı Tasarımı:

Projede kullanılan PostgreSQL tasarımı, kullanıcıları ve eğitimleri verimli şekilde organize etmenize olanak tanır. Veritabanı çok yönlü veri yönetimi sağlar, böylece kapsamlı sorgulamalar ve hızlı veri analizi mümkün olur. Bu tasarım, hem geliştiriciler hem de veri analistleri için verimli ve optimize edilmiş bir altyapı sunmaktadır.

## 🎯 Proje Hedefleri:

- SQL Sorgularını Profesyonel Seviyede yazmak.
- Veritabanı optimizasyonu ve performans arttırma tekniklerini öğrenmek.
- Büyük veri setlerinde hızlı ve verimli sorgulamalar gerçekleştirmek.
  
**🎓 Profesyonel bir veritabanı tasarımı oluştur! 🚀 Gerçek dünya senaryosunda PostgreSQL becerilerini geliştir! 📊 Veriyi yönet, analiz et ve optimize et!**

## 🏆 Veritabanı Şeması

**📌 Ana tablolar ve işlevleri:**

- Üyeler (Members) → Kullanıcı bilgileri ve kayıt yönetimi
- Eğitimler (Courses) → Dersler, eğitmenler ve tarih bilgileri
- Kategoriler (Categories) → Eğitimleri konu bazlı düzenleme
- Katılımlar (Enrollments) → Kullanıcıların aldığı dersleri takip etme
- Sertifikalar (Certificates) → Tamamlanan eğitimler için ödüller
- Blog Gönderileri (BlogPosts) → Kullanıcıların paylaşım yaptığı alan

## 🔗 İlişkiler: 

- ✅ Birincil Anahtar (PK) → Her tablo için benzersiz kimlikler. 
- ✅ Yabancı Anahtar (FK) → Tablo bağlantılarını düzenleme. 
- ✅ Tekil Anahtar (UK) → Kullanıcı adı, e-posta, sertifika kodu gibi verilerin benzersizliğini sağlama.

## 🔍 Şema Görselleştirme:

Veritabanı yapısını daha iyi anlamak için **ER Diagram** ekran görüntüsü dosyada mevcuttur!

## 🚀 Kurulum & Kullanım

📌 Bu projeyi PostgreSQL üzerinde çalıştırmak için:

-**1️⃣ Projeyi klonlayın veya indirin:**
```bash
   git clone https://github.com/bushranovaaa/CevrimiciEgitimPlatformu.git
   cd CevrimiciEgitimPlatformu
```

-**2️⃣ Veritabanını oluşturun:**
```sql
   psql -U postgres -d egitim_platformu -f schema.sql
```

-**3️⃣ Örnek veri ekleyin ve test edin:**
```sql
   psql -U postgres -d egitim_platformu -f queries.sql
```


**✨ Artık veritabanı çalıştırılmaya hazır! 💡**

