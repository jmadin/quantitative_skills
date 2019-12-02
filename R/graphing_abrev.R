
data <- read.csv("data/seed_root_herbivores.csv", as.is=TRUE)
data <- read.csv("https://raw.githubusercontent.com/jmadin/quantitative_skills/master/data/seed_root_herbivores.csv", as.is=TRUE)

head(data)

data$Height

hist(data$Height)
hist(data$Seed.heads)
mtext("Number of seed heads", side=1, line= 3)

hist(data$Seed.heads, ann=FALSE)
mtext("Number of seed heads", side=1, line= 3)

hist(data$Seed.heads, xlab="Number of seed heads")
?hist

hist(sqrt(data$Seed.heads), xlab="Number of seed heads", main="Figure 1")


plot(data$Height, data$Seed.heads)
plot(Seed.heads ~ Height, data=data)
plot(Seed.heads ~ Height, data=data, type="l")
lines(data$Height, data$Seed.heads, col="orange")
points(Seed.heads ~ Height, data=data[data$Root.herbivore==TRUE,], col="red")
points(Seed.heads ~ Height, data=data[data$Root.herbivore==FALSE,], col="green", pch="Q")

data[data$Root.herbivore==TRUE,]

boxplot(data$Height)
boxplot(Height ~ Seed.herbivore, data, xlab="Seed herbivores present")
boxplot(Height ~ Seed.herbivore + Root.herbivore, data, xlab="Seed herbivores present", notch=TRUE)

# Pairs
names(data)
pairs(data[,5:8])

# 3D plots

?volcano
head(volcano)
image(volcano)
contour(volcano)
image(volcano, col=terrain.colors(50))
contour(volcano, add=TRUE)

# barplot

standard.error <- function(x) {
  sqrt(var(x)/length(x))
}

mn <- aggregate(Height ~ Seed.herbivore + Root.herbivore, data=data, FUN=mean)
se <- aggregate(Height ~ Seed.herbivore + Root.herbivore, data=data, FUN=standard.error)
herb_labels <- c("No herbivores", "Seed herbivore\nonly", "Root herbivore\nonly", "Both seed and\nroot herbivores")


pdf("figs/figure1.pdf", height=6, width=5)

par(mar=c(8, 4, 4, 2))
bp <- barplot(mn$Height, ylim=c(0, 80))
arrows(bp, mn$Height - se$Height, bp, mn$Height + se$Height, code = 3, angle = 90)
axis(1, at=bp, labels=herb_labels, las=2)
title("Barplots are a pain...")
mtext("Height, cm", side=2, line=3)

dev.off()

png("figs/figure1.png", height=300, width=400)

par(mar=c(8, 4, 4, 2))
bp <- barplot(mn$Height, ylim=c(0, 80))
arrows(bp, mn$Height - se$Height, bp, mn$Height + se$Height, code = 3, angle = 90)
axis(1, at=bp, labels=herb_labels, las=2)
title("Barplots are a pain...")
mtext("Height, cm", side=2, line=3)

dev.off()

# Multi=panel

op <- par(mfrow=c(2, 2), mar=c(1, 1, 1, 1), oma=c(4, 3, 4, 2))

hist(data$Height, ann=FALSE, axes=FALSE)
axis(2)
mtext("A", side=3, line=0, adj=0)

box("plot", col="red")
box("figure", col="blue")

hist(data$Height, ann=FALSE, axes=FALSE)
mtext("B", side=3, line=0, adj=0)

hist(data$Height, ann=FALSE)
mtext("C", side=3, line=0, adj=0)

hist(data$Height, ann=FALSE, axes=FALSE)
axis(1)
mtext("D", side=3, line=0, adj=0)

box("plot", col="red")
box("figure", col="blue")
box("inner", col="orange")
box("outer", col="green")

mtext("x-axis", side=1, outer=TRUE, line=2)
mtext("y-axis", side=2, outer=TRUE, line=2)

mtext("title!", side=3, outer=TRUE, cex=1.5)

par(op)

# Pupblication qauilty figure

plot(sqrt(Seed.heads) ~ Height, data, axes=FALSE, ann=FALSE, pch=21, col="white", bg="black")
axis(1)
axis(2, las=2)
mtext("Height, cm", side=1, line=3)
mtext("Number of seed heads", side=2, line=3)

mod <- lm(sqrt(Seed.heads) ~ Height, data)
summary(mod)
abline(mod)

hs <- seq(min(data$Height), max(data$Height), 1)

seed_pred <- predict(mod, list(Height=hs), interval="prediction")
lines(hs, seed_pred[,"lwr"], lty=2)
lines(hs, seed_pred[,"upr"], lty="dashed")

seed_conf <- predict(mod, list(Height=hs), interval="confidence")
lines(hs, seed_conf[,"lwr"], lty=1)
lines(hs, seed_conf[,"upr"], lty=1)

polygon(
  c(hs, rev(hs)), 
  c(seed_conf[,"lwr"], rev(seed_conf[,"upr"])), 
  col=rgb(1, 0, 0, 0.2), border=NA
)

