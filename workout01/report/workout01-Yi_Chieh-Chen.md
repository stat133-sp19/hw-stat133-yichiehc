Workout 01: GSW Shot Charts
================
Yi Chieh Chen
March 12, 2019

Who Has the Best Clutch Time Performance on Golden State Warriors?
==================================================================

<img src="../images/photos/GSW.jpg" width="80%" style="display: block; margin: auto;" />

Introduction
------------

The most interesting and thrilling part about basketball is that the result of a game can change rapidly during clutch time. Many games are determined by a final shot just a few seconds before a game ends. In basketball, the term **clutch time** is defined as "during the 4th quarter or overtime, with less than five minutes remaining, and neither team ahead by more than five points." Players' ability to make the final shot of a close game during final minutes is often crucial to the success of a team. Hence, the decision of athletes and coaches on who to execute the final shot is extremely important.

In this report, I will be looking at data of 5 main players of the NBA team Golden State Warriors, and try to figure out who has the best clutch time performance and whom the team should rely on during clutch time.

Data
----

The analysis in this report is based on the data set of the NBA team Golden State Warriors during 2016-2017 season. For more information, please see *data-dictionary.md*.

The 5 main players I will be looking at are:
+ 9 Andre Iguodala
+ 23 Draymond Green
+ 35 Kevin Durant
+ 11 Klay Thompson
+ 30 Stephen Curry

To understand the clutch time performance, I will be looking at **shot charts** and **effective shooting percentages** of each player, especially **effective shooting percentages during last 5 minutes of games**. The effective shooting percentage is calculated by total shots / made shots.
+ 2PT Effective Shooting Percentage by Player: 2 PT Field Goal effective shooting percentage by player, arranged in descending order by percentage.
+ 3PT Effective Shooting Percentage by Player: 3 PT Field Goal effective shooting percentage by player, arranged in descending order by percentage.
+ Effective Shooting Percentage by Player: Overall (i.e. including 2PT and 3PT Field Goals) effective shooting percentage by player, arranged in descending order by percentage.

Analysis
--------

#### 1. Effective Shooting Percentage

Before looking into stats of clutch time, we first take a look at the data of the whole games to get a sense of each player's overall performance. Followings are there tables of effective shooting percentages:

-   **2PT Effective Shooting Percentage by Player**

``` r
effective_shooting_2pt <- shotsdata %>%
  group_by(name) %>%
  summarise(total = sum(shot_type == "2PT Field Goal"), 
            made = sum(shot_made_flag == "shot_yes" & shot_type == "2PT Field Goal"), 
            perc_made = made/total) %>%
  arrange(desc(perc_made))

kable(effective_shooting_2pt)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Andre Iguodala |    210|   134|   0.6380952|
| Kevin Durant   |    643|   390|   0.6065319|
| Stephen Curry  |    563|   304|   0.5399645|
| Klay Thompson  |    640|   329|   0.5140625|
| Draymond Dreen |    346|   171|   0.4942197|

-   **3PT Effective Shooting Percentage by Player**

``` r
effective_shooting_3pt <- shotsdata %>%
  group_by(name) %>%
  summarise(total = sum(shot_type == "3PT Field Goal"), 
            made = sum(shot_made_flag == "shot_yes" & shot_type == "3PT Field Goal"), 
            perc_made = made/total) %>%
  arrange(desc(perc_made))

kable(effective_shooting_3pt)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Klay Thompson  |    580|   246|   0.4241379|
| Stephen Curry  |    687|   280|   0.4075691|
| Kevin Durant   |    272|   105|   0.3860294|
| Andre Iguodala |    161|    58|   0.3602484|
| Draymond Dreen |    232|    74|   0.3189655|

-   **Effective Shooting Percentage by Player**

``` r
effective_shooting_total <- shotsdata %>%
  group_by(name) %>%
  summarise(total = sum(shot_made_flag == "shot_yes") + sum(shot_made_flag == "shot_no"), 
            made = sum(shot_made_flag == "shot_yes"), 
            perc_made = made/total) %>%
  arrange(desc(perc_made))

kable(effective_shooting_total)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Kevin Durant   |    915|   495|   0.5409836|
| Andre Iguodala |    371|   192|   0.5175202|
| Klay Thompson  |   1220|   575|   0.4713115|
| Stephen Curry  |   1250|   584|   0.4672000|
| Draymond Dreen |    578|   245|   0.4238754|

From the tables above, we can tell that though Andre Iguodala has a relatively high effective shooting percentage, the main scorers on the Golden State Warriors are Kevin Durant, Klay Thompson, and Stephen Curry. They have a lot more attempts than Andre Iguodala and Draymond Green. As a result, I will only be considering Durant, Thompson, and Curry later on in this report when looking into data of clutch time since scoring is probably not Iguodala's and Green's main tasks on this team.

#### 2. Shot Charts

Shot charts can be a key indicator of how teams and players are performing.

<img src="../images/gsw-shot-charts.png" width="80%" style="display: block; margin: auto;" />

From the charts above, we can tell that, Andre Iguodala and Draymond Green obviously have less shots, which is the same as what we just discussed. Moreover, by looking at the location and the density of the dots, we can observe that Klay Thompson and Stephen Curry are better three–pointers and Kevin Durant is a better 2-pointer. This result is consistent with the one from effective shooting percentages in previous part of the report. Understanding this fact can help decide what to do in clutch situations. I will take about it more later.

#### 3. Effective Shooting Percentage of Last 5 Minutes

To get more accurate insights on clutch time performance, we next look at the stats of effective shooting percentage of last 5 minutes of games.

-   **2PT Effective Shooting Percentage of Last 5 Minutes by Player**

``` r
effective_shooting_2pt_last5 <- shotsdata %>%
  filter(minute >= 44) %>%
  group_by(name) %>%
  summarise(total = sum(shot_type == "2PT Field Goal"), 
            made = sum(shot_made_flag == "shot_yes" & shot_type == "2PT Field Goal"), 
            perc_made = made/total) %>%
  arrange(desc(perc_made))
kable(effective_shooting_2pt_last5)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Kevin Durant   |     39|    26|   0.6666667|
| Stephen Curry  |     47|    28|   0.5957447|
| Andre Iguodala |     12|     7|   0.5833333|
| Klay Thompson  |     23|    11|   0.4782609|
| Draymond Dreen |     34|    16|   0.4705882|

-   **3PT Effective Shooting Percentage of Last 5 Minutes by Player**

``` r
effective_shooting_3pt_last5 <- shotsdata %>%
  filter(minute >= 44) %>%
  group_by(name) %>%
  summarise(total = sum(shot_type == "3PT Field Goal"), 
            made = sum(shot_made_flag == "shot_yes" & shot_type == "3PT Field Goal"), 
            perc_made = made/total) %>%
  arrange(desc(perc_made))
kable(effective_shooting_3pt_last5)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Stephen Curry  |     66|    27|   0.4090909|
| Andre Iguodala |     10|     4|   0.4000000|
| Klay Thompson  |     38|    13|   0.3421053|
| Kevin Durant   |     19|     5|   0.2631579|
| Draymond Dreen |     15|     3|   0.2000000|

-   **Effective Shooting Percentage of Last 5 Minutes by Player**

``` r
effective_shooting_total_last5 <- shotsdata %>%
  filter(minute >= 44) %>% 
  group_by(name) %>% 
  summarise(total = sum(shot_made_flag == "shot_yes") + sum(shot_made_flag == "shot_no"), 
            made = sum(shot_made_flag == "shot_yes"), 
            perc_made = made/total) %>%
  arrange(desc(perc_made))
  
kable(effective_shooting_total_last5)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Kevin Durant   |     58|    31|   0.5344828|
| Andre Iguodala |     22|    11|   0.5000000|
| Stephen Curry  |    113|    55|   0.4867257|
| Klay Thompson  |     61|    24|   0.3934426|
| Draymond Dreen |     49|    19|   0.3877551|

From the tables above, we can observe that, from the perspective of effective shooting percentages of last 5 minutes, Kevin Durant has the best **overall** clutch time performance. Passing the ball to Durant or having him to execute the final shot in clutch situations might give the Golden State Warriors a better chance to win the game.

However, the **3PT** effective shooting percentage of last 5 minutes of Stephen Curry is a lot higher than Kevin Durant's. We can also see very clearly form the shot charts in previous part that Curry is a great three-point shooter. In a situation which it is possible to make a three-point shot, passing the ball to Curry more often and helping him get more offense opportunities might give the Golden State Warriors a better chance to win the game.

-   **Effective Shooting Percentage of Last 1 Minute by Player**

``` r
effective_shooting_total_last1 <- shotsdata %>%
  group_by(name) %>%
  filter(minute == 48) %>%
  summarise(
    total = sum(shot_made_flag == "shot_yes") + sum(shot_made_flag == "shot_no"),
    made = sum(shot_made_flag == "shot_yes"),
    perc_made = made / total
  ) %>%
  arrange(desc(perc_made))

kable(effective_shooting_total_last1)
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Andre Iguodala |      4|     4|        1.00|
| Draymond Dreen |      5|     3|        0.60|
| Klay Thompson  |     15|     6|        0.40|
| Kevin Durant   |     12|     3|        0.25|
| Stephen Curry  |     20|     5|        0.25|

It would be even more helpful for our analysis if we also take a look at effective shooting percentages of last 1 minute. However, for statistical reason, it is not realistic to do that in this report since we have too little samples.

Conclusion
----------

When it comes to which player is a better clutch performer on the Golden State Warriors, the discussion is usually surrounding Kevin Durant and Stephen Curry. According to the analysis above, we can conclude that, from the perspective of effective shooting percentages, whom the Golden State Warriors should rely on during clutch time depends on the shot location. Kevin Durant has the best overall and 2PT effective shooting percentages of last 5 minutes, and has better clutch time performance in these two aspects. Stephen Curry has the best 3PT effective shooting percentages of last 5 minutes, and has better clutch time performance in this aspect. When they only need 2 points to win or tie the game, or a two-point shot is the best choice of that current situation, giving Durant more opportunities to make attempts might be the better decision. On the other hand, when they need 3 points to win or tie the game, or a three-point shot is the best choice of that current situation, passing the ball to Curry more often and helping him get more offensive opportunities might give the team a better chance to win the game.

<img src="../images/photos/durant&curry.jpg" width="80%" style="display: block; margin: auto;" />

References
----------

-   [First Photo](https://www.youtube.com/watch?v=hzfh5nIHM0g)
-   [Second Photo](http://www.espn.com/espn/feature/story/_/id/19256296/golden-state-warriors-steph-curry-stopped-only-kevin-durant)
-   [Clutch Time Stats](http://www.nbaminer.com/clutch-time-stats/)
-   [Understanding Clutch Time Decisions: Myths and Truths (by Konstantinos Kotzias)](https://statathlon.com/understanding_clutch_time/)
-   [Analytics & Shot Selection (by Stephen Shea)](https://shottracker.com/articles/analytics-shot-selection)
