#ui.R

library(shiny)

nhdsx<-read.csv("./data/nhds_shiny.csv")

icd9list<-sort(as.vector(unique(nhdsx$LONG_DESCRIPTION)))

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("National Hospital Discharge Survey - Age by Sex"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectizeInput(
      'icd9name', label = NULL, choices = icd9list,
      options = list(create = TRUE)
    )
  ),
  
  mainPanel(
    plotOutput("agehist"),
    textOutput("mOut")
  )
))