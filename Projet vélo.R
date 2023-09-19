install.packages(c("httr","jsonlite"))
library(httr)
library(jsonlite)


base <- 'https://api.jcdecaux.com/vls/v1/stations?contract=Lyon&apiKey=80c6781a62951302976c8ecc3d565a095f877446'
raw_data <- GET(base)

tableauvelo <- fromJSON(rawToChar(raw_data$content), flatten = TRUE)


install.packages("RMySQL")
library(RMySQL)

con <- dbConnect(MySQL(),
                    user = "sql11646683",
                    password = "97qYcP8UNj",
                    host = "sql11.freesqldatabase.com",
                    dbname = "sql11646683")
#create table
dbWriteTable(con, "Communes", tableauvelo)
dbGetQuery(con, "SELECT * FROM Communes LIMIT 5;")


