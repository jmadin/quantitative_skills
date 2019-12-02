# Intro to graphing

- Welcome to the graphing in R session.
- R is capable of producing publication-quality graphics. But, takes a bit of getting used to.
- During this session, we will  develop your R skills by introducing you to the basics of graphing. 

---

- Let's start by getting Rstudio up and running
- If you were here last week, you can just double-click your Rstudio project from last week.
- If you're new here, let's open Rstudio and create a new project
- Go to the file menu and click the "new folder" button, called this data.
- Data: [seed_root_herbivores.csv](http://acropora.bio.mq.edu.au/seed_root_herbivores.csv). 
- Copy the data into the data folder you made

--- 

#### Comment 1

- I read the feedback from last year, and somehow I need to reconcile "Josh moved to fast through the material" with "The graphing module moved way to slowly"
- It's hard to strike a balance, so please pipe up if you're falling behind.
- I will be moving slowly, so that as many people understand the material as possible.

#### Comment 2

- I also got the comment "Give Josh a microphone" -- so please let me know if I talk to softly

#### Comment 3

- Another comment was to include an outline.
- So in the spirit of R graphing...
- NOTE: I'll be using "graph", "figure", and "plot" interchangably

#### Outline

    source("R/functions.r")
    show_outline(0)

### Homework 

- If you find this too slow, start working on your noncompulsory homework:

```
blank_plot()
add_faces(5)
add_faces(100)
```

- I know, why am I a uni academic?  I should be in graphic design

#### Some of my graphs

- If you think about us all, graphing is the last bastion of creativity we have.  
- So enjoy it and develop a style you like.  People who read your papers will know you for it.
- As I alluded to in the intro session, tables are sometimes necessary, but always use figure instead if possible -- they really are worth to 1000 words, and can be absorbed much more quickly by someone skimming your paper, and are fun to make!

Here are some figure that I've made using R over the last few years... **DEMO**

## 2. Starting examples

    show_outline(2)

- R plotting is like painting on a canvas.  
- You can only add things, you can't take them away
- You can clear your canvas, or start a new canvas
- Which means you always need to start from scratch.
- Because we will be starting from scratch a lot, we need to keep track of our commands.
- So let's start an new R script. 

"graphing.R"

- Start by loading the data from last week.
- Is there anyone here who wasn't there last week?

```
data <- read.csv("data/seed_root_herbivores.csv", as.is=TRUE)
```

- How do we access the plant Height column?

```
data["Height"]
data[["Height"]]
data$Height
```

- Okay -- create a histogram of the height data

#### Histogram

    hist(data$Height)
    hist(data$Seed.heads)

- You can see that R does a lot of the basics for you by default
- There is so much you can change.  
- Simple things to change are labels and the main title, let's try

```
mtext("Number of seed heads", side=1, line=3)
```

Try again:

```
hist(data$Seed.heads, ann=FALSE)
mtext("Number of seed heads", side=1, line=3)
```

Or again:

```
hist(data$Seed.heads, xlab="Number of seed heads")
```

- **EXERCISE**: apply a transformation for count data, and make the main title say "Figure 1"

```
hist(sqrt(data$Seed.heads), xlab="Number of seed heads", main="Figure 1")
```

- You might need to look at the help file for `?hist`

#### Simple plot

    plot(data$Height, data$Seed.heads)

- Another useful way of ploting this is using formulas, which Drew will cover in more detail next week

```
plot(Seed.heads ~ Height, data)
```

- **EXERCISE**: from our earlier histogram of seed.heads, it's obvious that this is non-normal
- Replot Seed heads as a function of height applying an appropriate transformation to seed heads
- Also add some appropriate axis labels and a main title.

```
plot(sqrt(Seed.heads) ~ Height, data)
plot(sqrt(Seed.heads) ~ Height, data, xlab="Height, cm", ylab="Sqrt number of seed heads")
```

- You can also plot as lines, which doesn't make too much sense here:
```
plot(sqrt(Seed.heads) ~ Height, data, xlab="Height, cm", ylab="Sqrt number of seed heads", type="l")
and you can easily add another layer to a plot using a variety of functions including:
```

- The final handy function is points:

```
plot(sqrt(Seed.heads) ~ Height, data, xlab="Height, cm", ylab="Sqrt number of seed heads", type="n")
points(sqrt(Seed.heads) ~ Height, data=data[data$Root.herbivore==TRUE,], col="red")
points(sqrt(Seed.heads) ~ Height, data=data[data$Root.herbivore==FALSE,], col="green", pch=20)
```

- We'll come back to the plotting function again later

#### Boxplot

- A really useful plot for checking out your data

```
boxplot(data$Height)
boxplot(Height ~ Root.herbivore, data)
boxplot(Height ~ Root.herbivore, data, xlab="Root herbivores", ylab="Plant height, cm")
boxplot(Height ~ Root.herbivore, data, xlab="Root herbivores", ylab="Plant height, cm", notch = TRUE)
```

#### Pairs

- Great way to quickly access collinearity among variables

```
names(data)
comps <- names(data)[-1]
pairs(data[comps])
```

#### 3D plots

- Generally have to load an R package.
- However, two very useful varieties are Image and contour

```
image(volcano)
contour(volcano)
image(volcano, col=terrain.colors(50))
contour(volcano, add=TRUE)
```

#### Barplots
    
- Barplots are commonly used in biology, but are not as straightforward as you might hope in R. 
- There are a couple of basic things that missing in R, probably as a test!
- Remember last week, one is a function to calculate standard error, which you wrote last week

```
standard.error <- function(x) {
  sd(x)/sqrt(length(x))
}
```

- The other is an easy way to add standard error to plot
- So let's do this:

```
mn <- aggregate(data["Height"], data[c("Root.herbivore", "Seed.herbivore")], mean)
bp <- barplot(mn$Height)
```

- **QUESTION**: Why did I assign the barplot to a variable called "bp"?
- Type `bp`

```
se <- aggregate(data["Height"], data[c("Root.herbivore", "Seed.herbivore")], standard.error)
segments(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height)
```

- There are some issues here.  E.g., the upper se is above the plotting area.

```
bp <- barplot(mn$Height, ylim=c(0, 80))
segments(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height)
```

- We need some axis labels

```
axis(1, at=bp, labels=as.character(mn$Root.herbivore))
axis(1, at=bp, labels=as.character(mn$Seed.herbivore), las=2)
```

- How can we fix this?

```
herb_labels <- c("None", "Root only", "Seed only", "Both root and seed")

bp <- barplot(mn$Height, ylim=c(0, 80))
segments(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height)
axis(1, at=bp, labels=herb_labels, las=2)
```

- Oh oh... what happened?

```
title("Barplots are a pain...")
```

- This leads us to the wonderful and obscure world of graphing paramemeters

## 3. Global graphing parameters

```
show_outline(3)
```

- type `?par`
- The par function helps us design the layout and look and feel of plots.  
- These are global parameters.
- Meaning that once you set them, they hang around
- This is different to say the plot function.
- However, plotting functions usually only except some `par` variables. E.g., plot excepts `las`
- Other par vaiables can only be set globally,
- For example, `mfrow` allows us to do a plot with multiple panels, because each panel then has a plot, the number of panels must be set globally
- Some I'm just not even sure about...
- `mar` allows us to change the margins of a panel

--- 

- As a first step, let's fix the barplot

```
par(mar=c(9, 4, 4, 2))

bp <- barplot(mn$Height, ylim=c(0, 80))
segments(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height)
axis(1, at=bp, labels=herb_labels, las=2)

mtext("Degree of herbivory", side=1, line=7)
mtext("Plant height, cm", side=2, line=3)
title("Barplots are a pain...")
```

- Anything else missing?

- **EXERCISE**: put little bars at top and bottom of se bars?

```
arrows(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height, angle=90, code=3)
```

## 4. Saving graphs

    show_outline(4)

- You can save your plot by simply using the "Export" functionality in the RStudio GUI.  
- In general, plots should be saved as vector graphics files (i.e., PDF), because these "scale" (i.e., don't lose resolution as you zoom in).
- However, vector graphics files can get large and slow things down if they contain a lot of information, in which case you might want to save as a raster or image file (i.e., PNG).  
- PNGs work better on webpages and in presentations, because such software is not good at dealing with vector graphics. Do not ever save as a JPG.
- You can also save your plot from the command line.  Why would this be useful?
    1. You can control the exact dimensions of your plot, e.g., based on journal requirements.
    2. You can generate multiple plots in a single R script that get saved to a directory
    3. You know that each time to save them, they will be the same as you prescribed

---

- So, generally, unless you're actually building your plots, I'd suggest saving it straight to a folder
- To do so, you need to fire-up a graphics device (e.g., PDF or PNG), write the layers to the file, and then close the device off (you won't be able to open the file if you miss this last step).
- For the sake of good file management, let's first make a `figs` folder in our Rstudio project folder

```
pdf("figs/my_barplot.pdf", width=5, height=5)
  par(mar=c(9, 4, 4, 2))
  bp <- barplot(mn$Height, ylim=c(0, 80))
  arrows(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height, angle=90, code=3)
  axis(1, at=bp, labels=herb_labels, las=2)

  mtext("Degree of herbivory", 1, line=7)
  mtext("Plant height, cm", 2, line=3)
  title("Barplots are a pain...")
dev.off()
```
For png:

```
png("figs/my_barplot.png", width=400, height=400)
  par(mar=c(9, 4, 4, 2))
  bp <- barplot(mn$Height, ylim=c(0, 80))
  arrows(bp, mn$Heigh + se$Height, bp, mn$Heigh - se$Height, angle=90, code=3)
  axis(1, at=bp, labels=herb_labels, las=2)

  mtext("Degree of herbivory", 1, line=7)
  mtext("Plant height, cm", 2, line=3)
  title("Barplots are a pain...")
dev.off()
```

## 5. Multi-panel plots

    show_outline(5)

- A graphics device can have many panels.  
- `mfrow` allows you to add multiple frames by row - so each time you call a plot, it will be added to the next panel by rows first

```
op <- par(mfrow=c(2,2))
hist(data$Height)
hist(data$Height)
hist(data$Height)
hist(data$Height)
par(op)
```

- Panels may have the same information and axes don't need to be repeated.

```
op <- par(mfrow=c(2, 2), mar=c(1, 1, 1, 1), oma=c(4, 3, 4, 2))

hist(data$Height, ann=FALSE, axes=FALSE)
axis(2)
mtext("A", 3, -1, adj = 0)
box("plot", col="red")
box("figure", col="blue")

hist(data$Height, ann=FALSE, axes=FALSE)
mtext("B", 3, -1, adj = 0)
box("plot", col="red")
box("figure", col="blue")

hist(data$Height, ann=FALSE)
mtext("C", 3, -1, adj = 0)
box("plot", col="red")
box("figure", col="blue")

hist(data$Height, ann=FALSE, axes=FALSE)
axis(1)
mtext("D", 3, -1, adj = 0)
box("plot", col="red")
box("figure", col="blue")

mtext("x-axis", side=1, outer=TRUE, line=2)
mtext("y-axis", side=2, outer=TRUE, line=2)
mtext("title", side=3, outer=TRUE, line=1, cex=1.5)

par(op)
```

## 6. Towards publication quality

    show_outline(6)

Let's tidy up some plots for a paper:

```
plot(Seed.heads ~ Height, data, type="p", axes=FALSE, ann=FALSE, pch=21, col="white", bg="black")
axis(1)
axis(2, las=2)
mtext("Height, cm", side = 1, line = 3)
mtext("Number of seed heads", side = 2, line = 3)
title("Figure 1")
```

Let's add a little statistics:

```
mod <- lm(Seed.heads ~ Height, data)
abline(mod)
```

#### Prediction and confidence intervals

```
hs <- seq(min(data$Height), max(data$Height), 1)

seed_pred <- predict(mod, list(Height = hs), interval = "prediction")
lines(hs, seed_pred[,"lwr"], lty = 2)
lines(hs, seed_pred[,"upr"], lty = 2)

seed_conf <- predict(mod, list(Height = hs), interval = "confidence")
lines(hs, seed_conf[,"lwr"])
lines(hs, seed_conf[,"upr"])

mtext("A", side=3, adj=0, cex=1.5)
```

- Optional:

```
polygon(c(hs, rev(hs)), c(seed_conf[,"lwr"], rev(seed_conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)
```

#### Legends

- Legends typically take a bit of trial and error, but can do most things.

```
legend("topleft", c("green data", "actual data", "orange point"), pch=c(4, 20, 3), col=c("green", "black", "orange"), bty="n")
```

#### Adding text and equations

```
text(90, 50, expression(Y[i] == beta[0]+beta[1]*X[i1]+epsilon[i]))  # see demo(plotmath) for more examples
text(40, 1000, expression(N == (0.26 * H - 0.74)^2))
```

#### Final product

```
plot(Seed.heads ~ Height, data, type="p", axes=FALSE, ann=FALSE, pch=21, col="white", bg="black")
axis(1)
axis(2, las=2)
mtext("Height, cm", side = 1, line = 3)
mtext("Number of seed heads", side = 2, line = 3)
title("Figure 1")
abline(mod)
polygon(c(hs, rev(hs)), c(seed_conf[,"lwr"], rev(seed_conf[,"upr"])), col = rgb(0,0,0,0.2), border = NA)

mtext("A", side=3, adj=0, cex=1.5)

text(80, 50, "S = 7.97H - 217") # see demo(plotmath) for more examples

legend("topleft", c("green data", "actual data", "orange point"), pch=c(4, 20, 3), col=c("green", "black", "orange"), bty="n")
```

- Squareroot transform:

```
plot(Seed.heads ~ Height, data, type="p", axes=FALSE, ann=FALSE, pch=21, col="white", bg="black")
axis(1)
axis(2, las=2)
mtext("Height, cm", side = 1, line = 3)
mtext("Number of seed heads", side = 2, line = 3)
title("Figure 2")

mod_sqrt <- lm(sqrt(Seed.heads) ~ log(Height), data)

hs <- seq(min(data$Height), max(data$Height), 1)

seed_pred <- predict(mod_sqrt, list(Height = hs), interval = "prediction")
lines(hs, seed_pred[,"fit"]^2, lty = 1)
lines(hs, seed_pred[,"lwr"]^2, lty = 2)
lines(hs, seed_pred[,"upr"]^2, lty = 2)

seed_conf <- predict(mod_sqrt, list(Height = hs), interval = "confidence")
polygon(c(hs, rev(hs)), c(seed_conf[,"lwr"], rev(seed_conf[,"upr"]))^2, col = rgb(0,0,0,0.2), border = NA)

text(40, 900, expression(N == (0.26 * H - 0.74)^2))

mtext("B", side=3, adj=0, cex=1.5)
```

## 7. Other useful examples

    show_outline(7)

- The R package "ggplot" has become popular.  
- However, you need to learn a syntax that is somewhat different to standard R syntax (hence the reason we did not cover it here).

- The R package "lattice" is great for multivariate data. Here's the volcano again using `wireframe()`:

```    
library(lattice)
wireframe(volcano, shade = TRUE, aspect = c(61/87, 0.4), light.source = c(10,0,10))
demo(lattice)
```

- If you want to get visually fancy, then take a look at the R package "rgl".  Rstudio doesn't seem to handle rgl objects very well.

```
library(rgl)
rgl.points(rnorm(1000), rnorm(1000), rnorm(1000), color=heat.colors(1000))
demo(lsystem)
example(surface3d)
```

- Adding images to plots:

```
library(png)
plot(1, 1)
img <- readPNG("data/silh_digitate.png")
rasterImage(img, 1, 1, 1.5, 1.5)
```

And:

```
library(jpeg)
coral <- readJPEG("data/AC0047_F5_T_D_C.JPG")
rasterImage(coral, 0.6, 0.6, 1, 1)
```

