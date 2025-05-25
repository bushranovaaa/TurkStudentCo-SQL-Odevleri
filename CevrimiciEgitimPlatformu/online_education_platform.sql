-- Tüm tabloları ve bağımlılıklarını güvenli şekilde siler (temiz bir başlangıç için)
DROP TABLE IF EXISTS MemberProgress, Answers, Questions, Quizzes, Lessons, Reviews, BlogComments, BlogPosts, CertificateAssignments, Certificates, Enrollments, Courses, Instructors, Categories, Members CASCADE;

-- ======================================================================
-- PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı Projesi
-- (Geliştirilmiş ve Kapsamlı Versiyon - Rakipsiz!)
-- ======================================================================

-- Fonksiyon: updated_at sütununu otomatik güncellemek için
-- Herhangi bir satır güncellendiğinde 'updated_at' sütununu otomatik olarak mevcut zamanla günceller.
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 1. Üyeler (Members) Tablosu
-- Kullanıcıların temel bilgileri, rol tanımlamaları ve profil resmi URL'si
CREATE TABLE IF NOT EXISTS Members (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Gerçek sistemde hash'lenmiş olmalı!
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    avatar_url VARCHAR(255), -- Profil resmi için URL
    role VARCHAR(20) NOT NULL DEFAULT 'student', -- Kullanıcı rolü: 'student', 'instructor', 'admin'
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- Kaydın son güncellenme tarihi
);

-- Trigger: Members tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_members_updated_at
BEFORE UPDATE ON Members
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 2. Kategoriler (Categories) Tablosu
-- Eğitimleri konu bazlı düzenlemek ve sınıflandırmak için kullanılır.
CREATE TABLE IF NOT EXISTS Categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- Kaydın son güncellenme tarihi
);

-- Trigger: Categories tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_categories_updated_at
BEFORE UPDATE ON Categories
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 3. Eğitmenler (Instructors) Tablosu
-- Eğitmenlere özgü detaylı bilgileri tutar. Member tablosundaki bir üyeyi eğitmen olarak işaretler.
CREATE TABLE IF NOT EXISTS Instructors (
    id SERIAL PRIMARY KEY,
    member_id INTEGER UNIQUE NOT NULL, -- Members tablosuna bağlanır (bir üye sadece bir eğitmen kaydına sahip olabilir)
    specialization VARCHAR(100), -- Uzmanlık alanı (örn: Veri Bilimi, Web Geliştirme)
    bio TEXT, -- Kısa biyografi
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_instructor_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE -- Üye silinirse eğitmen kaydı da silinsin
);

-- Trigger: Instructors tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_instructors_updated_at
BEFORE UPDATE ON Instructors
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 4. Eğitimler (Courses) Tablosu
-- Platformdaki eğitimlerin detaylarını içerir. Artık eğitmen bilgisi Instructor tablosundan alınır.
CREATE TABLE IF NOT EXISTS Courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    instructor_id INTEGER NOT NULL, -- Eğitmen id'si (Instructors tablosuna referans verir)
    category_id INTEGER,
    preview_video_url VARCHAR(255), -- Kurs önizleme videosu linki
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_course_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(id)
        ON DELETE SET NULL, -- Kategori silinirse, kursun kategori bilgisi NULL olsun
    CONSTRAINT fk_course_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES Instructors(id)
        ON DELETE SET NULL, -- Eğitmen silinirse, kursun eğitmen bilgisi NULL olsun
    CONSTRAINT chk_dates CHECK (end_date >= start_date) -- Başlangıç tarihinin bitiş tarihinden önce olmasını sağlar
);

-- Trigger: Courses tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_courses_updated_at
BEFORE UPDATE ON Courses
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 5. Dersler (Lessons) Tablosu
-- Her kursun altındaki dersleri, içerikleri ve videoları tutar.
CREATE TABLE IF NOT EXISTS Lessons (
    id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    lesson_title VARCHAR(255) NOT NULL, -- Dersin başlığı
    content TEXT, -- Dersin metin içeriği
    video_url VARCHAR(255), -- Ders videosu linki
    duration_minutes INTEGER, -- Dersin süresi (dakika)
    order_in_course INTEGER NOT NULL, -- Kurstaki dersin sırası
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_lesson_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id)
        ON DELETE CASCADE -- Kurs silinirse, dersleri de silinsin
);

-- Trigger: Lessons tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_lessons_updated_at
BEFORE UPDATE ON Lessons
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 6. Quizler (Quizzes) Tablosu
-- Derslere bağlı quizleri tutar.
CREATE TABLE IF NOT EXISTS Quizzes (
    id SERIAL PRIMARY KEY,
    lesson_id INTEGER NOT NULL,
    quiz_title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_quiz_lesson
        FOREIGN KEY (lesson_id)
        REFERENCES Lessons(id)
        ON DELETE CASCADE -- Ders silinirse, quizleri de silinsin
);

-- Trigger: Quizzes tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_quizzes_updated_at
BEFORE UPDATE ON Quizzes
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 7. Sorular (Questions) Tablosu
-- Quizlere bağlı soruları tutar.
CREATE TABLE IF NOT EXISTS Questions (
    id SERIAL PRIMARY KEY,
    quiz_id INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) NOT NULL, -- Örn: 'multiple_choice', 'true_false', 'short_answer'
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_question_quiz
        FOREIGN KEY (quiz_id)
        REFERENCES Quizzes(id)
        ON DELETE CASCADE -- Quiz silinirse, soruları da silinsin
);

-- Trigger: Questions tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_questions_updated_at
BEFORE UPDATE ON Questions
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 8. Cevaplar (Answers) Tablosu
-- Sorulara bağlı cevap seçeneklerini tutar.
CREATE TABLE IF NOT EXISTS Answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE, -- Cevabın doğru olup olmadığını belirtir
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_answer_question
        FOREIGN KEY (question_id)
        REFERENCES Questions(id)
        ON DELETE CASCADE -- Soru silinirse, cevapları da silinsin
);

-- Trigger: Answers tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_answers_updated_at
BEFORE UPDATE ON Answers
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 9. Katılımlar (Enrollments) Tablosu
-- Kullanıcıların hangi eğitimlere kaydolduğunu takip eder.
CREATE TABLE IF NOT EXISTS Enrollments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_enrollment_member
        FOREIGN KEY (member_id)
        REFERENCES Members(id)
        ON DELETE CASCADE, -- Üye silinirse, katılımları da silinsin
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id)
        ON DELETE CASCADE, -- Kurs silinirse, katılımları da silinsin
    CONSTRAINT unique_enrollment UNIQUE (member_id, course_id) -- Bir kullanıcının aynı kursa birden fazla kez kaydolmasını engeller
);

-- Trigger: Enrollments tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_enrollments_updated_at
BEFORE UPDATE ON Enrollments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 10. Sertifikalar (Certificates) Tablosu
-- Tamamlanan eğitimler için verilen sertifikaların bilgilerini içerir.
CREATE TABLE IF NOT EXISTS Certificates (
    id SERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issued_date DATE,
    course_id INTEGER, -- Hangi kursa ait olduğunu belirtir
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_certificate_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id)
        ON DELETE SET NULL -- Kurs silinirse, sertifikanın kurs bilgisi NULL olsun
);

-- Trigger: Certificates tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_certificates_updated_at
BEFORE UPDATE ON Certificates
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 11. Sertifika Atamaları (CertificateAssignments) Tablosu
-- Hangi kullanıcının hangi sertifikayı aldığını kaydeder.
CREATE TABLE IF NOT EXISTS CertificateAssignments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    certificate_id INTEGER NOT NULL,
    assignment_date DATE,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_cert_assignment_member
        FOREIGN KEY (member_id)
        REFERENCES Members(id)
        ON DELETE CASCADE, -- Üye silinirse, sertifika atamaları da silinsin
    CONSTRAINT fk_cert_assignment_certificate
        FOREIGN KEY (certificate_id)
        REFERENCES Certificates(id)
        ON DELETE CASCADE, -- Sertifika silinirse, atamaları da silinsin
    CONSTRAINT unique_cert_assignment UNIQUE (member_id, certificate_id) -- Bir kullanıcının aynı sertifikayı birden fazla kez almasını engeller
);

-- Trigger: CertificateAssignments tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_certificate_assignments_updated_at
BEFORE UPDATE ON CertificateAssignments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 12. Blog Gönderileri (BlogPosts) Tablosu
-- Kullanıcıların platformda paylaştığı blog yazılarını içerir.
CREATE TABLE IF NOT EXISTS BlogPosts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    published_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_blog_author
        FOREIGN KEY (author_id)
        REFERENCES Members(id)
        ON DELETE CASCADE -- Yazar (üye) silinirse, blog yazıları da silinsin
);

-- Trigger: BlogPosts tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_blog_posts_updated_at
BEFORE UPDATE ON BlogPosts
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 13. Üye İlerleme Takibi (MemberProgress) Tablosu
-- Kullanıcıların derslerdeki ve quizlerdeki ilerlemesini takip eder.
CREATE TABLE IF NOT EXISTS MemberProgress (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    lesson_id INTEGER NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE, -- Ders tamamlandı mı?
    completion_date TIMESTAMP, -- Tamamlanma tarihi (eğer tamamlandıysa)
    score INTEGER, -- Quiz puanı (eğer bir quiz dersi ise)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_progress_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT fk_progress_lesson FOREIGN KEY (lesson_id) REFERENCES Lessons(id) ON DELETE CASCADE,
    CONSTRAINT unique_member_lesson_progress UNIQUE (member_id, lesson_id) -- Bir üye bir ders için sadece bir ilerleme kaydına sahip olabilir
);

-- Trigger: MemberProgress tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_member_progress_updated_at
BEFORE UPDATE ON MemberProgress
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 14. Kurs Yorumları ve Değerlendirmeleri (Reviews) Tablosu
-- Kullanıcıların kurslar hakkında yorumlarını ve puanlamalarını tutar.
CREATE TABLE IF NOT EXISTS Reviews (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5), -- 1-5 arası puanlama
    comment_text TEXT, -- Yorum metni
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi (review_date yerine)
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_review_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT fk_review_course FOREIGN KEY (course_id) REFERENCES Courses(id) ON DELETE CASCADE,
    CONSTRAINT unique_member_course_review UNIQUE (member_id, course_id) -- Bir üye bir kursa sadece bir yorum yapabilir
);

-- Trigger: Reviews tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_reviews_updated_at
BEFORE UPDATE ON Reviews
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- 15. Blog Yorumları (BlogComments) Tablosu
-- Kullanıcıların blog gönderilerine yaptığı yorumları tutar.
CREATE TABLE IF NOT EXISTS BlogComments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    blog_post_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın oluşturulma tarihi
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Kaydın son güncellenme tarihi
    CONSTRAINT fk_blog_comment_member FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE,
    CONSTRAINT fk_blog_comment_post FOREIGN KEY (blog_post_id) REFERENCES BlogPosts(id) ON DELETE CASCADE
);

-- Trigger: BlogComments tablosundaki updated_at sütununu otomatik günceller
CREATE TRIGGER trg_blog_comments_updated_at
BEFORE UPDATE ON BlogComments
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- ========================
-- ÖRNEK VERİLERİN EKLENMESİ
-- ========================

-- Üyeler (Roller ve avatar_url güncellendi)
INSERT INTO Members (username, email, password, first_name, last_name, role, avatar_url)
VALUES
('coderzeynep', 'zeynep@gmail.com', 'hashedpass1', 'Zeynep', 'Yılmaz', 'instructor', 'https://placehold.co/100x100/F06292/FFFFFF?text=ZY'), -- Eğitmen
('mrrobot', 'elliot@fsociety.com', 'mrrobot123', 'Elliot', 'Alderson', 'student', 'https://placehold.co/100x100/42A5F5/FFFFFF?text=EA'),
('techqueen', 'ayse@codehub.org', 'queenbee99', 'Ayşe', 'Kaya', 'instructor', 'https://placehold.co/100x100/FFD54F/FFFFFF?text=AK'), -- Eğitmen
('adminuser', 'admin@platform.com', 'adminpass', 'Platform', 'Admin', 'admin', 'https://placehold.co/100x100/81C784/FFFFFF?text=PA'); -- Yönetici

-- Eğitmenler (Yeni tabloya veri ekleniyor)
INSERT INTO Instructors (member_id, specialization, bio)
VALUES
((SELECT id FROM Members WHERE username = 'coderzeynep'), 'Yazılım Geliştirme, Python', 'Deneyimli bir yazılım geliştirici ve eğitmen.'),
((SELECT id FROM Members WHERE username = 'techqueen'), 'Veri Bilimi, SQL', 'Veri analizi ve görselleştirme uzmanı.');

-- Kategoriler
INSERT INTO Categories (category_name)
VALUES
('Yazılım'),
('Tasarım'),
('Veri Bilimi'),
('Pazarlama');

-- Kurslar (instructor_id ve preview_video_url kullanıldı)
INSERT INTO Courses (course_name, description, start_date, end_date, instructor_id, category_id, preview_video_url)
VALUES
('Python 101', 'Yeni başlayanlar için Python eğitimi', '2024-05-01 00:00:00', '2024-06-01 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'coderzeynep')), 1, 'https://example.com/preview_python101.mp4'),
('Veri Görselleştirme', 'Görsel anlatımla veri analizi', '2024-05-10 00:00:00', '2024-06-15 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'techqueen')), 3, 'https://example.com/preview_datavis.mp4'),
('Temel Python Eğitimi', 'Yeni başlayanlar için temel Python eğitimi', '2025-02-01 00:00:00', '2025-03-01 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'coderzeynep')), 1, NULL),
('SQL ile Veri Analizi', 'Veri sorgulama teknikleri ve SQL kullanımı', '2025-03-10 00:00:00', '2025-04-10 00:00:00', (SELECT id FROM Instructors WHERE member_id = (SELECT id FROM Members WHERE username = 'techqueen')), 3, 'https://example.com/preview_sql.mp4');

-- Dersler (Yeni tabloya veri ekleniyor)
INSERT INTO Lessons (course_id, lesson_title, content, video_url, duration_minutes, order_in_course)
VALUES
((SELECT id FROM Courses WHERE course_name = 'Python 101'), 'Giriş ve Kurulum', 'Python programlama dilinin temelleri ve geliştirme ortamı kurulumu.', 'https://example.com/python101_lesson1.mp4', 30, 1),
((SELECT id FROM Courses WHERE course_name = 'Python 101'), 'Değişkenler ve Veri Tipleri', 'Python\'daki temel veri tipleri ve değişken tanımlamaları.', 'https://example.com/python101_lesson2.mp4', 45, 2),
((SELECT id FROM Courses WHERE course_name = 'Veri Görselleştirme'), 'Matplotlib ile Temeller', 'Veri görselleştirme kütüphanesi Matplotlib\'e giriş.', 'https://example.com/datavis_lesson1.mp4', 60, 1);

-- Quizler (Yeni tabloya veri ekleniyor)
INSERT INTO Quizzes (lesson_id, quiz_title, description)
VALUES
((SELECT id FROM Lessons WHERE lesson_title = 'Giriş ve Kurulum'), 'Python Giriş Quizi', 'Giriş dersi sonrası temel Python bilgileri için kısa bir test.'),
((SELECT id FROM Lessons WHERE lesson_title = 'Matplotlib ile Temeller'), 'Matplotlib Temelleri Quizi', 'Matplotlib kütüphanesi hakkında sorularla bilginizi test edin.');

-- Sorular (Yeni tabloya veri ekleniyor)
INSERT INTO Questions (quiz_id, question_text, question_type)
VALUES
((SELECT id FROM Quizzes WHERE quiz_title = 'Python Giriş Quizi'), 'Python hangi tür bir dildir?', 'multiple_choice'),
((SELECT id FROM Quizzes WHERE quiz_title = 'Python Giriş Quizi'), 'Python yorumlanan bir dil midir?', 'true_false'),
((SELECT id FROM Quizzes WHERE quiz_title = 'Matplotlib Temelleri Quizi'), 'Matplotlib ne için kullanılır?', 'short_answer');

-- Cevaplar (Yeni tabloya veri ekleniyor)
INSERT INTO Answers (question_id, answer_text, is_correct)
VALUES
((SELECT id FROM Questions WHERE question_text = 'Python hangi tür bir dildir?'), 'Yorumlanan', TRUE),
((SELECT id FROM Questions WHERE question_text = 'Python hangi tür bir dildir?'), 'Derlenen', FALSE),
((SELECT id FROM Questions WHERE question_text = 'Python yorumlanan bir dil midir?'), 'Evet', TRUE),
((SELECT id FROM Questions WHERE question_text = 'Python yorumlanan bir dil midir?'), 'Hayır', FALSE),
((SELECT id FROM Questions WHERE question_text = 'Matplotlib ne için kullanılır?'), 'Veri görselleştirme', TRUE); -- Kısa cevap için örnek doğru cevap

-- Katılımlar
INSERT INTO Enrollments (member_id, course_id)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Courses WHERE course_name = 'Python 101')),
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Courses WHERE course_name = 'Veri Görselleştirme'));

-- Sertifikalar
INSERT INTO Certificates (certificate_code, issued_date, course_id)
VALUES
('PY2024-001', '2024-06-02', (SELECT id FROM Courses WHERE course_name = 'Python 101')),
('DATA2024-002', '2024-06-16', (SELECT id FROM Courses WHERE course_name = 'Veri Görselleştirme'));

-- Sertifika Atamaları
INSERT INTO CertificateAssignments (member_id, certificate_id, assignment_date)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Certificates WHERE certificate_code = 'PY2024-001'), '2024-06-03'),
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Certificates WHERE certificate_code = 'DATA2024-002'), '2024-06-05');

-- Blog Gönderileri
INSERT INTO BlogPosts (title, content, author_id)
VALUES
('Yazılıma Nereden Başlamalıyım?', 'Bence önce temel kavramları öğrenmek lazım, sonra bol bol pratik yapmak gerekiyor. Unutmayın, kod yazarak öğrenilir!', (SELECT id FROM Members WHERE username = 'coderzeynep')),
('Veri Bilimi Serüvenim', 'Bu alana ilgim hep vardı, sonunda kendimi derinlemesine çalışırken buldum. Veri dünyası gerçekten büyüleyici!', (SELECT id FROM Members WHERE username = 'techqueen'));

-- Üye İlerleme Takibi (Yeni tabloya veri ekleniyor)
INSERT INTO MemberProgress (member_id, lesson_id, is_completed, completion_date, score)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Lessons WHERE lesson_title = 'Giriş ve Kurulum'), TRUE, '2024-05-05 10:00:00', NULL), -- Ders tamamlandı
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Lessons WHERE lesson_title = 'Değişkenler ve Veri Tipleri'), FALSE, NULL, NULL), -- Ders henüz tamamlanmadı
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Lessons WHERE lesson_title = 'Matplotlib ile Temeller'), TRUE, '2024-06-01 15:30:00', 90); -- Ders tamamlandı ve quiz puanı var

-- Kurs Yorumları ve Değerlendirmeleri (Yeni tabloya veri ekleniyor)
INSERT INTO Reviews (member_id, course_id, rating, comment_text)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM Courses WHERE course_name = 'Python 101'), 5, 'Harika bir başlangıç kursu, çok faydalı oldu! Eğitmenin anlatımı da süper.'),
((SELECT id FROM Members WHERE username = 'techqueen'), (SELECT id FROM Courses WHERE course_name = 'Veri Görselleştirme'), 4, 'Anlatım güzeldi ama bazı yerlerde daha fazla örnek olabilirdi. Genel olarak memnun kaldım.');

-- Blog Yorumları (Yeni tabloya veri ekleniyor)
INSERT INTO BlogComments (member_id, blog_post_id, comment_text)
VALUES
((SELECT id FROM Members WHERE username = 'mrrobot'), (SELECT id FROM BlogPosts WHERE title = 'Yazılıma Nereden Başlamalıyım?'), 'Çok doğru tespitler, teşekkürler! Yeni başlayanlar için harika bir rehber.'),
((SELECT id FROM Members WHERE username = 'adminuser'), (SELECT id FROM BlogPosts WHERE title = 'Veri Bilimi Serüvenim'), 'Emeğinize sağlık, bilgilendirici bir yazı olmuş. Veri bilimine ilgimi artırdı!');

-- ========================
-- İNDEKSLEME (PERFORMANS İÇİN KRİTİK)
-- ========================

-- Yabancı Anahtar sütunlarına indeksler (JOIN performansını artırır)
CREATE INDEX idx_members_email ON Members (email);
CREATE INDEX idx_members_username ON Members (username);
CREATE INDEX idx_members_role ON Members (role); -- Rol bazlı sorgular için
CREATE INDEX idx_instructors_member_id ON Instructors (member_id);
CREATE INDEX idx_courses_category_id ON Courses (category_id);
CREATE INDEX idx_courses_instructor_id ON Courses (instructor_id);
CREATE INDEX idx_enrollments_member_id ON Enrollments (member_id);
CREATE INDEX idx_enrollments_course_id ON Enrollments (course_id);
CREATE INDEX idx_certificates_course_id ON Certificates (course_id);
CREATE INDEX idx_certificate_assignments_member_id ON CertificateAssignments (member_id);
CREATE INDEX idx_certificate_assignments_certificate_id ON CertificateAssignments (certificate_id);
CREATE INDEX idx_blog_posts_author_id ON BlogPosts (author_id);
CREATE INDEX idx_lessons_course_id ON Lessons (course_id);
CREATE INDEX idx_quizzes_lesson_id ON Quizzes (lesson_id);
CREATE INDEX idx_questions_quiz_id ON Questions (quiz_id);
CREATE INDEX idx_answers_question_id ON Answers (question_id);
CREATE INDEX idx_member_progress_member_id ON MemberProgress (member_id);
CREATE INDEX idx_member_progress_lesson_id ON MemberProgress (lesson_id);
CREATE INDEX idx_reviews_member_id ON Reviews (member_id);
CREATE INDEX idx_reviews_course_id ON Reviews (course_id);
CREATE INDEX idx_blog_comments_member_id ON BlogComments (member_id);
CREATE INDEX idx_blog_comments_blog_post_id ON BlogComments (blog_post_id);

-- Sıkça arama yapılan diğer sütunlara indeksler (WHERE koşullarını hızlandırır)
CREATE INDEX idx_courses_course_name ON Courses (course_name);
CREATE INDEX idx_categories_category_name ON Categories (category_name);
CREATE INDEX idx_certificates_certificate_code ON Certificates (certificate_code);
CREATE INDEX idx_lessons_lesson_title ON Lessons (lesson_title);
CREATE INDEX idx_quizzes_quiz_title ON Quizzes (quiz_title);
CREATE INDEX idx_blog_posts_title ON BlogPosts (title);
CREATE INDEX idx_members_registration_date ON Members (registration_date); -- Kayıt tarihine göre sıralama/filtreleme için
CREATE INDEX idx_courses_start_date ON Courses (start_date); -- Kurs başlangıç tarihine göre arama için
