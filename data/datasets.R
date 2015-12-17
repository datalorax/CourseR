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
write.csv(USArrests, file = "./data/USViolentActs.csv")

data(longley)
write.csv(longley.csv)

data(attitude)
write.table(attitude, file = "./data/attitude.txt", 
	sep = "\t", row.names = FALSE)


library(ltm)
data(LSAT)
m <- ltm(LSAT ~ z1)
theta <- factor.scores(m, resp.patterns = LSAT)
write.csv(theta[[1]], file = "./data/LSAT_theta.csv", row.names = FALSE)
