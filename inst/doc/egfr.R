## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(transplantr)
library(dplyr)

## ------------------------------------------------------------------------
data(results)

results2 <- results %>%
  mutate(eGFR = ckd_epi(creat = Creatinine, age = Age, sex = Sex, eth = Ethnicity))

results2

## ------------------------------------------------------------------------
data(results_US)

# using the standard function
results_US2 <- results_US %>%
  mutate(eGFR = ckd_epi(creat = Creatinine, age = Age, sex = Sex,
        eth = Ethnicity, units = "US"))

# using the wrapper function
results_US3 <- results_US %>%
          mutate(eGFR = ckd_epi_US(creat = Creatinine, age = Age, sex = Sex,
          eth = Ethnicity))

results_US2

results_US3

## ---- eval = F-----------------------------------------------------------
#  mydata$eGFR <- ckd_epi(creat = SCr, age = Age, sex = Sex, eth = Ethnicity)

## ------------------------------------------------------------------------
data(serial.results)

serial.results2 <- serial.results %>%
  mutate(eGFR_1yr = ckd_epi(creat = Creatinine_1yr, age = Age, sex = Sex,
                    eth = Ethnicity, offset = 1),
         eGFR_5yr = ckd_epi(creat = Creatinine_5yr, age = Age, sex = Sex,
                    eth = Ethnicity, offset = 5))

serial.results2

## ---- eval = F-----------------------------------------------------------
#  results2m <- results %>%
#    mutate(eGFR = mdrd(creat = Creatinine, age = Age, sex = Sex, eth = Ethnicity))

## ---- eval = F-----------------------------------------------------------
#  results2p <- results %>%
#    mutate(eGFR = schwartz(creat = Creatinine, height = Height))

## ---- eval = F-----------------------------------------------------------
#  results2cg <- results %>%
#    mutate(Ideal.Weight = ibw(height = Height, sex = Sex),
#           CrClear = cockcroft(creat = Creatinine, age = Age, sex = Sex,
#                               weight = Ideal.Weight))

