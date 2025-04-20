# 📌 1. Hafta - SQL Ödevleri  

🎯 *Amaç:*  
Bu ödevler, *SQL sorgularını kullanarak* veritabanında veri seçme, filtreleme, sıralama ve birleştirme işlemlerini pekiştirmek amacıyla hazırlanmıştır.  

---

📂 *Veritabanı Tabloları*  

*🔹 Employees Tablosu*  
| EmployeeID | FirstName | LastName | Age | Department | Salary | JoinDate |
|------------|----------|----------|-----|------------|--------|----------|
| 1          | Ahmet    | Yılmaz   | 30  | IT         | 8000   | 2020-03-15 |
| 2          | Ayşe     | Kaya     | 28  | HR         | 7500   | 2021-06-22 |
| 3          | Mehmet   | Demir    | 35  | IT         | 9000   | 2018-09-10 |
| 4          | Elif     | Şahin    | 26  | Finance    | 7200   | 2022-02-05 |

*🔹 Departments Tablosu*  
| DepartmentID | DepartmentName |
|-------------|---------------|
| 1           | IT            |
| 2           | HR            |
| 3           | Finance       |

---

📝 *Görevler ve SQL Sorguları*  

*1️⃣ Belirli Kolonları Seçme*
Çalışanların yalnızca *FirstName, LastName ve Salary* bilgilerini listeleyen sorgu:  
```sql
SELECT FirstName, LastName, Salary 
FROM Employees;
```

*2️⃣ DISTINCT Komutu ile Tekrarları Önleme*  
Çalışanların *departmanlarını* benzersiz şekilde listeleyen sorgu:  
```sql
SELECT DISTINCT Department 
FROM Employees;
```

*3️⃣ Belirli Bir Departmana Ait Çalışanları Listeleme*  
*IT departmanındaki* çalışanları listeleyen sorgu:  
```sql
SELECT * 
FROM Employees 
WHERE Department = 'IT';
```

*4️⃣ Maaşa Göre Sıralama*  
Çalışanları *maaşlarına göre büyükten küçüğe* sıralayan sorgu:  
```sql
SELECT * 
FROM Employees 
ORDER BY Salary DESC;
```

*5️⃣ Kolonları Birleştirme (Concatenation)*  
Çalışanların *FirstName ve LastName* kolonlarını birleştirerek tam adlarını içeren yeni bir kolon oluşturan sorgu:  
```sql
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Salary 
FROM Employees;
```

---

📌 *Nasıl Kullanılır?*  
1. SQL veritabanınızı açın (*MySQL, PostgreSQL veya SQLite kullanabilirsiniz*).  
2. Employees ve Departments tablolarını oluşturun.  
3. Yukarıdaki SQL sorgularını çalıştırarak sonuçları gözlemleyin.  

---

📬 *İletişim & Katkı*  
Eğer projeye katkıda bulunmak isterseniz, *pull request* gönderebilirsiniz. 💡
