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
