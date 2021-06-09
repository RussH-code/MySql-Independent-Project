# MySql Independent Project (Music Store Analyst)

You are the lead data analyst for a popular music store. Help them analyze their sales and service!

Link to full description of project:
https://discuss.codecademy.com/t/data-science-independent-project-2-explore-a-sample-database/419945

## Preparing the Database

![Chinook Database Schematics](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/chinook_diagram.jpg)

Image Source: (https://stackoverflow.com/questions/60346886/sql-more-efficient-sql-query-against-chinook-database)

The database has 11 inter-connected tables that represents a digital media store. It has information about artists, their music tracks and sales preformance. It also contains employees and customers records.

### Acquiring the data
The database for MySql can be acquired in this Github Repository (https://github.com/lerocha/chinook-database).

### Loading the database
To load the database on MySql, make sure to put the `Chinook_MySql.sql` file in the MySql database directory.

To run the script, type `SOURCE C:/Chinook_MySql.sql.txt` in MySql command line client.


## Data Exploration and Analysis

### A. Most Popular Tracks
To find the most popular tracks among the playlists, we use `COUNT` function together with `GROUP BY` to find out the number of times each `TrackId` appears in the `PlaylistTrack` table. Then we join with the `Track` tables to also return the names of the tracks. Ordering `Count `by descending order makes it easy to find the top tracks.

![Most popular Tracks Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_1.PNG)

41 tracks are equally popular among all playlists (10 shown here), all appearing 5 times in all available playlists.

![Most popular Tracks Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_1.PNG)

### B. Most Lucrative Tracks
To better understand the most lucrative tracks, we aggregate the sales of each tracks with `SUM` functions. We also examine if tracks from a particular genre or album generated more sales.

![Most Lucrative Tracks Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_2.PNG)

It seems that popularity in playlist does not directly translate into sales. The most lucrative tracks mostly come from TV shows and dramas. 

![Most Lucrative Tracks Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_2.PNG)

### C. Sales Data by Country
We want to look at the sales figure by country. Additionally, we also want to look at the percentage makeup of each country in terms of total sales.

![Sales by Country Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_3.PNG)

The music store has the highest sales in USA (over one-fifth), followed by Canada and France. 

![Sales by Country Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_3.PNG)

### D. Sales Statistics
Now we want to see look at some summary statistics, such as the number of customers served by each employee, and the amount they spend on average. This is a bit more complex. We first use `WITH` to generate a temporary tables with the total amount each customers spend, then join that with the employee table to get the sales performance of each employee.

![Sales Statistics Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_4.PNG)

So there are three employees who directly interact with customers, each with around 20 customers. Their average sales per customer is similar. 

![Sales Statistics Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_4.PNG)

---

### Do longer or shorter length album tend to generate more revenue?
We can use the `WITH` function to create a temporary table to determine the length of each album, then aggregate the length in minutes of each album. 

![Long VS Short Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_5.PNG)

Album length in time seems to be related to sales performance, longer albums generated more revenue than shorter ones.

![Long VS Short Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_5.PNG)
![Long VS Short Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_5.1.PNG)


### Is the number of times a track appear in any playlist a good indicator of sales?
We again use `WITH` function to create temporary table that reflects the total revenue per track, then aggregate tracks in a playlist.

![Indicator Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_6.PNG)

As we can see, there does not seem to be a strong relationship between the two. 

![Indicator Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_6.PNG)


### Revenue Growth/Decline?
We first use `WITH` function to create two temporary tables, one for current year and one for previous year. Then join the two and calculate the percentage change.

![Revenue Change Code](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/code_7.PNG)


![Revenue Change Results](https://github.com/RussH-code/MySql-Independent-Project/blob/main/Images/results_7.PNG)
