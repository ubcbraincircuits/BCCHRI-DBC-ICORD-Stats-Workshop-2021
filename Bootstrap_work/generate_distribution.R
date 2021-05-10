library(PearsonDS)
dat1=rpearson(1400,moments=c(mean=100,variance=10,skew=.6,kurt=3))
hist(dat1)

dat2=rpearson(150,moments=c(mean=120,variance=5,skew=0,kurt=3))
hist(dat1)

dat=c(dat1, dat2)
hist(dat,breaks=20)

save(dat, file="dat.rda")

load("dat.rda")
