# SQL Bootcamp Üçüncü Hafta Ödev Soruları

## Amaç

Bu ödevin amacı, SQL sorguları yazma becerilerinizi geliştirmek ve farklı SQL işlemlerini uygulamanızdır. Bu ödevde, Chinook veritabanındaki farklı tabloları sorgulayarak, verilen soruları çözmeniz gerekmektedir.

## Kullanılacak Tablolar

- **invoice**: Faturalar hakkında bilgi içerir.
- **track**: Parça bilgileri içerir.
- **playlisttrack**: Parçaların hangi playlistlere ait olduğunu gösterir.
- **playlist**: Playlist bilgilerini içerir.
- **album**: Albüm bilgilerini içerir.
- **artist**: Sanatçı bilgilerini içerir.

## Sorular

### Soru 1: Invoice Tablosu

**Soru:**  
USA ülkesine ait, 2009 yılı içerisinde oluşturulmuş tüm faturaların (Invoice) toplamını listeleyen bir sorgu yazınız.

Aşağıdaki SQL sorgusu, USA'da 2009 yılı içerisinde oluşturulmuş tüm faturaların toplamını hesaplar.

```sql
  SELECT SUM(total) AS total_invoice
  FROM invoice
  WHERE billing_country = 'USA'
    AND EXTRACT(YEAR FROM invoice_date) = 2009;
```

Açıklama:

- **SUM(total)** ile faturaların toplam tutarını hesaplıyoruz.
- **EXTRACT(YEAR FROM invoice_date)** ile faturaların tarihinden yılı alıyoruz ve sadece 2009 yılına ait olanları seçiyoruz.

### Soru 2: Track, PlaylistTrack ve Playlist Tablolarında JOIN

Tüm parça (track) bilgilerini, bu parçaların ait olduğu playlisttrack ve playlist tablolarıyla birleştirerek (JOIN) listeleyen bir sorgu yazınız.

Aşağıdaki SQL sorgusu, tüm parçaları, ait oldukları playlistlerle birleştirerek listeleyecektir.'

```sql
  SELECT t.track_id, t.name AS track_name, p.name AS playlist_name
  FROM track t
  JOIN playlisttrack pt ON t.track_id = pt.track_id
  JOIN playlist p ON pt.playlist_id = p.playlist_id;
 ```

**Açıklama:**

- track tablosundaki parçaları playlisttrack ve playlist tabloları ile ilişkilendiriyoruz.
- JOIN işlemi ile her parçanın ait olduğu playlist ismini gösteriyoruz.

### Soru 3: Track, Album ve Artist Tablolarında JOIN

"Let There Be Rock" adlı albüme ait tüm parçaları (Track) listeleyen, sanatçı (Artist) bilgisini de içeren bir sorgu yazınız. Ayrıca, sonuçları parça süresi (milliseconds) büyükten küçüğe sıralayınız.

Aşağıdaki SQL sorgusu, **"Let There Be Rock"** albümüne ait tüm parçaları, sanatçı bilgisi ile birlikte listeleyecektir.

```sql
    SELECT t.name AS track_name, a.name AS artist_name, t.milliseconds
    FROM track t
    JOIN album al ON t.album_id = al.album_id
    JOIN artist a ON al.artist_id = a.artist_id
    WHERE al.title = 'Let There Be Rock'
    ORDER BY t.milliseconds DESC;
```

**Açıklama:**

- **track** tablosundaki parçaları, **album** ve **artist** tabloları ile ilişkilendiriyoruz.
- **WHERE** ile albüm adı "Let There Be Rock" olarak filtreleniyor.
- **ORDER BY t.milliseconds DESC** ile parçalar süreye göre azalan sırada sıralanıyor.

## Notlar

- Bu ödevde verilen her bir sorgu, veritabanındaki farklı tabloları sorgulamanıza olanak tanıyacaktır.
- SQL sorgularını doğru yazmak ve veri üzerinde işlemler yaparken doğru ilişkileri kurmak önemlidir.
