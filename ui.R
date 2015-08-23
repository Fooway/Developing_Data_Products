library(shiny)

#library(randomForest)
#library(party)



shinyUI(fluidPage(
  titlePanel(strong("Code Project of Developing Data Products on Coursera")),
  pageWithSidebar(
    headerPanel(strong("Iris Species Predictor")),  
    
    sidebarPanel(     
       
      h3(strong('User Input')),
      
      sliderInput("p",strong('Training dataset (%)'), min = 50, max = 90, value = 70, step = 1),
     
      sliderInput("id1",strong('Sepal.Length (cm)'), min = 4.3, max = 7.9, value = 5., step = 0.1),
     
      sliderInput("id2",strong('Sepal.Width (cm)'), min = 2, max = 4.4, value = 2.3, step = 0.1),     
     
      sliderInput("id3",strong('Petal.Length (cm)'), min = 1, max = 6.9, value =3.3, step = 0.1),     
     
      sliderInput("id4",strong('Petal.Width (cm)'), min = .1, max = 2.5, value = 1., step = 0.1)  ,    
    
      tags$hr(),     
      h5('Notes: The iris species predictor shiny web application predicts iris species (setosa, versicolor, or virginica) based on user query inputs of the percentage of training dataset, the lengths and widths of sepal and petal of iris. The prediction model was built using the Random Forest classifier method on a training dataset comprised of certain percentage (default is 70%) of the iris data in the R package. '),
     # tags$hr(),
      h5('In the User Input panel, you can slide the percentage of training dataset, the numbers for the lengths and widths (both in centimeters) of sepal and petal of iris. Then you can obtain the predicted species for your query inputs and the decision tree graph. The results will be changed with the input parameters. The percentage of training dataset also can impact the prediction results.')
     
      
    ),
    mainPanel(
      
      h3(strong('Prediction Output')),

      h4(strong('Species prediction based on the following decision tree:')),
      plotOutput('decisiontree'),
      h4(strong('Species prediction by Random Forest method:')),    
      verbatimTextOutput("irisSpeciesPredictor")       
      
      
    )
  )
))


