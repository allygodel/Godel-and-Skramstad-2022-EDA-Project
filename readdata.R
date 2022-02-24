file1_url <- "https://datacenter.kidscount.org/rawdata.axd?ind=9714&loc=1"
download.file(file1_url, "data/file1.xlsx")
data1 <- read_excel("data/file1.xlsx")
