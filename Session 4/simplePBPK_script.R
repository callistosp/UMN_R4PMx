## This R script compiles and runs simulations for simplePBPK model

## load libraries
library(dplyr)
library(mrgsolve)


#####  Chunk 1: Compile model  #####

mod <- mread("simplePBPK", "Session 4/models")

#####  Chunk 2: Run a simple simulation  ####
## Simulate a 100 mg dose given as an IV bolus
mod %>%
  ev(amt=100, cmt="VEN") %>%
  mrgsim(end=8, delta=0.1) %>%
  plot()

  
#####  Chunk 3: Run a simple simulation-2  ####
## Simulate a 100 mg dose given as an IV bolus given every 8 hours for a 60 kg individual for 5 days
mod %>%
  ev(amt=100, cmt="VEN", ii=8, addl=(5*3)-1) %>%
  param(WEIGHT=60) %>%
  mrgsim(end=5*24, delta=0.1) %>%
  plot()
  
#####  Chunk 4: Multiple subjects simulations   ####
##Simulate 4 subjects with weights of 65, 72, 80, 55 with an infusion of 6 mg/kg given over a period of 2 hours
data <- as_data_set(
  ev(amt=65*6, rate=65*6/2, ID=1, cmt="VEN", WEIGHT=65),
  ev(amt=72*6, rate=72*6/2, ID=1, cmt="VEN", WEIGHT=72),
  ev(amt=80*6, rate=80*6/2, ID=1, cmt="VEN", WEIGHT=80),
  ev(amt=55*6, rate=55*6/2, ID=1, cmt="VEN", WEIGHT=55)
)

mod %>% 
  data_set(data) %>%
  mrgsim(end=24) %>%
  plot()
