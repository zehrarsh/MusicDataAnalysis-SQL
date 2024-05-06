-- Q1(EASY):
use musics;
SELECT
RTRIM(LTRIM(
CONCAT(
COALESCE(first_name , ''),' '
,  COALESCE(last_name, '')
)
)) AS 'Name of senior most employee', title AS TITLE from employee where level="L7"; 

-- Q2(EASY) :
SELECT 
    billing_country AS ' Country Name',
    COUNT(*) AS 'Number of Invoices'
FROM
    invoice
GROUP BY billing_country
ORDER BY 'Number of Invoices' DESC
LIMIT 3;

-- Q3 (EASY):
SELECT 
    invoice_id,
    customer_id,
    invoice_date,
    billing_address,
    billing_city,
    billing_state,
    billing_country,
    billing_postal_code,
    total AS 'Total Invoice'
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

-- Q4(EASY):
SELECT 
    city AS "City",
    COUNT(customer_id) AS 'Number of customers in that city'
FROM
    customer
GROUP BY city
ORDER BY COUNT(customer_id) DESC
LIMIT 3;

-- Q5(EASY):
SELECT 
    billing_city AS "City",
    COUNT(total) AS 'Number of invoice totals in that city'
FROM
    invoice
GROUP BY billing_city
ORDER BY COUNT(total) DESC
LIMIT 1;

-- Q6(EASY):
SELECT 
    invoice.customer_id AS 'Customer ID',
    COUNT(invoice.invoice_id) AS 'Number of its invoice Ids',
    SUM(invoice_line.unit_price) AS 'Money Spent'
FROM
    invoice,
    invoice_line
WHERE
    invoice.invoice_id = invoice_line.invoice_id
GROUP BY invoice.customer_id
ORDER BY SUM(invoice_line.unit_price) DESC
LIMIT 3;

-- Q1 (Moderate):
SELECT 
    customer.first_name AS 'First name of Customer',
    customer.last_name AS 'Last Name of customer',
    customer.email AS ' Email of customer',
    genre.name AS ' Genre Name'
FROM
    customer
        LEFT JOIN
    invoice ON customer.customer_id = invoice.customer_id
        LEFT JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
        LEFT JOIN
    track ON invoice_line.track_id = track.track_id
        LEFT JOIN
    genre ON track.genre_id = genre.genre_id
WHERE
    genre.name = 'Rock'
GROUP BY customer.first_name , customer.last_name , customer.email
ORDER BY customer.email ASC;

-- Q2 (Moderate):
SELECT 
    artist.name AS ' Artist Name',
    COUNT(track.track_id) AS 'Total Track Count of Rock Bands'
FROM
    track
        LEFT JOIN
    album ON track.album_id = album.album_id
        LEFT JOIN
    artist ON album.artist_id = artist.artist_id
WHERE
    track.genre_id = 1
GROUP BY artist.name
ORDER BY COUNT(track.track_id) DESC
LIMIT 10;

-- Q3 ( Moderate):
SELECT 
    name AS 'Track Names',
    milliseconds AS ' Song Length in milliseconds'
FROM
    track
WHERE
    milliseconds > 190200
ORDER BY milliseconds DESC;

-- Q1 (Advance)-
SELECT 
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS Name,
    artist.name AS ' Artist Name',
    SUM(track.unit_price) AS 'Total Spent'
FROM
    customer
        LEFT JOIN
    invoice ON customer.customer_id = invoice.customer_id
        LEFT JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
        LEFT JOIN
    track ON invoice_line.track_id = track.track_id
        LEFT JOIN
    album ON track.album_id = album.album_id
        LEFT JOIN
    artist ON album.artist_id = artist.artist_id
GROUP BY CONCAT(customer.first_name,
        ' ',
        customer.last_name) , artist.name;
-- Q2 ( Advance)-
select DISTINCT invoice.billing_country as Country, FIRST_VALUE(genre.name)OVER (PARTITION BY invoice.billing_country )as "Genre Name"  , sum(track.unit_price)as "Total Spent" From customer
        LEFT JOIN
    invoice ON customer.customer_id = invoice.customer_id
        LEFT JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
        LEFT JOIN
    track ON invoice_line.track_id = track.track_id inner join genre on track.genre_id= genre.genre_id group by invoice.billing_country, genre.name;
    
    -- Q3 ( Advance)-
    select distinct invoice.billing_country as "Country", 
    first_value (concat(customer.first_name , " ", customer.last_name)) over(partition by invoice.billing_country) as "Customer Name" ,
    sum(track.unit_price) "Total Spent" from customer 
    inner join invoice on customer.customer_id=invoice.customer_id 
    left join invoice_line on invoice.invoice_id=invoice_line.invoice_id 
    left join track on invoice_line.track_id=track.track_id 
    group by customer.first_name, customer.last_name, invoice.billing_country;
    
    -- Q1(own)Write a query for Total number of tracks for each genre?-
    SELECT 
    genre.name as "Genre", COUNT(track.track_id) as "Count of tracks"
FROM
    track
        INNER JOIN
    genre ON track.genre_id = genre.genre_id
GROUP BY genre.name Order by COUNT(track.track_id) desc;
    
    -- q2 (Own) How much quantity of music tracks have been taken by each customer-
       select genre.name, count(track.track_id) from track inner join genre on track.genre_id=genre.genre_id group by genre.name;
   SELECT DISTINCT
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS 'Customer Name',
    SUM(invoice_line.quantity) AS 'Quantity taken'
FROM
    customer
        LEFT JOIN
    invoice ON customer.customer_id = invoice.customer_id
        INNER JOIN
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
GROUP BY CONCAT(customer.first_name,
        ' ',
        customer.last_name) order by  SUM(invoice_line.quantity) desc;

        