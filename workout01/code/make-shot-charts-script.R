#####################
# Draw Shots Charts #
#####################

# Description:
#    Scripts of creating shot charts with court background using shot-data.csv.

# Input(s):
#    shots-data.csv
#    nba-court.jpg

# Output(s):
#    andre-iguodala-shot-chart.pdf
#    draymond-green-shot-chart.pdf
#    kevin-durant-shot-chart.pdf
#    klay-thompson-shot-chart.pdf
#    stephen-curry-shot-chart.pdf
#    gsw-shot-chart.pdf
#    gsw-shot-chart.png



library(jpeg)
library(grid)
library(ggplot2)

# import data
datatype <- c("character", "character", "integer", "integer", "integer", "integer", 
              "factor", "factor", "factor", "integer", "factor", "integer", 
              "integer", "factor", "integer")
shotsdata <- read.csv("../data/shots-data.csv", colClasses = datatype, stringsAsFactors = FALSE)

# court image (to be used as background of plot)
# create raste object
court_image <- rasterGrob(readJPEG("../images/nba-court.jpg"), width = unit(1, "npc"), height = unit(1, "npc"))

# shot charts with court background
iguodala_shot_chart <- ggplot(data = shotsdata[shotsdata$name == "Andre Iguodala",]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

green_shot_chart <- ggplot(data = shotsdata[shotsdata$name == "Draymond Green",]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

durant_shot_chart <- ggplot(data = shotsdata[shotsdata$name == "Kevin Durant",]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

thompson_shot_chart <- ggplot(data = shotsdata[shotsdata$name == "Klay Thompson",]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

curry_shot_chart <- ggplot(data = shotsdata[shotsdata$name == "Stephen Curry",]) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

# export
pdf(file = "../images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
iguodala_shot_chart
dev.off()

pdf(file = "../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
green_shot_chart
dev.off()

pdf(file = "../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
durant_shot_chart
dev.off()

pdf(file = "../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
thompson_shot_chart
dev.off()

pdf(file = "../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
curry_shot_chart
dev.off()

# GSW_shot_chart
GSW_shot_chart <- ggplot(data = shotsdata) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size = 1) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: GSW (2016 season)') +
  facet_wrap(~name) + 
  theme_minimal()

pdf(file = "../images/gsw-shot-charts.pdf", width = 8, height = 7)
GSW_shot_chart
dev.off()

png(filename = "../images/gsw-shot-charts.png", width = 8, height = 7, units = "in", res = 250)
GSW_shot_chart
dev.off()


