
shinyUI(
  fluidPage(
    useShinyjs(),
    titlePanel("Assignment 1: Holly McClelland"),
    
    tabsetPanel(
      tabPanel("Mosaic",
               h3("Mosaic of Catagorical variables"),
              selectizeInput(inputId = "VariablesA", label = "Show variables:", 
                                         choices = choicesA, multiple = TRUE, selected = choicesA [c(1,2)]),
                          plotOutput(outputId = "Mosaic")
                 
               ),
              
      tabPanel("Data Set",
               tabsetPanel(
                 tabPanel("Summary",
                          verbatimTextOutput(outputId = "Summary")
                 ),
                 tabPanel("Data Table", 
                          
               DT::dataTableOutput(outputId = "Data_set")
               )
               )
      ),
      
      tabPanel("Ggpairs",
               selectizeInput(inputId = "VariablesD", label = "Show variables:", 
                              choices = choicesB, multiple = TRUE, selected = choicesB [c(1:8)]),
               plotOutput(outputId = "Pairsmaster")

              ),
            
        
      
      
        tabPanel("Corrgram",
                 h3("corrolaion plot"),
          plotOutput(outputId = "Corrgram1"),
          checkboxInput(inputId = "abs", label = "Uses absolute correlation", value = TRUE),
          selectizeInput(inputId = "VariablesB", label = "Show variables:", choices = choicesB, multiple = TRUE, selected = choicesB [c(1:8)]),
          selectInput(inputId = "CorrMeth", label = "Correlation method", choices = c("pearson","spearman","kendall"), selected = "pearson"),
          selectInput(inputId = "Group", label = "Grouping method", choices = list("none"=FALSE,"OLO"="OLO","GW"="GW","HC"="HC"), selected = "OLO"),
          
      ),
      
      tabPanel("Missing values",
        
        plotOutput(outputId = "Missing1"),
        plotOutput(outputId = "Missing2"),
        checkboxInput(inputId = "cluster", label = "Cluster missingness", value = FALSE),
        hr()
      ),
      
      tabPanel("Box Plot", 
               plotOutput(outputId = "Boxplot"),
               checkboxInput(inputId = "standardise", label = "Show standardized", value = TRUE),
               checkboxInput(inputId = "outliers", label = "Show outliers", value = TRUE),
               sliderInput(inputId = "range", label = "IQR Multiplier", min = 0, max = 3, step = 0.1, value = 1.5)
      ),
      tabPanel("Rising value", 
               selectizeInput(inputId = "VariablesC", label = "Show variables:",
                              choices = choicesB, multiple = TRUE, selected = choicesB [c(1:8)]),
               plotOutput(outputId = "risingvalue")
      )

)
)
)
