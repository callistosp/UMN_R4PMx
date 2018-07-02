## This R script compiles and runs simulations for simplePBPK model

## load libraries
library(dplyr)
library(mrgsolve)


#####  Chunk 1: Compile model  #####

mod <- mread("simplePBPK", "models")



#####  Chunk 2: Run a simple simulation  ####
## Simulate a 100 mg dose given as an IV bolus
mod %>%

  
#####  Chunk 3: Run a simple simulation-2  ####
## Simulate a 100 mg dose given as an IV bolus given every 8 hours for a 60 kg individual for 5 days
mod %>%

  
#####  Chunk 4: Multiple subjects simulations   ####
##Simulate 4 subjects with weights of 65, 72, 80, 55 with an infusion of 6 mg/kg given over a period of 2 hours
mod %>%