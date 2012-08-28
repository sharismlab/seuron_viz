#load data
data <- read.csv("./data/BOXILAITAGS_stats.csv")
names <- data[2]

#export 
write.csv(names, file="./data/names.csv", row.names=FALSE)

