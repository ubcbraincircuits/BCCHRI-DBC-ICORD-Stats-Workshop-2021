# let's simulate 10,000 one sample t-tests. our null hypothesis will be no difference between the mean. 
# for 9000 tests, the null hypothesis will be true (The mean of the sample and the null are both 10). 
# For 1000 tests, the null hypothesis will be false (The mean of the sample is 8 and the mean of 
# the null 10).

# We are going to use something very similar to the for loops we used to estimate the type 1 error rate 
# in the t-test section (line 85). set your alpha value to 0.05 and set the number of times we are going 
# to run the t-test with the null be true and the number of times with the null being false. 
N_iter_same=9000
N_iter_diff=1000
alpha=0.05

# I am going to create some empty vectors (basically just a list of values) for us to fill up with our 
# for loop
p_same=vector()
p_diff=vector()

# Now create 2 loops that run a t-test and then save the p-value in our vectors. 
for (i in 0:N_iter_same){
  x=rnorm(20, mean=10, sd=2.5)
  p=t.test(x,mu=10,alternative="g")[["p.value"]]
  p_same[i]=p
}

for (i in 0:N_iter_diff){
  x=rnorm(20, mean=10, sd=2.5)
  p=t.test(x,mu=8,alternative="g")[["p.value"]]
  p_diff[i]=p
}

# Now create a histogram for both sets of P-values. 
hist(p_same, breaks=20, col=col)
hist(p_diff, breaks=20, col=col)

# now combine all of the P-values together using c(). Call this combined vector p_all. 
p_all=c(p_same,p_diff)

# Create a histogram of P-all
hist(p_all, breaks=20)

# now add some extra detail using the code below. 
abline(h=450, col="red")
polygon(c(0,0,0.05,0.05),c(0,450,450,0), col="red")
polygon(c(0,0,0.05,0.05),c(450,1500,1500,450), col="blue")

# The purpose of Banjamini-Hockberg is to sort our significant P-values into this blue to reject group 
# and this red not to reject group. 
