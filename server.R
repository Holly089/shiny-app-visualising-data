shinyServer(function(input, output, session) {
  
  
  #######
  #mosaic plot
  #######
  
  output$catagirical <- DT::renderDataTable({
    DT::datatable(data = cat_data)
  })
  output$Mosaic <- renderPlot({
    formula <- as.formula(paste("~",paste(input$VariablesA, collapse = " + ")))
    vcd::mosaic(formula, data = cat_data,
           main = "Mosaic of catagorical variables", shade = TRUE, legend = TRUE)
  })

  output$Plot <- renderPlot({
    plot(cat_data)
  })
  
  output$SummaryA1 <- renderPrint({
    summary(cat_data)
  })
  
  output$SummaryA2 <- renderPrint({
    summary(as.data.frame(cat_data))
  })
  
  #######
  #data set
  ######
  
  output$Summary <- renderPrint({
    dfSummary(all_data)
  })
  
  output$Data_set <- DT::renderDataTable({
    DT::datatable(data = all_data)
  })
  
  ##########
  #pairs plot
  #######
  
  output$SummaryB2 <- renderPrint({
    summary(non_factor)
  })
  
  output$all_data_table <- DT::renderDataTable({
    DT::datatable(data = non_factor)
  })
  
  ###want to get this to have a drop down of varibales to plot
 output$Pairsmaster <- renderPlot({
  pairs_data = non_factor %>% select(input$VariablesD)
    GGally::ggpairs(data = pairs_data, title = "Pairs Plot of Data selected")
  })
  
  

  
  #######
  #corrolation plot
  ######
  
  output$airquality <- DT::renderDataTable({
    DT::datatable(data = airquality)
  })

    output$Corrgram1 <- renderPlot({
        data_use = non_factor %>% select(input$VariablesB)
        corrgram::corrgram( 
              data_use,
              order = input$Group, 
              abs = input$abs, 
              cor.method = input$CorrMeth,
              text.panel = panel.txt,
              main = "Correlation of data")
  })
    
  #########
  #missing value
  ########
    
    #first graph
    output$Missing1 <- renderPlot({
      
      vis_miss(all_data[1:(length(all_data)/2)], cluster = input$cluster) +
        labs(title = "Missingness of data")
    })
    #
    #2nd graph
    output$Missing2 <- renderPlot({
      
      vis_miss(all_data[(length(all_data)/2+1):(length(all_data))], cluster = input$cluster) +
        labs(title = "Missingness of data")
    })
  
    
    
    ########
    #box plot
    ########
    
    output$Boxplot <- renderPlot({
      data <- as.matrix(non_factor)
      data <- scale(data, center = input$standardise, scale = input$standardise)
      car::Boxplot(data, use.cols = TRUE, notch = FALSE, varwidth = FALSE,  
              horizontal = FALSE, outline = input$outliers, 
              col = brewer.pal(n = dim(non_factor)[2], name = "RdBu"),
              range = input$range, main = "Boxplots of data")
    })
    
    ######
    #rising value chart
    #####
    
    output$risingvalue <- renderPlot({
      
    continous_data = non_factor %>% select(input$VariablesC) 

    for (col in 1:ncol(continous_data)) {
      continous_data[,col] <- continous_data[order(continous_data[,col]),col] #sort each column in ascending order
    }
    continous_data <- scale(x = continous_data, center = TRUE, scale = TRUE)  # scale so they can be graphed with a shared Y axis
    mypalette <- rainbow(ncol(continous_data))
    matplot(x = seq(1, 100, length.out = nrow(continous_data)), y = continous_data, type = "l", xlab = "Percentile", ylab = "Values", lty = 1, lwd = 1, col = mypalette, main = "Rising value chart")
    legend(legend = colnames(continous_data), x = "topleft", y = "top", lty = 1, lwd = 1, col = mypalette, ncol = round(ncol(continous_data)^0.3))
    })
    
})

#runApp(appDir = ".", display.mode = "showcase")
