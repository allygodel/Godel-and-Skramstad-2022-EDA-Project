
library(tidyverse)
library(readxl)

KidsCount1_URL <- "https://datacenter.kidscount.org/rawdata.axd?ind=9714&loc=1"
download.file(KidsCount1_URL, "data/KidsCountInfluenza.xlsx", mode = "wb")

InfluenzeSchool <- 
  read_excel("data/KidsCountInfluenza.xlsx") %>% 
  print()

KidsCount2_URL <- "https://datacenter.kidscount.org/rawdata.axd?ind=10883&loc=1"
download.file(KidsCount2_URL, "data/KidsCountSARS.xlsx", mode = "wb")

SARSSchool <- 
  read_excel("data/KidsCountSARS.xlsx") %>% 
  print()

CDCSARS <- "https://covidtracking.com/data/download/national-history.csv"
download.file(CDCSARS, "data/CDCSARSTracker.csv")

SARSTracker <- 
  read_csv("data/CDCSARSTracker.csv") %>% 
  print()

#Will have to enter FluView_Stack for Influenza 2018-2019 manually through "Import Data"
view(FluView_StackedColumnChart_Data) %>% 
  print()

rename(
  FluView_StackedColumnChart_Data,
  Year = YEAR,
  Total = TOTAL_SPECIMENS
  )


FluView_StackedColumnChart_Data <-
  rename(
    data = FluView_StackedColumnChart_Data, 
    total_specimens = Total
  )

ggplot(FluView_StackedColumnChart_Data) +
  geom_histogram(mapping = aes(x = YEAR))

ggplot(data = FluView_StackedColumnChart_Data) +
  geom_jitter(mapping = aes(x = TOTAL_SPECIMENS))

ggplot(data = FluView_StackedColumnChart_Data) +
  geom_jitter(mapping = aes(x = YEAR, y = TOTAL_SPECIMENS))
