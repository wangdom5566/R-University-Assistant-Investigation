# shiny
install.packages("shiny")
install.packages("tidyverse")
install.packages("ggplot2")
library(shiny)
library(ggplot2)

setwd("/Users/christinesfkao/R-University-Assistant-Investigation/student-workers/")
data = read.csv("data.csv")

ui = fluidPage(
  selectInput(inputId = "info",
              label = "資料變數",
              choices = c("請選擇欲查看的資料",
                          "totalrev" = "totalrev", 
                          "totalexp" = "totalexp", 
                          "totalworknum" = "totalworknum", 
                          "totalwhr" = "totalwhr")),
  
  selectInput(inputId = "region", 
              label = "學校所屬地區",
              choices = c("N" = "north", 
                          "C" = "central", 
                          "S" = "south", 
                          "E" = "east", 
                          "O" = "others"),
              multiple = TRUE),
  
  selectInput(inputId = "school",
              label = "公/私立學校",
              choices = c("public" = "公立", 
                          "private" = "private"),
              multiple = TRUE),
  
  selectInput(inputId = "grad",
              label = "學位別",
              choices = c("undergrad" = FALSE, 
                          "grad" = TRUE),
              multiple = TRUE),

  actionButton(inputId = "update",
               label = "計算並製圖"),
  
  plotOutput("graph"),
  plotOutput("summary"),
  plotOutput("avg"),
  plotOutput("sd")
)

server = function(input, output){
  
  run <- eventReactive(input$update, {data$input$info})
  
  output$graph = renderPlot({hist(run())})
  rv <- reactive({run[data$region == input$region &
                        data$school == input$school &
                        data$grad == input$grad]})
  
  output$graph = renderPlot({hist(rv())})
  output$summary = renderPrint({summary(rv())})
  output$avg = renderPrint({sum(rv())/length(rv())}) 
  output$sd = renderPrint({sd(rv())})
}

shinyApp(ui = ui, server = server)
