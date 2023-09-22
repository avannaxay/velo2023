#Important(eviter d'installer à chaque fois un package)

if(!require(httr))
{
  install.packages("httr")
}
library(httr)
#
if(!require(jsonlite))
{
  install.packages("jsonlite")
}
library(jsonlite)
#
if(!require(RMySQL))
{
  install.packages("RMySQL")
}
library(RMySQL)
#
if(!require(esquisse))
{
  install.packages("esquisse")
}
library(esquisse) #pour faire graph en click boutton (copier code)
#exemple
esquisser(data=iris)
##############################

install.packages(c("httr","jsonlite"))
library(httr)
library(jsonlite)


base <- 'https://api.jcdecaux.com/vls/v1/stations?contract=Lyon&apiKey=80c6781a62951302976c8ecc3d565a095f877446'
raw_data <- GET(base)

tableauvelo <- fromJSON(rawToChar(raw_data$content), flatten = TRUE)


install.packages("RMySQL")
library(RMySQL)

### Données de toutes les stations
base_url = "https://api.jcdecaux.com/vls/v3"
contract = "Lyon"
apiKey = 80c6781a62951302976c8ecc3d565a095f877446

url = paste0(base_url, stations?, contract="Lyon", contract,
             &apiKey=80c6781a62951302976c8ecc3d565a095f877446, apiKey)
resultat = GET(url)
data = fromJSON(rawToChar(resultat$content))
df = do.call(rbind, data)

### Création de la connexion
con <- dbConnect(MySQL(),
                    user = "sql11646683",
                    password = "97qYcP8UNj",
                    host = "sql11.freesqldatabase.com",
                    dbname = "sql11646683")
#create table
dbWriteTable(con, "Communes", tableauvelo)
dbGetQuery(con, "SELECT * FROM Communes LIMIT 5;")
########################################################################
#RSHINY

install.packages("shiny")

library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Donee stations velo"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Nombre de bike stand",
                  min = 0,
                  max = max(tableauvelo$bike_stands),
                  value = 30)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)

##############
# Define server logic required to draw a histogram ----
server <- function(input, output) {

  output$distPlot <- renderPlot({
    
    x    <- tableauvelo$available_bikes
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#007bc2", border = "black",
         xlab = "nb velos dispo",
         main = "fréquence vélo dispo")
    
  })
  
}


shinyApp(ui = ui, server = server)


