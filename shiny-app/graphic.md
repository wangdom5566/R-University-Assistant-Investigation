library(ggplot2)
library(shiny)

##使用者介面端

ui2 <- shinyUI(fluidPage(
  titlePanel("Column Plot"),
  tabsetPanel(
    tabPanel("Upload File",
             titlePanel("Uploading Files"),
             sidebarLayout(
               sidebarPanel(
                 fileInput('file1', 'Choose CSV File',
                           accept=c('text/csv', 
                                    'text/comma-separated-values,text/plain', 
                                    '.csv')),
                 
                 # added interface for uploading data from
                 # http://shiny.rstudio.com/gallery/file-upload.html
                 tags$br(),
                 checkboxInput('header', 'Header', TRUE),
                 radioButtons('sep', 'Separator',
                              c(Comma=',',
                                Semicolon=';',
                                Tab='\t'),
                              ','),
                 radioButtons('quote', 'Quote',
                              c(None='',
                                'Double Quote'='"',
                                'Single Quote'="'"),
                              '"')
                 
               ),
               mainPanel(
                 tableOutput('contents')
               )
             )
    ),
    tabPanel("迴歸模型",
             pageWithSidebar(
               headerPanel('大學勞動調查迴歸模型'),
               sidebarPanel(
                 
                 # "Empty inputs" - they will be updated after the data is uploaded
                 selectInput('xcol', 'X Variable', ""),
                 selectInput('ycol', 'Y Variable', "", selected = ""),
                 selectInput('facet.row', 'Facet.Row',"",selected = ""),
                 selectInput('color', 'color',"",selected = "")
                 
               ),
               mainPanel(
                 plotOutput('MyPlot',height = "900px")
               )
             )
    )
    
  )
)
)

##server端
server2 <- shinyServer(function(input, output, session) {
  # added "session" because updateSelectInput requires it
  
  
  data <- reactive({ 
    req(input$file1) ## ?req #  require that the input is available
    
    inFile <- input$file1 
    
    # tested with a following dataset: write.csv(mtcars, "mtcars.csv")
    # and                              write.csv(iris, "iris.csv")
    df <- read.csv(inFile$datapath, header = input$header, sep = input$sep,
                   quote = input$quote)
    
    
    # Update inputs (you could create an observer with both updateSel...)
    # You can also constraint your choices. If you wanted select only numeric
    # variables you could set "choices = sapply(df, is.numeric)"
    # It depends on what do you want to do later on.
    df.name <-names(df)
    
    updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                      choices = names(df), selected = names(df))
    updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                      choices = names(df), selected = names(df)[2])  
    updateSelectInput(session, inputId = 'facet.row', label = 'Facet.row',
                      choices = names(df), selected = names(df)[3])
    updateSelectInput(session, inputId = 'color', label = 'color',
                      choices = names(df), selected = names(df)[3])
    
    return(df)
  })
  
  output$contents <- renderTable({
    data()
  })
  
  output$MyPlot <- renderPlot({
    # for a histogram: remove the second variable (it has to be numeric as well):
    # x    <- data()[, c(input$xcol, input$ycol)]
    # bins <- nrow(data())
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    # Correct way:
    # x    <- data()[, input$xcol]
    # bins <- nrow(data())
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
    
    # I Since you have two inputs I decided to make a scatterplot
    x <- data()[, c(input$xcol)]
    y <- data()[, c(input$ycol)]
    z <- data()[, c(input$facet.row)]
    u <- data()[, c(input$color)]
    x1 <-as.numeric(x)
    y1 <-as.numeric(y)
    z1 <-z  
    u1 <-u
    t1<-cbind(x1,y1,z1,u1)
    g1<-as.data.frame(t1)
    ggplot(g1,aes(x1, y1))+geom_point(aes(color = u))+
      geom_smooth(method = lm, fullrange = TRUE, color = "black")+facet_grid(z1~.,)+
      labs(x=input$xcol,y=input$ycol,facet.row=input$facet.row,color=input$color)+
      theme(axis.title.x = element_text(size = 15))+
      theme(axis.title.y = element_text(size = 15))+
      theme(axis.text = element_text(size = 15))+
      theme(legend.title=element_text(size=15))+ 
      theme(legend.text=element_text(size=15))
  })
})

shinyApp(ui2, server2)
