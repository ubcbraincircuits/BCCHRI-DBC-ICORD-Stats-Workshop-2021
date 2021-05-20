circadian <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter15/chap15e1KneesWhoSayNight.csv"))

circadian$treatment <- factor(circadian$treatment, 
                              levels = c("control", "knee", "eyes")) 

meanShift <- tapply(circadian$shift, circadian$treatment, mean)
sdevShift <- tapply(circadian$shift, circadian$treatment, sd)
n         <- tapply(circadian$shift, circadian$treatment, length)
data.frame(mean = meanShift, std.dev = sdevShift, n = n)

stripchart(shift ~ treatment, data = circadian, method = "jitter", vertical = TRUE)

seShift <- sdevShift / sqrt(n)
adjustAmount <- 0.15
segments( c(1,2,3) + adjustAmount, meanShift - seShift, 
          c(1,2,3) + adjustAmount, meanShift + seShift )
points(meanShift ~ c( c(1,2,3) + adjustAmount ))

par(bty="l")
adjustAmount <- 0.15
stripchart(shift ~ treatment, data = circadian, method = "jitter",
           vertical = TRUE, las = 1, pch = 1, xlab = "Light treatment",
           ylab = "Shift in circadian rhythm (h)", col = "firebrick", 
           cex = 1.2, ylim = c(-3, 1))
segments( c(1,2,3) + adjustAmount, meanShift - seShift, 
          c(1,2,3) + adjustAmount, meanShift + seShift )
points(meanShift ~ c( c(1,2,3) + adjustAmount ), pch = 16, col = "firebrick")

