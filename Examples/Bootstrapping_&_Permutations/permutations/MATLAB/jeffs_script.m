%% load the distribution
%this is something non-gaussian that Jeff made up.  Meant to mimic the
%Verizon data from the textbook chapter 18.  Then take a look at it using
%hist.

load('dat.mat')
figure;hist(dat,20)

%% NB: Matlab has some built in functions for doing resampling, bootstraping, etc
% And there are more online...  I will mention a few of them as we go.  We will 
% also write some ourselves but I am not going to make any attempt to make this 
% efficient or elegant.  For learning purposes we are going to do things more 
% or less by hand.  With a computer.

%% make a resample.

% what does that mean?

% Draw samples with replacement (ie, they don't have to be unique) from the
% data.

% So we need a bunch of integers between 1 and 1550?  Simplest way to get
% them is the matlab randi command

% example for 10 values from 1 - 10:

randi(10,1,10)

% So the indices (store in a variable called ind) for our resample can be 
% found like this:
ind=randi(1550,1,1550);

% or get matlab to get the size of the sample using numel
ind=randi(numel(dat),1,numel(dat));

% So to get our resample all we need to do is index dat with ind and assign
% the result to a new variable.  Call it dat_RS.
dat_RS=dat(ind);


%% take a look at our resample:
% Use hist!
figure;hist(dat_RS,20)

%unless you get a peculiar resample it should look pretty much like the
%original one.

%% So now we should probably write a function to do the resampling for us

% hit new and function to get matlab to give you the function template and
% use the code above inside a loop to do lots of resamples.  Use 2 inputs
% 1. the data, can be called dat 2. the number of resamples, nresamps Store 
% your resamples in a matrix as output, call it resamps_out.  Remember to
% comment your code!!

% Write a command using our function to do 10 resamples.

dat_RS=make_resamples(dat,10);

% take a look at the resamples to see how their histograms look, do a loop
% and a subplot.

figure;
for i=1:10
    subplot(2,5,i);hist(dat_RS(i,:),20);
end

% Pretty similiar??  Should be...

%% ok, now that we can generate lots of resamples let's look at the mean of each.
% and the distribution of that.

% let's get 2000 resamples

dat_RS=make_resamples(dat,2000);

% easy to find the mean of the resamples.  Use mean and specify the second
% dimension.  Store the result in avg_RS

avg_RS=mean(dat_RS,2);

% So now we have the mean for each resample.  plot the distribution of
% that using hist again.

figure;hist(avg_RS,20)

% Btw, what was our actual sample mean? Use disp to display it.

disp(mean(dat))

%Where do you expect this to fall on the histogram?  What shape should this
%distribution have?

% What is this distribution?

% It's the bootstrap distriubtion of the sample mean.
% Let's try it again, this time introducing matlab's bootstrp function

% check doc bootstrp and use the function to find the means of 2000
% resamples.  store the result in a matrix called m for mean.

m = bootstrp(2000,@mean,dat);

% And again with two output args, if you want the resamples too! call them
% bootsam

[m,bootsam]=bootstrp(2000,@mean,dat);

%% How about the standard error?

% using our bootstrap distribution, call it avg_RS_se
avg_RS_se=std(avg_RS)
% using the bootstrap distribution from matlab, call it m_se
m_se=std(m)


%% And confidence intervals?

% a few different options here: option 1.  My sampling distribution looks
% Normal.  Then you can use critical t values and all is well.

% familiar equation stat +/- t*SE_stat
% for alpha=0.05;
tcrit = tinv(1-alpha/2,1550);
disp(['Lower: ' num2str( mean(m)-tcrit*std(m) ) ])
disp(['Upper: ' num2str( mean(m)+tcrit*std(m) ) ])


% Or using matlab's functions: (this one is slow on my laptop)
stu_ci = bootci(2000,{@mean,dat},'alpha',0.05,'type','student') % Studentized ci

% Ok, but what if it is not Normal?  Then what?
% Then you can look at the percentiles to make a CI

per_ci=bootci(2000,{@mean,dat},'alpha',0.05,'type','percentile')

% Does it make sense?  Figure out how many elements in our bootstrap
% distribution fall within these limits.  Use numel and find perhaps.

numel(find(m>per_ci(1) & m < per_ci(2)))/numel(m)

% Nice.  Willing to except a little descrepancy here since the bootci is
% calculating a new bootstrap distribution compared to the one we used for
% m.  

% or perhaps use the bias corrected accelerated confidence interval?
bca_ci=bootci(2000,{@mean,dat},'type','bca')
% It adjusts to correct for bias and skewness in the bootstrap distribution.  

%% Permutation testing.

%Let's make a couple of normal samples.  Call them x1 and x2.
% give x1 a mean of 1 and std of 2 and 27 data points
% give x2 a mean of 2 and std of 3 and 47 data points
% recall the matlab command randn gives random numbers from a standard
% normal curve.

x1=2*randn(1,27)+1;
x2=3*randn(1,47)+2;

% take a look at each of them using hist.

figure;hist(x1)
figure;hist(x2)

% add we want to look at the difference of the means? So calculate the
% observed difference from the samples.  Store in x_diff_obs.

x_diff_obs=mean(x2)-mean(x1)

% ok our null hypothesis is that there is no difference between the means
% of the two samples.  So we can build a distribution by resampling as if
% this were the case.  Call it the permutation distribution to distinguish 
% it from the bootstrap.  We have a total of 27 + 47=74 observtions.  Let's put
% them all together in a big vector by concatenation, call it x:

x=[x1 x2];

% now let's modify our make_resamples so that we can get resamples with a
% specific number of data points.  Start by saving your function with a new
% name make_samples2.  Don't forget to rename the function.  Add an extra
% input argument called nsamp which will be the number of data points in
% the resample.  Don't forget to update your comments.

% Check it by making a single resample. For x1 the extra argument should be
% 27 numel(x1) & should 47 (numel(x2)) for x2

x1_RS=make_resamples2(x,1,numel(x1));
x2_RS=make_resamples2(x,1,numel(x2));

% now make say 10000 resamples.

x1_RS=make_resamples2(x,50,numel(x1));
x2_RS=make_resamples2(x,50,numel(x2));

% find the means and subtract them, take the mean on the data points.
% Second dim.

x1_RS_avg=mean(x1_RS,2);
x2_RS_avg=mean(x2_RS,2);

x_diff=x1_RS_avg-x2_RS_avg;

% make a histogram to have a look at the distribution

figure;hist(x_diff,20)

% now figure out our p val.

% Assuming our alternate hypothesis is that mean of x2 > mean of x1

numel(find(x_diff>=x_diff_obs))/numel(x_diff)

%should be <0.05 for significance at alpha =0.05