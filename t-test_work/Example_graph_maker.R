# https://stackoverflow.com/questions/36948624/shade-area-under-a-curve

x <- seq(0, 20, by = .1)
y <- dnorm(x, mean = 10, sd = 2.5)

# now we plot the distribution
plot(x,y,type='l', main="Example of a sampling distribution", ylab='Probability',
     xlab='Sample Statistic')

polygon(c(x[x>=1250], max(x), 1250), c(y[x>=1250], 0, 0), col="red")
