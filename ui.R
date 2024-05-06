# Load libraries
library(shiny)
library(tidyverse)

# Application Layout
shinyUI(
  fluidPage(
    br(),
    # TASK 1: Application title
    titlePanel(title = "Trends and Demographics in Income"),
    p("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demogrphic information."
    ),
    
    # TASK 2: Add first fluidRow to select input for country
    fluidRow(
      # add select input 
      column(12, 
             wellPanel(selectInput(
               "country",
               label = "Select Country",
               choices = c(
                 "US" = "United-States", 
                 "Canada" = "Canada", 
                 "Mexico" = "Mexico", 
                 "Germany" = "Germany", 
                 "Phillippines" = "Phillippines"))
             ))
    ),
    
    # TASK 3: Add second fluidRow to control how to plot the continuous variables
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
               # add radio buttons for continuous variables
               radioButtons("continuous_variable", 
                            "Select Continuous Variable", 
                            c("Age" = "age", 
                              "Hours-Per-Week" = "hours_per_week")),   
               # add radio buttons for chart type              
               radioButtons("graph_type", 
                            "Select Graph Type", 
                            c("Histogram" = "histogram", 
                              "Boxplot" = "boxplot")   
                            
                            )
               )),
             column(9, plotOutput("p1"))  # add plot output
      ),
    
    # TASK 4: Add third fluidRow to control how to plot the categorical variables
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a categorical variable to view bar chart on the right. Use the check box to view a stacked bar chart to combine the income levels into one graph. "),
               # add radio buttons for categorical variables
               radioButtons("categorical_variable",
                            "Select Categorical Variable",
                            c("Education" = "education", 
                              "Work-Class" = "workclass", 
                              "Sex" = "sex")),    
               # add check box input for stacked bar chart option
              checkboxInput("is_stacked",
                            "Stacked Bars",
                            width = NULL)
               )
             ),
      # add plot output       
      column(9, plotOutput("p2"))  
             
      )
    ))
  
