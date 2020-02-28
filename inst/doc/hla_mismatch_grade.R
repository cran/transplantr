## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(transplantr)
library(dplyr)
data(mismatches)

## -----------------------------------------------------------------------------
# create new mismatch level variable using a dplyr pipe
mismatches %>%
  select(-HLA.MM, -HLA.MM.s) %>%
	mutate(Mismatch.Level = hla_mm_level(a = HLA.A.MM, b = HLA.B.MM, dr = HLA.DR.MM))

## -----------------------------------------------------------------------------
# if the HLA.Mismatch variable does not use separators
mismatches %>%
  select(HLA.MM) %>%
  mutate(Mismatch.Level = hla_mm_level_str(mm = HLA.MM, sep = FALSE))

# if the HLA.Mismatch variable does use separators, sep is optional
mismatches %>%
  select(HLA.MM.s) %>%
  mutate(Mismatch.Level = hla_mm_level_str(mm = HLA.MM.s))

