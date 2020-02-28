## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(transplantr)
library(dplyr)

## -----------------------------------------------------------------------------
# load dataset
data("liver.pts")

# remove redundant variables and calculate MELD
oltx_data = liver.pts %>%
  select(-Patient.Age, -Patient.Sodium) %>%
  mutate(MELD = meld(INR = Patient.INR, bili = Patient.Bilirubin, 
                     creat = Patient.Creatinine, dialysis = Patient.Dialysed))

# display result
oltx_data

## ---- eval = F----------------------------------------------------------------
#  meld(INR = 2.0, bili = 3.1, creat = 1.9, dialysis = 0, units = "US")

## ---- eval = F----------------------------------------------------------------
#  # calculate full SOFT score using international units
#  soft(Age = 35, BMI = 20, PrevTx = 0, AbdoSurg = 1, Albumin = 30, Dx = 0,
#       ICU = 0, Admitted = 0, MELD = 29, LifeSupport = 0, Encephalopathy = 1,
#       PVThrombosis = 0, Ascites = 1, PortalBleed = 0, DonorAge = 44,
#       DonorCVA = 0, DonorSCr = 110, National = 0, CIT = 8)
#  
#  # calculate full SOFT score using US units
#  soft(Age = 35, BMI = 20, PrevTx = 0, AbdoSurg = 1, Albumin = 3.0, Dx = 0,
#       ICU = 0, Admitted = 0, MELD = 29, LifeSupport = 0, Encephalopathy = 1,
#       PVThrombosis = 0, Ascites = 1, PortalBleed = 0, DonorAge = 44,
#       DonorCVA = 0, DonorSCr = 1.2, National = 0, CIT = 8, Units = "US")
#  
#  # calculate P-SOFT score
#  p_soft(Age = 65, BMI = 36, PrevTx = 2, AbdoSurg = 1, Albumin = 29,
#         Dx = 0, ICU = 0, Admitted = 1, MELD = 32, LifeSupport = 0,
#         Encephalopathy = 1, PVThrombosis = 1, Ascites = 1)
#  
#  # calculate P-SOFT with US units
#  p_soft_US(Age = 65, BMI = 36, PrevTx = 2, AbdoSurg = 1, Albumin = 2.9,
#            Dx = 0, ICU = 0, Admitted = 1, MELD = 32, LifeSupport = 0,
#            Encephalopathy = 1,PVThrombosis = 1, Ascites = 1)
#  
#  # adding P-SOFT and SOFT as two variables to a tibble using a dplyr pipe
#  liver.recipients = liver.recipients %>%
#    mutate(P.Soft = p_soft(age, bmi, prev.tx, abdo.surg, albumin, dialysis,
#                           icu, admitted, meld.score, life.support,
#                           encephalopathy, pv.thrombosis, ascites),
#           Soft = soft2(P.Soft, portal.bleed, donor.age, donor.cva, donor.SCr,
#                        sharing, cit))

## ---- eval = F----------------------------------------------------------------
#  # calculate DRI
#  liver_dri(age = 64, cod = "cva", eth = "white", dcd = 0,
#            split = 0, share = "local", cit = 14, height = 170)
#  
#  # calculate ET-DRI
#  et_dri(age = 39, cod = "trauma", dcd = 0, split = 0,
#         share = "local", cit = 8, ggt = 50, rescue = 0)
#  

## ---- eval = F----------------------------------------------------------------
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

## ---- eval = F----------------------------------------------------------------
#  # calculate Pedi-SOFT score
#  pedi_soft(CTVG = 1, Weight = 10, Dx = 0, LifeSupport = 0, PrevTx = 0) # 4

