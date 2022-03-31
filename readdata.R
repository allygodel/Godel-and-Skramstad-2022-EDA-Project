
library(tidyverse)
library(readxl)
library(TSstudio)

read_excel("data/FluView_StackedColumnChart_Data.xlsx") %>% 
  transmute(
    year = YEAR,
    week = WEEK,
    total_specimens = `TOTAL SPECIMENS`,
    end_date = paste(year, week),
    date2 = as.Date(end_date, format = "%Y %V")
  )

KidsCount1_URL <- "https://datacenter.kidscount.org/rawdata.axd?ind=9714&loc=1"
download.file(KidsCount1_URL, "data/KidsCountInfluenza.xlsx", mode = "wb")

InfluenzeSchool <- 
  read_excel("data/KidsCountInfluenza.xlsx") %>% 
  print()

KidsCount2_URL <- "https://datacenter.kidscount.org/rawdata.axd?ind=10883&loc=1"
download.file(KidsCount2_URL, "data/KidsCountSARS.xlsx", mode = "wb")

SARSSchool <- 
  read_excel("data/KidsCountSARS.xlsx") %>% 
  separate(col = "TimeFrame", into = c("start_date", "end_date"), sep = "-") %>% 
  mutate(
    start_date = paste0(start_date, ", ", str_extract(end_date, "\\d{4}")),
    start_date = as.Date(start_date, format = "%b %e, %Y"),
    end_date = as.Date(end_date, format = "%b %e, %Y"),
    Data = as.numeric(Data)
  ) %>% 
  print()
#SARSSchool2 <- KIDSCountSARSNew

CDCSARS <- "https://covidtracking.com/data/download/national-history.csv"
download.file(CDCSARS, "data/CDCSARSTracker.csv")

SARSTracker1 <- 
  read_csv("data/CDCSARSTracker.csv") %>% 
  print()


#Will have to enter FluView_Stack for Influenza 2018-2019 manually through "Import Data"
view(FluView_StackedColumnChart_Data) %>% 
  print()

##??
FluView_StackedColumnChart_Data <-
  rename(
  FluView_StackedColumnChart_Data,
  Year = YEAR,
  A = A2009_H1N1
  )

InfluenzeSchool <-
  rename(
    Age = Age_group
  )
##??

## Graphs for Influenza School TimeSeries
print(FluView_StackedColumnChart_Data)

ggplot(InfluenzeSchool) +
  geom_jitter(mapping = aes(x = TimeFrame, y = Data))

##??
ggplot(InfluenzeSchool) +   
  geom_histogram(mapping = aes(x = Data))
##??

##Graphs for SARSTracker TimeSeries
print(SARSTracker)


##Graphs for SARSSchool 
print(SARSSchool2)

rename(SARSSchool2,
       Time_Frame = TimeFrame1,
       Time_Frame = TimeFrame2,
       Time_Frame = TimeFrame3,
       Time_Frame = TimeFrame4,
       )

##Online
ggplot(SARSSchool2) +
  geom_jitter(mapping = aes(x = TimeFrame1, y = OnlineResources))

##Paper
ggplot(SARSSchool2) +
  geom_jitter(mapping = aes(x = TimeFrame2, y = PaperMaterials))

##Cancelled
ggplot(SARSSchool2) +
  geom_jitter(mapping = aes(x = TimeFrame3, y = ClassesCancelled))

##Other Change
ggplot(SARSSchool2) +
  geom_jitter(mapping = aes(x = TimeFrame4, y = OtherChange))

##No Change, No Close
ggplot(SARSSchool2) +
  geom_jitter(mapping = aes(x = TimeFrame5, y = NoChangeNoClose))

SARSSchool %>% 
  distinct(COVIDImpactEduc)

SARSSchool %>% 
  distinct(LocationType)

SARSSchool %>% 
  filter(
    LocationType == "Nation",
    #COVIDImpactEduc == "Classes moved to distance learning: using online resources"
  ) %>% 
  ggplot(aes(x = end_date, y = Data)) +
  geom_point() +
  geom_line() +
  labs(
    title = "Classes moved to distance learning: using online resources",
    subtitle = "April 2020 to March 2021",
    x = "Date",
    y = "Percent of classes"
  ) +
  theme_bw(base_size = 16) +
  theme(
    legend.position = "bottom",
    legend.direction = "vertical"
  )
ggsave("covid_online.png")