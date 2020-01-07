## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(transplantr)
library(dplyr)

## ------------------------------------------------------------------------
# load dataset
data("liver.pts")

# remove redundant variables and calculate MELD
oltx_data = liver.pts %>%
  select(-Patient.Age, -Patient.Sodium) %>%
  mutate(MELD = meld(INR = Patient.INR, bili = Patient.Bilirubin, 
                     creat = Patient.Creatinine, dialysis = Patient.Dialysed))

# display result
oltx_data

## ---- eval = F-----------------------------------------------------------
#  meld(INR = 2.0, bili = 3.1, creat = 1.9, dialysis = 0, units = "US")

## ---- eval = F-----------------------------------------------------------
#  # calculate PELD where lab reports albumin in g/dl and bilirubin in µmol/l
#  paed.oltx2 = paed.oltx %>%
#    mutate(AlbuminX10 = Patient.Albumin * 10,
#           PELD = peld(INR = Patient.INR, bili = Patient.Bilirubin, albumin = AlbuminX10,
#                       listing_age = Patient.ListAge, growth_failure = Patient.GrowthFailure))
#  
#  # calculate PELD where lab reports albumin in g/l and bilirubin in mg/dl
#  paed.oltx2 = paed.oltx %>%
#    mutate(AlbuminDiv10 = Patient.Albumin / 10,
#           PELD = peld_US(INR = Patient.INR, bili = Patient.Bilirubin, albumin = AlbuminDiv10,
#                       listing_age = Patient.ListAge, growth_failure = Patient.GrowthFailure))
#  

