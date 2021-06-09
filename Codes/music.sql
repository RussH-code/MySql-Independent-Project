-- A. Most Popular Tracks
SELECT track.Name, COUNT(playlistTrack.TrackId) AS 'Count', 
playlistTrack.PlaylistId, playlistTrack.TrackId 
FROM playlistTrack
JOIN track 
on playlistTrack.TrackId = track.TrackId
GROUP BY playlistTrack.TrackId
ORDER by Count DESC;

-- B. Most Lucrative Tracks
SELECT SUM(InvoiceLine.UnitPrice) AS 'TotalSales', track.TrackId, track.Name,
genre.Name AS 'Genre', album.Title AS 'Album'
FROM track
JOIN InvoiceLine 
ON track.TrackId = InvoiceLine.TrackId
JOIN album
ON track.AlbumId = album.AlbumId
JOIN genre
ON track.GenreId = genre.GenreId
GROUP BY TrackId
ORDER BY TotalSales DESC;

-- C. Sales Data by Country
SELECT Invoice.BillingCountry AS 'Country', SUM(InvoiceLine.UnitPrice) AS 'TotalSales',
ROUND((SUM(InvoiceLine.UnitPrice)/(SELECT SUM(UnitPrice) FROM InvoiceLine)*100), 2) AS 'Percentage'
FROM Invoice 
JOIN InvoiceLine 
ON Invoice.InvoiceId = InvoiceLine.InvoiceId
GROUP BY Invoice.BillingCountry
ORDER BY Percentage DESC;

-- D. Sales Statistics
WITH TempSales AS
( 
  SELECT customer.CustomerId, SupportRepId, SUM(Total) AS 'Total'
  FROM  customer 
  JOIN invoice
  ON customer.CustomerId = invoice.CustomerId
  GROUP BY customer.CustomerId
  )
SELECT employee.EmployeeId, employee.FirstName, employee.LastName, 
COUNT(TempSales.CustomerId) AS 'NumberOfCustomers', 
SUM(TempSales.Total) AS 'TotalSales', 
ROUND(SUM(TempSales.Total)/COUNT(TempSales.CustomerId), 2) AS 'AvgSalesPerCustomer'
FROM employee 
JOIN TempSales
ON employee.EmployeeId = TempSales.SupportRepId
GROUP BY EmployeeId;

-- Long vs Short album
WITH TempAlbum AS
(
    SELECT SUM(InvoiceLine.UnitPrice*InvoiceLine.Quantity) AS 'TotalSales',
    InvoiceLine.TrackId
    FROM InvoiceLine
    GROUP BY TrackId
)
SELECT AlbumId, ROUND((SUM(Milliseconds)/60000), 1) AS 'AlbumLength (minutes)', 
TempAlbum.TotalSales
FROM Track
JOIN TempAlbum
ON Track.TrackId = TempAlbum.TrackId
GROUP BY AlbumID
ORDER BY TotalSales DESC;

-- Number of tracks in playlists and sales
WITH TempTrack AS 
(
    SELECT InvoiceLine.TrackId, SUM(InvoiceLine.UnitPrice) AS 'Revenue'
    FROM InvoiceLine
    GROUP BY InvoiceLine.TrackId
)
SELECT playlistTrack.TrackId, COUNT(playlistTrack.TrackId) AS 'NumberInPlaylist', 
SUM(TempTrack.Revenue) AS 'TotalSales'
FROM playlistTrack
JOIN TempTrack ON playlistTrack.TrackId = TempTrack.TrackId
GROUP BY playlistTrack.TrackId
ORDER BY SUM(TempTrack.Revenue) DESC;

-- Revenue Growth/Decline
WITH CurrRevenue AS 
(
    SELECT DATE_FORMAT(InvoiceDate, "%Y") AS 'Year', 
    SUM(Total) AS 'TotalRevenue'
    FROM Invoice
    GROUP BY Year
),
PrevRevenue AS
(
    SELECT DATE_FORMAT(InvoiceDate, "%Y")  AS 'Year', 
    SUM(Total) AS 'TotalRevenue'
    FROM Invoice
    GROUP BY Year
)
SELECT CurrRevenue.Year, CurrRevenue.TotalRevenue,
ROUND((CurrRevenue.TotalRevenue - PrevRevenue.TotalRevenue)/PrevRevenue.TotalRevenue*100, 2) AS '% Change'
FROM CurrRevenue
LEFT JOIN PrevRevenue
ON CurrRevenue.Year = PrevRevenue.Year + 1;