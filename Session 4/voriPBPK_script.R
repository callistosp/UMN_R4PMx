## This R script compiles and runs simulations for voriPBPK model; tasks here follow `Hands-on_slides_voriPBPK`

## load libraries
library(dplyr)
library(ggplot2)
library(mrgsolve)

#############################################################################################
##############################  Chunk 1: Compile model  #####################################
#############################################################################################

modA <- mread("voriPBPK", "Session 4/models")

#############################################################################################
#############################################################################################


#############################################################################################
#########################  Chunk 2: Run a simple simulation  ################################
#############################################################################################

## Simulate a 100 mg dose given as an IV bolus dose
modA %>%
  ev(amt=100, cmt="VEN") %>%
  mrgsim() %>%
  plot()

#############################################################################################
#############################################################################################


#############################################################################################
#################################  Chunk 3: Task 2  #########################################
#############################################################################################
## Simulate a 4 mg/kg voriconazole IV infusion dosing in an adult male infused over an hour 
## twice a day for seven days

## adjust general theme for plotting
th <- theme(axis.title=element_text(size=20),
            axis.text=element_text(size=15),
            legend.text=element_text(size=15))


### Code here:

#############################################################################################
#############################################################################################


#############################################################################################
#################################  Chunk 4: Task 3  #########################################
#############################################################################################
## Compare the plasma drug concentration-time profile at steady state to the observed data 
## in `inst/data/Adult_IV.csv`

obs <- read.csv("inst/data/Adult_IV.csv")  #load observed data

### Code here ###
wt <- 73  #adult body weight
dose <- 4*wt  
rate <- 4*wt
cmt <- "VEN"  #intravenous infusion

# simulate
sim <- as.data.frame(modA %>% 
                       ev(amt=dose, cmt=cmt, ii=12, addl=13, rate=rate, ss=1) %>% 
                       mrgsim(delta = 0.1, end = 12)) %>% 
  dplyr::filter(row_number() != 1)  

# plot
gp <- ggplot() + 
  geom_point(data = obs, aes(x=time, y=obs, col="observed"), size=2.5) + 
  geom_errorbar(data = obs, aes(x = time, y = obs, ymin=obs-sd, ymax=obs+sd), width=0) +
  geom_line(data = sim, aes(x=time, y=Cvenous, col="sim"), lwd=1) + 
  scale_colour_manual(name='', 
                      values=c('sim'='black', 'observed'='black'), 
                      breaks=c("observed","sim"),
                      labels=c("observed","predicted")) +
  guides(colour = guide_legend(override.aes = list(linetype=c(0,1), shape=c(16, NA)))) +
  labs(x="time (h)", y="Plasma concentration (mg/L)") +
  th
gp

#############################################################################################
#############################################################################################


#############################################################################################
#################################  Chunk 5: Task 4  #########################################
#############################################################################################
## Generate pediatric model

# pediatric (5 yo) male physiology; https://www.ncbi.nlm.nih.gov/pubmed/14506981
pedPhys <- list(WEIGHT = 19,
                Vad = 5.5,
                Vbo = 2.43,
                Vbr = 1.31,
                VguWall = 0.22,
                VguLumen = 0.117,
                Vhe = 0.085,
                Vki = 0.11,
                Vli = 0.467,
                Vlu = 0.125,
                Vmu = 5.6,
                Vsp = 0.05,
                Vbl = 1.5,
                Qad = 0.05*3.4*60,
                Qbo = 0.05*3.4*60,
                Qbr = 0.12*3.4*60,
                Qgu = 0.15*3.4*60, 
                Qhe = 0.04*3.4*60,
                Qki = 0.19*3.4*60,
                Qmu = 0.17*3.4*60,
                Qsp = 0.03*3.4*60,
                Qha = 0.065*3.4*60, 
                Qlu = 3.4*60,
                MPPGL = 26,
                VmaxH = 120.5,
                KmH = 11)

### Code here:


#############################################################################################
#############################################################################################


#############################################################################################
#################################  Chunk 6: Task 5  #########################################
#############################################################################################
## Simulate a 4 mg/kg voriconazole IV infusion dosing in a pediatric male subject infused 
## with a rate of 3 mg/kg/h twice a day for seven days

### Code here:


#############################################################################################
#############################################################################################


#############################################################################################
#################################  Chunk 7: Task 6  #########################################
#############################################################################################
## Compare the plasma drug concentration-time profile at steady state to the observed data 
## in inst/data/Pediatric_IV.csv

obs <- read.csv("inst/data/Pediatric_IV.csv")  #load observed data

### Run this:
wt <- 19  #adult body weight
dose <- 4*wt  
rate <- 3*wt
cmt <- "VEN"  #intravenous infusion

# simulate
sim <- as.data.frame(modP %>% 
                       ev(amt=dose, cmt=cmt, ii=12, addl=13, rate=rate, ss=1) %>% 
                       mrgsim(delta = 0.1, end = 12)) %>% 
  dplyr::filter(row_number() != 1)  

# plot
gp <- ggplot() + 
  geom_point(data = obs, aes(x=time, y=obs, col="observed"), size=2.5) + 
  geom_errorbar(data = obs, aes(x = time, y = obs, ymin=obs-sd, ymax=obs+sd), width=0) +
  geom_line(data = sim, aes(x=time, y=Cvenous, col="sim"), lwd=1) + 
  scale_colour_manual(name='', 
                      values=c('sim'='black', 'observed'='black'), 
                      breaks=c("observed","sim"),
                      labels=c("observed","predicted")) +
  guides(colour = guide_legend(override.aes = list(linetype=c(0,1), shape=c(16, NA)))) +
  labs(x="time (h)", y="Plasma concentration (mg/L)") +
  th
gp

