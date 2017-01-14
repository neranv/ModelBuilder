#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Interactive Linear Model Builder"),
  p("This is an interactive linear model builder which helps one to see the 
    effects of different predictors on the ouput. Two sample datasets are used - mtcars, iris. It is straight forward to use. 
    First decide and choose a dataset. After choosing a dataset, select an output that you would like to predict and then select 
    the predictors that you would like to include in your model. Click on build model. Once you click on that you would see summary 
    and a plot. The plot shows acutal vs predicted values."),
  p("Some things to note"),
  p("1. The variable selected as ouput wont show up in the predictors list."),
  p("2. Model is built using the lm() function."),
  p("3. Predicted values are obtained using the predict() function"),
  p("4. Source code is at"),
  a("https://github.com/neranv/ModelBuilder"),
  hr(),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "select", 
                  label = "Select Dataset:" , 
                  choices = c("mtcars","iris") ),
      selectInput(inputId="out", 
                      label ="Select Output (to be predicted):",
                      choices = names(mtcars)),
      uiOutput('predictors'),
      actionButton('build',"Build")
     
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        column(12,verbatimTextOutput("summary"))
      ),
      fluidRow(
        column(12,plotlyOutput("myplot"))
      )
    )
  )
))
