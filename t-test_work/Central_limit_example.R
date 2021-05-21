flu <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter10/chap10e6AgesAtDeathSpanishFlu1918.csv"))
head(flu)

hist(flu$age, right = FALSE,main="Population Distribution",xlab="Age at death (yrs)",col="firebrick")

n <- 30
results <- vector()
for(i in 1:10000){
  AgeSample <- sample(flu$age, size = n, replace = FALSE)
  results[i] <- mean(AgeSample)
}

hist(results, right = FALSE, breaks = 50, col = "firebrick", las = 1, 
     xlab = "Mean age at death (yrs)", ylab = "Frequency", main = "Sampling Distribution")
text(52,360,"n = 30")
