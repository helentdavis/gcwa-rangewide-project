
gcwa <- read.csv("surveyPoint_0.csv", header=T)
pts <- read.csv("pts_intersect.csv", header=T)
drop <- read.csv("droppts.csv", header=T)

gcwa <- gcwa[!is.na(gcwa$Point.Number),]

gcwa1 <- gcwa[,c(5,11)]
gcwa2 <- gcwa[,c(5,15)]
gcwa3 <- gcwa[,c(5,19)]

names(gcwa1)[2]<-"distance"
names(gcwa2)[2]<-"distance"
names(gcwa3)[2]<-"distance"

gcwa4 <- rbind(gcwa1, gcwa2, gcwa3)

library(ggplot2)

ggplot(gcwa4,aes(x=distance))+geom_histogram(binwidth = 10)+facet_wrap(~Observer)+theme_bw()+xlab("Distance (m)")+ylab("Number of Detections")

names(gcwa)[4]<-"pt_id"

gcwasurv <- as.data.frame( gcwa[,4])
gcwasurv$surveyed = "Y"
names(gcwasurv)[1]<-"pt_id"

status <- rbind(gcwasurv, drop)


merge <- merge(gcwa, pts, by="pt_id", all=T)
merge <- merge(merge, status, by="pt_id", all=T)

write.csv(merge, "merge_update.csv")

merge$surveyed[is.na(merge$surveyed)] <- "N"
mergetable <- table(merge$LoName, merge$surveyed)

write.csv(mergetable, "mergetable.csv")

