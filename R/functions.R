# R Graphing outline & other functions

show_outline <- function(h=NA, sc=1) {
  tex_vec <- c(
    "Graphing in R",
    "Basic graphing functions",
    "Global graphical parameters",
    "Saving graphs",
    "Multiple panels",
    "Publication-quality example from scratch",
    "Beyond the basics"
  )  
  y <- seq(9.5, by=-1, length=length(tex_vec))
  n <- paste(seq(0, by=1, length=length(tex_vec)), ".", sep="")
  n[1] <- ""
  x <- rep(0.5, length(tex_vec))
  x[1] <- 0
  col_vec <- rep("black", length(tex_vec))
  col_vec[h+1] <- "orange"
  cex_vec <- rep(1.2, length(tex_vec))
  cex_vec[1] <- 1.8
  cex_vec <- cex_vec * sc
  
  op <- par(mar=c(0, 0, 0, 0))
  plot(0, 0, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
  text(x, y, paste(n, tex_vec), adj=0, cex=cex_vec, col=col_vec)
  par(op)
}

standard.error <- function(x) {
    sd(x)/sqrt(length(x))
}

add_face <- function(x, y, r) {
  # Head
  points(x, y, pch=21, bg="yellow", cex=r*2.5)
  # Nose
  points(x, y-(r/100), pch=24, cex=r/4, col="red", bg="red")    
  # Eyes
  points(x+(r/14), y+(r/20), pch=20, cex=r/4)
  points(x-(r/14), y+(r/20), pch=20, cex=r/4)
  # Mouth
  points(x, y-(r/11), pch=21, cex=r/3, lwd=2)    
  # Oh yeah!
  text(x+(r/4), y-(r/8), "\"Oh, yeah!\"", cex=r/5, bg="white")
}

add_faces <- function(n) {
  x <- rnorm(n, 5, 2)
  y <- rnorm(n, 5, 2)
  r <- runif(n) * 5
  mapply(add_face, x, y, r)
  return(n)
}

blank_plot <- function() {
  plot(0, 0, type="n", axes=FALSE, ann=FALSE, xlim=c(0, 10), ylim = c(0,10))
}
