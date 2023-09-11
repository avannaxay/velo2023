install.packages(c("httr","jsonlite"))
library(httr)
library(jsonlite)


base <- 'https://api.jcdecaux.com/vls/v1/stations?contract=Lyon&apiKey=80c6781a62951302976c8ecc3d565a095f877446'
raw_data <- GET(base)

tableauvélo <- fromJSON(rawToChar(raw_data$content), flatten = TRUE)

