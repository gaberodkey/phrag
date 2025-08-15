library(sf)
library(tidyverse)
library(tmap)
library(lwgeom)
library(units)
library(ggplot2)
library(hexbin)
library(dplyr)
library(gstat)
library(tigris)
library(readr)
library(mosaic)
rm(list=ls())
setwd("/Users/michaelweatherford/Library/Mobile Documents/com~apple~CloudDocs/School Work/Research")

seeds<-read_csv("Seeds.csv")

#Calculating the estimated number of seeds per inflor
seeds$SpikeTot<-(seeds$Stripped_Inflor_Wt/(seeds$Wt_counted_spikelets/seeds$Num_Spike_Counted))

seeds$SeedsTot<-(seeds$SpikeTot*seeds$Avg_SeedsPerSpike)

#Checking distribution to see if normal (it wasn't)
ggplot(seeds,aes(x=SeedsTot))+
  theme_classic()+
  geom_histogram(binwidth=100)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(seeds$SeedsTot, seeds$Treatment, shapiro.test)

#Normalizing data and rechecking
seeds$LogSeeds<-log(seeds$SeedsTot+1)

ggplot(seeds,aes(x=LogSeeds))+
  theme_classic()+
  geom_histogram(binwidth=0.1)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(seeds$LogSeeds, seeds$Treatment, shapiro.test)

var.test(data=seeds, LogSeeds ~ Treatment)
#Log of the seed production normalized the data now running test and making graphs

t.test(data=seeds , LogSeeds ~ Treatment)

SeedsSummary<-summarise(group_by(filter(seeds,!is.na(SeedsTot)),Treatment),count=n(),meanSeeds=mean(SeedsTot),SEseeds=sd(SeedsTot)/sqrt(n()))

ggplot(SeedsSummary,aes(x=Treatment,y=meanSeeds,fill=Treatment))+
  theme_classic()+
  geom_col()+
  geom_errorbar(aes(x= Treatment, ymin=meanSeeds-SEseeds, ymax=meanSeeds+SEseeds),width=0.1)+
  labs(x="Herbicide Treatment Level", y="Mean Seeds Per Inflorescence")

###GERMINATION---------------------------------------------------------------------------------------------------------------------------------

germ<-read_csv("Germination.csv")

#Checking distribution (not normally distributed)
ggplot(germ,aes(x=GermRate))+
  theme_classic()+
  geom_histogram(binwidth=0.01)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(germ$GermRate, germ$Treatment, shapiro.test)

#Normalizing data using log and checking again

germ$LogGerm<-log(germ$GermRate+1)

ggplot(germ,aes(x=LogGerm))+
  theme_classic()+
  geom_histogram(binwidth=0.01)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(germ$LogGerm, germ$Treatment, shapiro.test)

var.test(data=germ, LogGerm ~ Treatment)

#Trying square root to normalize

germ$SqrtGerm<-sqrt(germ$GermRate+1)

ggplot(germ,aes(x=SqrtGerm))+
  theme_classic()+
  geom_histogram(binwidth=0.01)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(germ$SqrtGerm, germ$Treatment, shapiro.test)

var.test(data=germ, SqrtGerm ~ Treatment)

#Trying inverse transformation to normalize

germ$InvGerm<-1/(germ$GermRate+1)

ggplot(germ,aes(x=InvGerm))+
  theme_classic()+
  geom_histogram(binwidth=0.01)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(germ$InvGerm, germ$Treatment, shapiro.test)

var.test(data=germ, InvGerm ~ Treatment)

#No normalization worked so going to run a non normalized t-test

t.test(data=germ , GermRate ~ Treatment, paired=FALSE)

GermSummary<-summarise(group_by(filter(germ,!is.na(GermRate)),Treatment),count=n(),meanGerm=mean(GermRate),SEgerm=sd(GermRate)/sqrt(n()))

ggplot(GermSummary,aes(x=Treatment,y=meanGerm,fill=Treatment))+
  theme_classic()+
  geom_col()+
  geom_errorbar(aes(x= Treatment, ymin=meanGerm-SEgerm, ymax=meanGerm+SEgerm),width=0.1)+
  labs(x="Herbicide Treatment Level", y="Mean Germination Rate")

#HERBICIDE DAMAGE---------------------------------------------------------------------------------------------

herbdmg<-read_csv("HerbDMG.csv")

#Checking distribution to see if normal
ggplot(herbdmg,aes(x=avgDmg))+
  theme_classic()+
  geom_histogram(binwidth=0.1)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(seeds$SeedsTot, seeds$Treatment, shapiro.test)

#Normalizing data and rechecking
herbdmg$LogHerbDMG<-log(herbdmg$avgDmg+1)

ggplot(herbdmg,aes(x=LogHerbDMG))+
  theme_classic()+
  geom_histogram(binwidth=0.1)+
  facet_wrap(~ Treatment, ncol = 1)

tapply(herbdmg$LogHerbDMG, herbdmg$Treatment, shapiro.test)

var.test(data=herbdmg, LogHerbDMG ~ Treatment)

#Data is normal but variance is not equal going to still just continue

t.test(data=herbdmg , LogHerbDMG ~ Treatment)

HerbDMGSummary<-summarise(group_by(filter(herbdmg,!is.na(avgDmg)),Treatment),count=n(),meanDmg=mean(avgDmg),SEdmg=sd(avgDmg)/sqrt(n()))

ggplot(HerbDMGSummary,aes(x=Treatment,y=meanDmg,fill=Treatment))+
  theme_classic()+
  geom_col()+
  geom_errorbar(aes(x= Treatment, ymin=meanDmg-SEdmg, ymax=meanDmg+SEdmg),width=0.1)+
  labs(x="Herbicide Treatment Level", y="Mean Damage from Herbicide")

ggplot(herbdmg, aes(x=Treatment, y=avgDmg,fill=Treatment))+
  theme_classic()+
  geom_boxplot()+
  labs(x="Herbicide Treatment Level", y="Average Damage")
##########