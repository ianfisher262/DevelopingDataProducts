#server.r

nhdsx<-read.csv("./data/nhds_shiny.csv")

library(shiny)
library(ggplot2)
library(plyr)


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  nhdsy <- reactive({
    nhdsx[which(nhdsx$LONG_DESCRIPTION==input$icd9name),]
  })
  
  output$mOut <- renderText({
    m <- median(nhdsy()$age1)
    paste("The median patient age is: ", m)
  })
  
  #mage <- reactive({as.numeric(median(nhdsy[which(nhdsy$SEX=="Male"),3]))})
  #fage <- reactive({as.numeric(median(nhdsy[which(nhdsy$SEX=="Female"),3]))})
  
  #output$text1<-renderText({mage()})
  #output$text2<-renderText({fage()})
  
  output$agehist <- renderPlot( {
    
    p<-ggplot(nhdsy(), aes(age1,color=SEX)) + 
      theme_set(theme_gray(base_size=18)) +
      geom_histogram(breaks=seq(0, 100, by =5), 
                     aes(fill=SEX,color=SEX),alpha = 0.5) +
      ggtitle(paste0("Distribution of age by sex for inpatient discharge that include diagnosis of\n",
                     input$icd9name)) + 
      ylab("Frequency") +
      xlab("Age of patient at discharge")
    
    print(p)
  })
  
})

