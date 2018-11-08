library(ggplot2)
library(shiny)
library(psych)


shinyServer(function(input, output, session) {
  
  
  data <- reactive({ 
    req(input$file1) 
    
    inFile <- input$file1 
    
    
    df <- read.csv(inFile$datapath, header = input$header, sep = input$sep,
                   quote = input$quote,encoding = "UTF-8")
    
    
    
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
  output$Summary <- renderPrint({
    x <- data()[, c(input$xcol)]
    y <- data()[, c(input$ycol)]
    z <- data()[, c(input$facet.row)]
    u <- data()[, c(input$color)]
    x1 <-as.numeric(x)
    y1 <-as.factor(y)
    z1 <-as.factor(z)  
    u1 <-as.factor(u)
    t1<-cbind(x1,y1,z1,u1)
    g1<-as.data.frame(t1)
    
    describeBy(g1$x1, list(y,z,u),mat=TRUE,digits=2)
    
  })   
  output$MyPlot1 <- renderPlot({ if(input$plot.type=="scatter") {
    
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
  }
    else if(input$plot.type=="boxplot"){
      
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
      ggplot(g1,
             aes_string(
               x 		= x1,
               y 		= y1,
               fill 	= u1
             )
      ) + geom_boxplot()+facet_grid(z1~.,)+
        labs(x="None",y=input$ycol,facet.row=input$facet.row,color=input$color,fill=input$color)+
        theme(axis.title.x = element_text(size = 15))+
        theme(axis.title.y = element_text(size = 15))+
        theme(axis.text = element_text(size = 15))+
        theme(legend.title=element_text(size=15))+ 
        theme(legend.text=element_text(size=15))
    } 
    
    
    
    else if(input$plot.type=="histogram"){
      
      x <- data()[, c(input$xcol)]
      y <- data()[, c(input$ycol)]
      z <- data()[, c(input$facet.row)]
      u <- data()[, c(input$color)]
      x1 <-as.numeric(x)
      y1 <-as.numeric(y)
      z1 <-as.numeric(z)  
      u1 <-as.numeric(u)
      t1<-cbind(x1,y1,z1,u1)
      g1<-as.data.frame(t1)
      
      ggplot(g1,aes(x = x1,fill=u))  + 
        geom_histogram(alpha=0.5,position="identity") +facet_grid(z1~.,)+
        labs(x=input$xcol,y="frequency",facet.row=input$facet.row,color=input$color,fill=input$color)+
        theme(axis.title.x = element_text(size = 15))+
        theme(axis.title.y = element_text(size = 15))+
        theme(axis.text = element_text(size = 15))+
        theme(legend.title=element_text(size=15))+ 
        theme(legend.text=element_text(size=15))
      
    } 
    
    else if(input$plot.type=="density"){
      
      x <- data()[, c(input$xcol)]
      y <- data()[, c(input$ycol)]
      z <- data()[, c(input$facet.row)]
      u <- data()[, c(input$color)]
      x1 <-as.numeric(x)
      y1 <-as.numeric(y)
      z1 <-as.factor(z)  
      u1 <-as.numeric(u)
      t1<-cbind(x1,y1,z1,u1)
      g1<-as.data.frame(t1)
      
      ggplot(g1,aes(x = x1,fill=u))  + 
        geom_density(position="identity", alpha=0.3) +facet_grid(z1~.,)+
        labs(x=input$xcol,y="Density",facet.row=input$facet.row,color=input$color,fill=input$color)+
        theme(axis.title.x = element_text(size = 15))+
        theme(axis.title.y = element_text(size = 15))+
        theme(axis.text = element_text(size = 15))+
        theme(legend.title=element_text(size=15))+ 
        theme(legend.text=element_text(size=15))
      
    } 
    
    
    else if(input$plot.type=="bar") {
      
      x <- data()[, c(input$xcol)]
      y <- data()[, c(input$ycol)]
      z <- data()[, c(input$facet.row)]
      u <- data()[, c(input$color)]
      x1 <-as.numeric(x)
      y1 <-as.numeric(y)
      z1 <-as.factor(z)  
      u1 <-as.factor(u)
      t1<-cbind(x1,y1,z1,u1)
      g1<-as.data.frame(t1)
      
      ggplot(g1, aes(x=x1, y=y1, fill=u)) +
        geom_bar(stat="identity") +facet_grid(z1~.,)+
        labs(x=input$xcol,y=input$ycol,facet.row=input$facet.row,color=input$color,fill=input$color)+
        theme(axis.title.x = element_text(size = 15))+
        theme(axis.title.y = element_text(size = 15))+
        theme(axis.text = element_text(size = 15))+
        theme(legend.title=element_text(size=15))+ 
        theme(legend.text=element_text(size=15))
      
    }
    
  })
  
})