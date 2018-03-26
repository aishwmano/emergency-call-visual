
library("leaflet")
library("shiny")
library("dplyr")
library("ggplot2")

#read in data
call.data <- read.csv("data/sfpd_dispatch_data_subset.csv", stringsAsFactors = FALSE) 

server <- function(input, output) {
  
  
  #outputs map of san fran and emergency type of the exact location where it occured
  output$map <- renderLeaflet({
    select <- call.data
    if(input$sourceInput != "All") {
      select <- filter(call.data, call.data$call_type == input$sourceInput)
    }
    colfunc <- colorRampPalette(c("springgreen", "navy"))
    pal <- colorFactor(palette = colfunc(17), domain = select$call_type)
    m = leaflet(select) %>% 
      addTiles() %>% 
      setView(-122.4194, 37.774, zoom=12) %>% 
      addCircleMarkers(lng = select$longitude, lat =select$latitude, popup = select$call_type, color = ~pal(select$call_type))
  })
  
  # outputs histogram of counts of type of unit dispatched and type of emergency
  output$plot <- renderPlot({
  
  call.data$call_type_group[call.data$call_type_group==""]<-"N/A"
    ggplot(call.data) +
      geom_bar(mapping = aes(x = call.data$unit_type, fill = call.data$call_type_group), position = "dodge") +
      labs(title = "Emergency and Unit Type",
           x = "Type of Unit Dispatched",
           y = "Count",
           fill = "Emergency Type") 
    
    
  })

}
