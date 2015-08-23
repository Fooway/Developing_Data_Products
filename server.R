library(shiny)

library(randomForest)
library(party)

library(lattice)
library(ggplot2)
library(caret)
 

suppressPackageStartupMessages(library(randomForest))
suppressPackageStartupMessages(library(party))
suppressPackageStartupMessages(library(caret))
suppressPackageStartupMessages(library(lattice))
suppressPackageStartupMessages(library(ggplot2))

data(iris)


shinyServer(
  
  function(input, output) {
    
    
    output$irisSpeciesPredictor<-renderText({
     
      results()
      
    })
    
    
    output$decisiontree <- renderPlot({ 
      
    
      models()
    
      
    })
    
    
    models<- reactive(
     {
        
        #obtain input parameters
        a0<- as.numeric(input$p) /100.0
        a1<-as.numeric(input$id1)
        a2<-as.numeric(input$id2)
        a3<-as.numeric(input$id3)
        a4<-as.numeric(input$id4)
        
        #obtain training dataset based on input percentage of training dataset
        inTrain <- createDataPartition(y=iris$Species, p = a0 , list=FALSE) 
        training <- iris[inTrain,]
        
        # training of random forest model
        modFit <- randomForest(Species ~ ., data = training)    

        #plot binary tree
        #cforest is An implementation of the random forest and bagging ensemble algorithms utilizing conditional inference trees        
        cf <- cforest(Species ~ ., data = training, controls=cforest_control(mtry=3, mincriterion=0))      
        pt <- party:::prettytree(cf@ensemble[[1]], names(cf@data@get("input"))) 
        nt <- new("BinaryTree") 
        nt@tree <- pt 
        nt@data <- cf@data 
        nt@responses <- cf@responses          
        #plot new decision tree
        plot(nt)  
        
        
      
    })
    
    results <- reactive({
      
      #obtain input parameters
      a0<-as.numeric(input$p) /100.0
      a1<-as.numeric(input$id1)
      a2<-as.numeric(input$id2)
      a3<-as.numeric(input$id3)
      a4<-as.numeric(input$id4)
      
      #obtain training dataset based on input percentage of training dataset
      inTrain <- createDataPartition(y=iris$Species, p = a0 , list=FALSE) 
      training <- iris[inTrain,]
      
      # training of random forest model
      modFit <- randomForest(Species ~ ., data = training)  
      
       
      # input parameters
      userInput <-data.frame(a1,a2,a3,a4)
      names(userInput)<-c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")
      
      # predict species
      res <- levels(iris$Species)[predict(modFit,newdata=userInput)]
      
      res
    })
    
    
  }
)



