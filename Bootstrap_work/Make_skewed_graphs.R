library(fGarch)
#> Loading required package: timeDate
#> Loading required package: timeSeries
#> Loading required package: fBasics
library(ggplot2)
#> Loading required package: stats4
#> 
#> Attaching package: 'sn'
#> The following object is masked from 'package:fBasics':
#> 
#>     vech
#> The following object is masked from 'package:stats':
#> 
#>     sd

central_tendency_sim <- 0
dispersion_sim <- 1
skewness_sim <- 2

N_sim <- 10000

obs_sim <- seq(from = -5,
               to = 5,
               length.out = N_sim)

ggplot(data = data.frame(u = obs_sim),
       mapping = aes(x = u)) +
  stat_function(mapping = aes(),
                color="red",
                fun = dsnorm,
                args = list(mean = central_tendency_sim,
                            sd = dispersion_sim,
                            xi = skewness_sim))


ggplot(data = data.frame(u = obs_sim),
       mapping = aes(x = u)) +
  stat_function(mapping = aes(),
                fun = dnorm, color="blue")

