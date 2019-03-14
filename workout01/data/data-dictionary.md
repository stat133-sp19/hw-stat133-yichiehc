### **1. Title of Database:** shots-data.csv

### **2. Number of Observations:** 4334

### **3. Number of Variables:** 15

### **4. Variables Information:**

|Name|Data Type|Meas.|Description|
|:--:|:-------:|:---:|:-------------------------------------------:|
|team_name|character| | |
|game_date|character|MM/DD/YY| |
|season|integer|YYYY| |
|period|integer|period|An NBA game is divided into 4 periods of 12 mins each. For example, a value for period = 1 refers to the first period (the first 12 mins of the game).|
|minutes_remaining|integer|minute|The amount of time in minutes that remained to be played in a given period.|
|seconds_remaining|integer|second|The amount of time in seconds that remained to be played in a given period.|
|shot_made_flag|factor| |Indicates whether a shot was made (y/**"shot_yes"**) or missed (n/**"shot_no"**).|
|action_type|character| |The basketball moves used by players, either to pass by defenders to gain access to the basket, or to get a clean pass to a teammate to score a two pointer or three pointer.|
|shot_type|factor| |Indicates whether a shot is a 2-point field goal(**"2PT Field Goal"**), or a 3-point field goal(**"3PT Field Goal"**).|
|shot_distance|integer|feet|Distance to the basket.|
|opponent|character| | |
|x|integer|inches|The court's x-coordinate where a shot occurred.|
|y|integer|inches|The court's y-coordinate where a shot occurred.|
|name|factor| |**"Andre Iguodala"**, **"Draymond Green"**, **"Kevin Durant"**, **"Klay Thompson"**, and **"Stephen Curry"**|
|minute|numeric|minute|The minute number where a shot occurred. For instance, if a shot took place during period = 1 and minutes_remaining = 8, then this should correspond to a value minute = 4.|