#clear information for source
rm(list=ls())

#dev.off clears figures. can cause error message if you use without figures. 
### load lab 2 workspace 
load("~/Desktop/ECMlab/lab2/lab2_env.RData")

#####question 1 #####

#test statistic = [−2∙ln(simple model)] − [−2∙ln(complex model)] 

#calculated p value from the test statistic 
pchisq(2*(BH.fit$value - dBH.fit$value), df=1, lower.tail=FALSE)

##!!!! you forgot to multiply by 2!!!, and there may be other problems on the theory side#

##### question 2 #####
##!!! I think the parameters are wrong, must ask about the signs as well 
#AIC model = 2∙k − 2∙ln(model),

#AIC model for BH
aicbh= 2*3+2*BH.fit$value

#AIC model for BH
aicdbh= 2*4+2*dBH.fit$value

aicdbh
aicbh
#delta AIC
deltaaic=aicdbh-aicbh
deltaaic
#####question 3#####

#steps of bootstrapping outside of for loop
boot <- sample(c(1:nrow(data)), replace=T)
data$bootR=data$R[boot] #this needs to be altered so it can change the name for each added column
data$bootSSB=data$SSB[boot]
dBH.fit = optim(par=p.dBH, fn=negLL.dBH, recruits=data$R, stock=data$SSB,
                method="Nelder-Mead", control=list(parscale=p.dBH, maxit=500000))
deltas=c()

#calculating bootstrapped data within forloop
deltas=numeric(1000)
for (i in 1:1000) {
boot <- sample(c(1:nrow(data)), replace=T) #this needs to be changed, have to make it repeat for each i
data$bootR=data$R[boot] # does not work
data$bootSSB=data$SSB[boot]
dBH.fit = optim(par=p.dBH, fn=negLL.dBH, recruits=data$bootR, stock=data$bootSSB,
                method="Nelder-Mead", control=list(parscale=p.dBH, maxit=500000)) 
deltas[i]=dBH.fit$par[4]
  } #there seems to be an extra 29 being added to the vector, which is the same as the number of rows. 

#histogram of delta distribution
hist(deltas,breaks = 24)
?hist
#calculation of 95% CI intervals. 
quantile(deltas, c(.05, .95))

#resampled stock data calculation


#####question 4 #####

#list of vectors
a_hat= BH.fit$par[1]
k_hat = BH.fit$par[2]
d_star=2
k_star = k_hat^d_star
a_star= a_hat*k_hat^(1-d_star)
sigma_star=BH.fit$par[3]

# sigma star will equal sigma hat. 
params_star=c(a_star,k_star,sigma_star,d_star)
   simulation1= function(params_star, stock) {
  predictions= dBH(params_star[1],params_star[2],stock,params_star[4])
  normies = rlnorm(nrow(data),meanlog=log(predictions)-params_star[3]^2/2, sdlog=params_star[3])
  return (normies)
   }

##### question 5 #####
 
 #creation of initial sims vector
 sim1 = simulation1(params_star,data$SSB)
 head(sim1)
 #transition of initial sims vector to a dataframe
 sims = data.frame(t(sim1))

 #creation of for loop for simulation
 for (i in 2:1000) {sims[i,] = simulation1(params_star,data$SSB)}
 
 #plot of simulated data
 plot(data$SSB,sims[1,], ylim=c(0,75000)) 
    for(i in 2:1000) {
    points(data$SSB,sims[i,])
    }
 
 #Creation of new sims columns 
 
sims$BH.nLL = 0
sims$dBH.nLL = 0
sims$delta = -999999 #we don't want to confuse this with an estimated delta
 
for ( i in nrow(sims)) {
  BH.fit = optim(par=p.BH, fn=negLL.BH, recruits=as.numeric(sims[i,1:29]), stock=data$SSB, 
                 method="Nelder-Mead", control=list(parscale=p.BH, maxit=500000))
  dBH.fit = optim(par=p.dBH, fn=negLL.dBH, recruits=as.numeric(sims[i,1:29]), stock=data$SSB, 
                  method="Nelder-Mead", control=list(parscale=p.dBH, maxit=500000))
  sims$BH.nLL[i] = BH.fit$value
  sims$dBH.nLL[i] = dBH.fit$value
  sims$delta[i] = dBH.fit$par[4]
}
 