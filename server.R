#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  ## When build button is clicked ####
  observeEvent(input$build,{
    #Get the selected predictors
    predictors_selected <- input$dpred
    #check if atleast one is selected
    if(length(predictors_selected)) {
      #Build the formula
      myformula <- paste(input$out,"~",paste(predictors_selected, collapse ="+"))
      #call the lm function
      mymodel <- lm(as.formula(myformula), data=d())
      
      #print the summary of the model
      output$summary <- renderPrint(summary(mymodel))
      #Generate and render actual vs predicted values
      actual_values <- d()[,input$out]
      predicted_values <- predict(mymodel)
      g <- ggplot(data = data.frame(Actual=actual_values,Predicted=predicted_values),
                  aes(x=Actual,y=Predicted)) + geom_point(color="blue") +
                  geom_smooth(method = "lm")
      output$myplot <- renderPlotly(g)
    }
    else {
      output$summary <- renderText("Select atleast one predictor")
      output$myplot <- renderPlot(geom_blank())
    }
  })
  
  #When a dataset is selected#
  d <- reactive({
    dset <- input$select
    if(dset == 'mtcars') {
      d <- mtcars
    }
    else if(dset == 'iris') {
      d <- iris
    }
  })
  
  #When a Output is selected###
  #Filter out the selected variable
  #and return other variables
  dpred <- reactive({
    d <- d()
    out_selected <- input$out
    selCols <- names(d)!=out_selected
    dpred <- names(d)[selCols]
    dpred
  })
  
  ## When dataset is changes ####
  #update the list outputs
  observeEvent(d(),{
    updateSelectInput(session,
                      "out",
                      choices = names(d()))
  })
  
  ## When dpred changes ###
  #populate the checkbox
  output$predictors <- renderUI({
    
      dpred <- dpred()
      
      checkboxGroupInput("dpred",
                         "Choose Predictors (to be included in the model):",
                         choices=dpred)
  })
  
})
