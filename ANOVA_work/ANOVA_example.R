#clearing environment
rm(list=ls())

#loading dplyr
library(tidyverse) 

#setting working directory.
setwd("~/Desktop/Biol 404/assignment_data")

#download data
fertilized_block=read.csv("AnovaFertGrazeBlock3.csv")

#checking aspects of the data
head(fertilized_block)
str(fertilized_block)

#checking to see if block is a factor
is.factor(fertilized_block$block)

#creating a quick boxplot
ggplot(data=fertilized_block, aes(x=fertexpt1,y=growthexpt1))+geom_boxplot()

#creating the object for Anova
experiment1_model<-lm(growthexpt1~fertexpt1,data=fertilized_block)

#running the Anova
anova(experiment1_model)

#creating an object for comparing fertilizers
experiment2_model<-lm(growthexpt2~fertexpt2,data=fertilized_block)

anova(experiment2_model)

#creating an object for two way Anova
experiment1_grazing_model2=lm(growthexpt1~fertexpt1+grazing+fertexpt1:grazing,data=fertilized_block)
a=anova(experiment1_grazing_model2)
a
sum(a$`Sum Sq`)

#intalling Imertest
install.packages("lmerTest")
library(lmerTest)

#creating an object for random block 
random_block_model<-lmer(growthexpt2~fertexpt2+(1|block),data=fertilized_block)

#creating an obejct for random block question
mixed_effects_model<-lmer(growthexpt2~fertexpt2+(fertexpt2|block),data=fertilized_block)
anova(mixed_effects_model)
?anova()

