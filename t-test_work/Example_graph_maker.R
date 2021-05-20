# https://stackoverflow.com/questions/36948624/shade-area-under-a-curve
# 1.75 and 2.12 
y=dt(seq(-5,5,by=.0001),17)
x=seq(-5,5,by=.0001)
plot(x,y,type="l",main="One Tailed",xlab="t",ylab="Probability Density")

polygon(c(x[x>=1.75], max(x), 1.75), c(y[x>=1.75], 0, 0), col="red")

polygon(c(x[x>=2.12], max(x), 2.12), c(y[x>=2.12], 0, 0), angle=45,col="red")
polygon(c(x[x<=-2.12], -2.12, min(x)), c(y[x<=-2.12], 0, 0), angle=45,col="red")
