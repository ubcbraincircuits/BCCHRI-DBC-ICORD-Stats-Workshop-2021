% Use pearsrnd to make a distribution to work with.  This should not look
% like a gaussian. So skewness, etc.

dat1=pearsrnd(100,10,.6,3,1,1400);
figure;hist(dat1);

dat2=pearsrnd(135,5,0,3,1,150);

dat=[dat1 dat2];
figure;hist(dat,20)

save('dat.mat','dat')

