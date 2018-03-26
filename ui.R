
call.data <- read.csv("data/sfpd_dispatch_data_subset.csv", stringsAsFactors = FALSE)
shinyUI(fluidPage(
  titlePanel("2018 San Francisco Emergency Call Data"),
    

    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Map", h3("Map of Call Locations in SF"),
                           sidebarPanel(
                             
                             selectInput("sourceInput", "Choose Call Type",
                                         choices = c(call.data$call_type, "All"), selected = "All")
                           ),
                           leafletOutput("map")),
                  tabPanel("Histogram", plotOutput("plot"))
      )
    
  )
))