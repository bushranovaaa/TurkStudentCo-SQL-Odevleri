DROP TABLE IF EXISTS BlogPosts, CertificateAssignments, Certificates, Enrollments, Courses, Categories, Members CASCADE;

-- ======================================================================
-- PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı Projesi
-- ======================================================================

-- 1. Üyeler (Members) Tablosu
CREATE TABLE IF NOT EXISTS Members (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- 2. Kategoriler (Categories) Tablosu
CREATE TABLE IF NOT EXISTS Categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);


-- 3. Eğitimler (Courses) Tablosu
CREATE TABLE IF NOT EXISTS Courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    instructor VARCHAR(100),
    category_id INTEGER,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(id),
    CONSTRAINT chk_dates CHECK (end_date >= start_date)
);


-- 4. Katılımlar (Enrollments) Tablosu
CREATE TABLE IF NOT EXISTS Enrollments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_enrollment_member
        FOREIGN KEY (member_id)
        REFERENCES Members(id),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(id),
    CONSTRAINT unique_enrollment UNIQUE (member_id, course_id)
);


-- 5. Sertifikalar (Certificates) Tablosu
CREATE TABLE IF NOT EXISTS Certificates (
    id SERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issued_date DATE
);


-- 6. Sertifika Atamaları (CertificateAssignments) Tablosu
CREATE TABLE IF NOT EXISTS CertificateAssignments (
    id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    certificate_id INTEGER NOT NULL,
    assignment_date DATE,
    CONSTRAINT fk_cert_assignment_member
        FOREIGN KEY (member_id)
        REFERENCES Members(id),
    CONSTRAINT fk_cert_assignment_certificate
        FOREIGN KEY (certificate_id)
        REFERENCES Certificates(id),
    CONSTRAINT unique_cert_assignment UNIQUE (member_id, certificate_id)
);


-- 7. Blog Gönderileri (BlogPosts) Tablosu
CREATE TABLE IF NOT EXISTS BlogPosts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    published_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER NOT NULL,
    CONSTRAINT fk_blog_author
        FOREIGN KEY (author_id)
        REFERENCES Members(id)
);


-- ========================
-- ÖRNEK VERİLERİN EKLENMESİ
-- ========================

-- Üyeler
INSERT INTO Members (username, email, password, first_name, last_name)
VALUES 
('coderzeynep', 'zeynep@gmail.com', 'hashedpass1', 'Zeynep', 'Yılmaz'),
('mrrobot', 'elliot@fsociety.com', 'mrrobot123', 'Elliot', 'Alderson'),
('techqueen', 'ayse@codehub.org', 'queenbee99', 'Ayşe', 'Kaya');

--Kategoriler
INSERT INTO Categories (category_name)
VALUES 
('Yazılım'),
('Tasarım'),
('Veri Bilimi');

-- Kurslar
INSERT INTO Courses (course_name, description, start_date, end_date, instructor, category_id)
VALUES 
('Python 101', 'Yeni başlayanlar için Python eğitimi', '2024-05-01 00:00:00', '2024-06-01 00:00:00', 'Zeynep Öğretmen', 1),
('Veri Görselleştirme', 'Görsel anlatımla veri analizi', '2024-05-10 00:00:00', '2024-06-15 00:00:00', 'Ayşe Kaya', 3),
('Temel Python Eğitimi', 'Yeni başlayanlar için temel Python eğitimi', '2025-02-01 00:00:00', '2025-03-01 00:00:00', 'Zeynep Öğretmen', 1),
('SQL ile Veri Analizi', 'Veri sorgulama teknikleri ve SQL kullanımı', '2025-03-10 00:00:00', '2025-04-10 00:00:00', 'Ayşe Kaya', 3);


--Katılımlar
INSERT INTO Enrollments (member_id, course_id)
VALUES 
(1, 1), 
(2, 1), 
(3, 2);

-- Sertifikalar
INSERT INTO Certificates (certificate_code, issued_date)
VALUES 
('PY2024-001', '2024-06-02'),
('DATA2024-002', '2024-06-16');

-- Sertifika Atamaları
INSERT INTO CertificateAssignments (member_id, certificate_id, assignment_date)
VALUES 
(1, 1, '2024-06-01'),
(3, 2, '2024-06-05');

-- Blog Gönderileri
INSERT INTO BlogPosts (title, content, author_id)
VALUES 
('Yazılıma Nereden Başlamalıyım?', 'Bence önce temel kavramları öğrenmek lazım...', 1),
('Veri Bilimi Serüvenim', 'Bu alana ilgim hep vardı...', 3);
