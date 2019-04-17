library(shiny)
library(ggplot2)
library(reshape2)



ui <- fluidPage(
  
  verticalLayout(
    
    titlePanel("Saving-Investing Modalities"),
    
    fluidRow(
      column(4, 
             sliderInput(inputId = "amount",
                         label = "Initial Amount",
                         min = 0,
                         max = 100000,
                         value = 1000, 
                         step = 500)
      ), 
      column(4, 
             sliderInput(inputId = "rate",
                         label = "Return Rate (in %)",
                         min = 0,
                         max = 20,
                         value = 5, 
                         step = 0.1)
      ), 
      column(4, 
             sliderInput(inputId = "years",
                         label = "Years",
                         min = 0,
                         max = 50,
                         value = 20, 
                         step = 1)
      )
    ),
    
    fluidRow(
      column(4, 
             sliderInput(inputId = "contrib",
                         label = "Annual Contribution",
                         min = 0,
                         max = 50000,
                         value = 2000, 
                         step = 500)
      ), 
      column(4, 
             sliderInput(inputId = "growth",
                         label = "Growth Rate (in %)",
                         min = 0,
                         max = 20,
                         value = 2, 
                         step = 0.1)
      ), 
      column(4, 
             selectInput(inputId = "facet",
                         label = "Facet?",
                         choices = c("No", "Yes"))
      )
    ),
    
    h4("Timelines"),
    plotOutput(outputId = "timelines"), 
    
    h4("Balances"),
    verbatimTextOutput(outputId = "balances")
    
  )
  
)



server <- function(input, output) {
  
  dataInput <- reactive({
    
    future_value <- function(amount, rate, years) {
      return(amount * (1 + rate) ^ years)
    }
    
    growing_annuity <- function(contrib, rate, growth, years) {
      return(contrib * ((1 + rate) ^ years - (1 + growth) ^ years) / (rate - growth))
    }
    
    no_contrib <- rep(0, input$years+1)
    fixed_contrib <- rep(0, input$years+1)
    growing_contrib <- rep(0, input$years+1)
    for(i in 0:input$years) {
      no_contrib[i+1] <- future_value(amount = input$amount, rate = 0.01*input$rate, years = i)
      fixed_contrib[i+1] <- future_value(amount = input$amount, rate = 0.01*input$rate, years = i) + 
        growing_annuity(contrib = input$contrib, rate = 0.01*input$rate, growth = 0, years = i)
      growing_contrib[i+1] <- future_value(amount = input$amount, rate = 0.01*input$rate, years = i) + 
        growing_annuity(contrib = input$contrib, rate = 0.01*input$rate, growth = 0.01*input$growth, years = i)
    }
    
    year <- 0:input$years
    modalities <- cbind.data.frame(year, no_contrib, fixed_contrib, growing_contrib)
    
    return(modalities)
    
  })
  
  
  output$timelines <- renderPlot({
    
    modalities <- dataInput()
    modalities_graph <- melt(modalities, id = "year")
    names(modalities_graph) <- c("year", "modality", "balance")
    
    if (input$facet == "No") {
      ggplot(modalities_graph, aes(x = year, y = balance, color = modality)) + 
        geom_line(size = 1) + 
        geom_point() + 
        ggtitle("Three Modes of Investing") + 
        xlab("year") + 
        ylab("balance") + 
        theme_minimal()
    } else {
      ggplot(modalities_graph, aes(x = year, y = balance, color = modality, fill = modality)) + 
        geom_area(alpha=0.4) + 
        geom_point() + 
        ggtitle("Three Modes of Investing") + 
        xlab("year") + 
        ylab("balance")+ 
        facet_grid(. ~ modality) + 
        theme_bw()
    }
    
  })
  
  
  output$balances <- renderPrint({
    
    dataInput()
    
  })
  
}



shinyApp(ui = ui, server = server)


