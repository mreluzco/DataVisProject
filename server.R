# Load libraries
library(shiny)
library(tidyverse)


adult <- read_csv("adult.csv")

names(adult) <- tolower(names(adult))


shinyServer(function(input, output) { 
  
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  
  # TASK 5: Create logic to plot histogram or boxplot
  output$p1 <- renderPlot({
    if (input$graph_type == "histogram") {
      # Histogram
      ggplot(df_country(), aes_string(x = input$continuous_variable)) +
        geom_histogram() +
        labs(
          y = "Number of People",
          title = paste("Trend of ", input$continuous_variable)
        ) + 
        facet_wrap(~prediction)
    }
    else {
      
      ggplot(df_country(), aes_string(y = input$continuous_variable)) +
        geom_boxplot() +
        coord_flip() +  
        labs(
          title = paste("Trend of", input$continuous_variable)
        ) + 
        facet_wrap(~prediction)
    }
    
  })
  
  # TASK 6: Create logic to plot faceted bar chart or stacked bar chart
  output$p2 <- renderPlot({
     
    p <- ggplot(df_country(), aes_string(x = input$categorical_variable)) +
      geom_bar() +  
      labs(
        title = paste("Trend of", input$categorical_variable)) +
     
      theme(
        axis.text.x = element_text(angle = 45),
        legend.position = "bottom"
      )
    
    if (input$is_stacked) {
      p + 
        geom_bar(position = "stack",
                 aes_string(fill = "prediction"))
      
    }
    else{
      p + 
        geom_bar(aes_string(
          fill = input$categorical_variable
        )) + 
        facet_wrap(~prediction)
    }
  })
})
