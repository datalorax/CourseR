setwd("/Users/Daniel/Dropbox/Teaching/CourseR/data/")

data(mtcars)
write.csv(mtcars, file = "cars.csv")

data(trees)
rand <- function(v) rbinom(length(v), 1, 0.3)
for(i in 1:ncol(trees)) {
	trees[ ,i] <- ifelse(rand(trees[ ,i]) == 1, NA, trees[ ,i])	
}
setwd("/Users/Daniel/Dropbox/Teaching/CourseR/")
write.table(trees, file = "./data/trees.txt", sep = "|", na = "999", 
	row.names = FALSE, col.names = FALSE)

data(USArrests)
write.csv(USArrests, file = "USViolentActs.csv")

data(longley)
write.csv(longley.csv)

data(attitude)
write.table(attitude, file = "attitude.txt", sep = "\t", row.names = FALSE)
