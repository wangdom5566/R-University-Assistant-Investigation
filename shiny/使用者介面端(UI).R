library(shiny)

shinyUI(fluidPage(
  titlePanel("大學跨校勞動調查"),
  tabsetPanel(
    tabPanel("上傳檔案",
             titlePanel("上傳檔案"),
             sidebarLayout(
               sidebarPanel(
                 fileInput('file1', 'Choose CSV File',
                           accept=c('text/csv', 
                                    'text/comma-separated-values,text/plain', 
                                    '.csv')),
                 
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
    tabPanel("統計繪圖",   
             pageWithSidebar(
               headerPanel('UniversitiesAssistantsInvestigation'),
               sidebarPanel(
                 
                 selectInput('xcol', 'X Variable', ""),
                 selectInput('ycol', 'Y Variable', "", selected = ""),
                 selectInput('facet.row', 'Facet.Row',"",selected = ""),
                 selectInput('color', 'color',"",selected = ""),
                 selectInput("plot.type","Plot Type:",
                             list(boxplot = "boxplot", histogram = "histogram", 
                                  density = "density", bar = "bar",scatter="scatter"))
                 
               ),
               mainPanel(
                 plotOutput('MyPlot1',height = "900px")
               )
               )
    ),tabPanel("描述統計",
                 verbatimTextOutput("summary")
  ))))
