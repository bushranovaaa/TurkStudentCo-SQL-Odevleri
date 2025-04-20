SELECT SUM(total) AS total_invoice_amount
FROM invoice
WHERE billing_country = 'USA' 
AND EXTRACT(YEAR FROM invoice_date) = 2009;

SELECT track.*
FROM track
JOIN playlisttrack ON track.track_id = playlisttrack.track_id
JOIN playlist ON playlisttrack.playlist_id = playlist.playlist_id;

SELECT track.name AS track_name, artist.name AS artist_name, track.milliseconds
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
WHERE album.title = 'Let There Be Rock'
ORDER BY track.milliseconds DESC;
