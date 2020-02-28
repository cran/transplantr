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
data("kidney.donors")
kidney.donors

# change required variables to 1/0
kidney.donors2 = kidney.donors %>%
  mutate(Donor.Hypertension = if_else(Donor.Hypertension == TRUE, 1, 0),
         Donor.Sex = if_else(Donor.Sex == "F", 1, 0),
        Donor.CMV = if_else(Donor.CMV == "Pos", 1, 0))

# view updated dataset
kidney.donors2

## -----------------------------------------------------------------------------
# calculate UKKDRI 
kidney.donors3 = kidney.donors2 %>%
  mutate(UKKDRI = ukkdri(age = Donor.Age, height = Donor.Height, htn = Donor.Hypertension,
                         sex = Donor.Sex, cmv = Donor.CMV, gfr = Donor.GFR, 
                         hdays = Donor.Hospital_Stay),
         UKKDRI.Quartile = ukkdri_q(UKKDRI, prefix = TRUE, fct = TRUE))

# display results (with selected variables)
kidney.donors3 %>%
  select(Donor.Age, Donor.GFR, UKKDRI, UKKDRI.Quartile)

## -----------------------------------------------------------------------------
ukkdri(age = 50, height = 170, htn = 1, sex = "F", cmv = 0, gfr = 90, hdays = 2)

ukkdri_q(0.8572, prefix = T)

## ---- eval = F----------------------------------------------------------------
#  kidney.recipients2 = kidney.recipients %>%
#    mutate(UKKRRI = ukkrri(age = Recipient.Age, dx = Recipient.OnDialysis,
#                           wait = Recipient.Waittime, dm = Recipient.Diabetes),
#           UKKRRI.Quartile = ukkrri_q(UKKRRI, prefix = T))

## -----------------------------------------------------------------------------
watson_ukkdri(age = 40, htn = 0, weight = 75, hdays = 0, adrenaline = 0)

## ---- eval = F----------------------------------------------------------------
#  kidney.donors3us = kidney.donors2 %>%
#    mutate(USKDRI = uskdri(age = Donor.Age, height = Donor.Height, weight = Donor.Weight,
#                           eth = Donor.Race, htn = Donor.Hypertension, dm = Donor.Diabetes,
#                           cva = Donor.CVA, creat = Donor.Creatinine,
#                           hcv = Donor.HepatitisC, dcd = Donor.Type,
#                           scaling = 1.250697, units = "US"))

## -----------------------------------------------------------------------------
# with creatinine in µmol/l (units = "SI" can be omitted)
uskdri(age = 40, height = 170, weight = 80, eth = "non-black", htn = 0, dm = 0,
    cva = 0, creat = 120, hcv = 0, dcd = 0, scaling = 1.250697, units = "SI")

# with creatinine in mg/dl and omitting scaling factor
uskdri(age = 40, height = 170, weight = 80, eth = "non-black", htn = 0, dm = 0,
    cva = 0, creat = 1.4, hcv = 0, dcd = 0, units = "US")

## -----------------------------------------------------------------------------
# with creatinine in µmol/l (units = "SI" can be omitted)
kdpi(age = 40, height = 170, weight = 80, eth = "non-black", htn = 0, dm = 0,
    cva = 0, creat = 120, hcv = 0, dcd = 0, scaling = 1.250697, units = "SI")

# with creatinine in mg/dl
kdpi_US(age = 40, height = 170, weight = 80, eth = "non-black", htn = 0, dm = 0,
    cva = 0, creat = 1.4, hcv = 0, dcd = 0, scaling = 1.250697)

## ---- eval = F----------------------------------------------------------------
#  kidney.recipients2a = kidney.recipients %>%
#    mutate(EPTS.raw = raw_epts(age = Recipient.Age, dm = Recipient.Diabetes,
#                               prev_tx = Recipient.PreviousTransplant, dx = Recipient.Waittime),
#           EPTS = epts(age = Recipient.Age, dm = Recipient.Diabetes,
#                               prev_tx = Recipient.PreviousTransplant, dx = Recipient.Waittime))

## -----------------------------------------------------------------------------
raw_epts(age = 23.58, dm = 0, prev_tx = 1, dx = 5.081)
epts(age = 23.58, dm = 0, prev_tx = 1, dx = 5.081)

