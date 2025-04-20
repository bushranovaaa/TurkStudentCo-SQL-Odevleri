-- ======================================================================
-- PostgreSQL ile Çevrimiçi Eğitim Platformu Veritabanı Tasarımı Projesi
-- ======================================================================
-- Bu dosya, aşağıdaki tabloları oluşturur:
-- 
-- 1. Members: Üye bilgileri
-- 2. Categories: Eğitim kategorileri
-- 3. Courses: Eğitim bilgileri (kategoriyle ilişkilidir)
-- 4. Enrollments: Üyelerin eğitimlere katılım bilgileri (çok-çok ilişki)
-- 5. Certificates: Sertifika bilgileri
-- 6. CertificateAssignments: Hangi üyenin hangi sertifikayı aldığı bilgisi
-- 7. BlogPosts: Üyelerin blog gönderileri
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