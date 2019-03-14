#######################
# Make shots-data.csv #
#######################

# Description:
#    Data Preparation - Scripts of transfering raw data to shots-data.csv, which contains
#    the required variables to be used in the visualization phase.

# Input(s):
#    andre-iguodala.csv
#    draymond-green.csv
#    kevin-durant.csv
#    klay-thompson.csv
#    stephen-curry.csv

# Output(s):
#    dataframe: shotsdata
#    andre-iguodala-summary.txt
#    draymond-green-summary.txt
#    kevin-durant-summary.txt
#    klay-thompson-summary.txt
#    stephen-curry-summary.txt
#    shots-data.csv
#    shots-data-summary.txt 



# import data
datatype <- c("character", "character", "integer", "integer", "integer", "integer", 
              "character", "factor", "factor", "integer", "factor", "integer", "integer")
iguodala <- read.csv("../data/andre-iguodala.csv", colClasses = datatype, stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", colClasses = datatype, stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", colClasses = datatype, stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", colClasses = datatype, stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv", colClasses = datatype, stringsAsFactors = FALSE)


# add a column name for each player
iguodala$name <- "Andre Iguodala"
green$name <- "Draymond Dreen"
durant$name <- "Kevin Durant"
thompson$name <- "Klay Thompson"
curry$name <- "Stephen Curry"


# change the original values of shot_made_flag
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"


# add a column minute
iguodala$minute <- iguodala$period * 12 - iguodala$minutes_remaining
green$minute <- green$period * 12 - green$minutes_remaining
durant$minute <- durant$period * 12 - durant$minutes_remaining
thompson$minute <- thompson$period * 12 - thompson$minutes_remaining
curry$minute <- curry$period * 12 - curry$minutes_remaining


# sink(), summary()
sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = '../output/klay-thompson-summary.txt')
summary(thompson)
sink()

sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()

# rbind()
shotsdata <- rbind(iguodala, green, durant, thompson, curry)
shotsdata$shot_made_flag <- as.factor(shotsdata$shot_made_flag)

# export
write.csv(shotsdata, file = "../data/shots-data.csv", row.names = FALSE)

# sink(), summary()
sink(file = '../output/shots-data-summary.txt')
summary(shotsdata)
sink()


