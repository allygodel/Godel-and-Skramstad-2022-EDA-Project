KidsCount1_URL <- "https://datacenter.kidscount.org/rawdata.axd?ind=9714&loc=1"
download.file(KidsCount1_URL, "data/file1.xlsx")
InfluenzeSchool <- read.xlsx(KidsCount1_URL)

KidsCount2_URL <- "https://datacenter.kidscount.org/rawdata.axd?ind=10883&loc=1"
download.file(KidsCount2_URL, "data/file1.xlsx")
SARSSchool <- read.xlsx(KidsCount2_URL)

CDCSARS <- "https://covidtracking.com/data/download/national-history.csv"
download.file(CDCSARS, "data/file1.csv")
SARSTracker <- read.csv(CDCSARS)

