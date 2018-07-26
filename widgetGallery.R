library(shiny)

ui <- fluidPage(
  
  titlePanel("Widget Gallery"),
  
  fluidRow(

    column(6,
           wellPanel(
             h3("Select input"),
             selectInput(inputId = "select", 
                         label = "Selection",
                         choices = c("Duck, Duck, Goose", "Duck, Duck, Grey duck", "What the Duck?"),
                         selected = "Duck, Duck, Goose"),
             p("Current Value:"),
              verbatimTextOutput("selectOut")
           )),
    
    
    column(3,
           wellPanel(
             h3("Single checkbox"),
             checkboxInput("checkbox", label = "Choice A", 
                           value = TRUE),
             
             p("Current Value:"), 
             verbatimTextOutput("checkboxOut")
           )),
    
    column(3,
           wellPanel(
             checkboxGroupInput("checkGroup", 
                                label = h3("Checkbox group"), 
                                choices = list("Choice 1" = 1, "Choice 2" = 2, 
                                               "Choice 3" = 3),
                                selected = 1),
             
             p("Current Values:"), 
             verbatimTextOutput("checkGroupOut")
           ))
  ),
  
  fluidRow(
    
    column(4,
           wellPanel(
             dateInput("date", label = h3("Date input"), value = "2014-01-01"),  
             
             p("Current Value:"), 
             verbatimTextOutput("dateOut")
           )),
    
    column(4,
           wellPanel(
             dateRangeInput("dates", label = h3("Date range")),
             
             p("Current Values:"), 
             verbatimTextOutput("datesOut")
           )),
    
    column(4,
           wellPanel(
             fileInput("file", label = h3("File input")),
             
             p("Current Value:"), 
             verbatimTextOutput("fileOut")
           ))
  ),
  
  fluidRow(
    
    column(4,
           wellPanel(
             numericInput("num", label = h3("Numeric input"), value = 1),
             
             p("Current Value:"), 
             verbatimTextOutput("numOut")
           )),
    
    column(4,
           wellPanel(
             radioButtons("radio", label = h3("Radio buttons"),
                          choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                          selected = 1),
             
             p("Current Values:"), 
             verbatimTextOutput("radioOut")
           )),
    
    column(4,
           wellPanel(
             h3("Action button"),
             actionButton("action", label = "Action"),

             p("Current Value:"),
             verbatimTextOutput("actionOut")
           ))
  ),
  
  fluidRow(
    
    column(4,
           wellPanel(
             sliderInput("slider1", label = h3("Slider"), min = 0, max = 100, 
                         value = 50),
             
             p("Current Value:"), 
             verbatimTextOutput("slider1Out")
           )),
    
    column(4,
           wellPanel(
             sliderInput("slider2", label = h3("Slider range"), min = 0, 
                         max = 100, value = c(25, 75)),
             
             p("Current Values:"), 
             verbatimTextOutput("slider2Out")
           )),
    
    column(4,
           wellPanel(
             textInput("text", label = h3("Text input"), 
                       value = "Enter text..."),
             
             p("Current Value:"), 
             verbatimTextOutput("textOut")
           )) 
  )
  
)

server <- function(input, output) {
  
  output$selectOut <- renderPrint({ input$select})
  output$checkboxOut <- renderPrint({ input$checkbox })
  output$checkGroupOut <- renderPrint({ input$checkGroup })
  output$dateOut <- renderPrint({ input$date })
  output$datesOut <- renderPrint({ input$dates })
  output$fileOut <- renderPrint({ input$file })
  output$numOut <- renderPrint({ input$num })
  output$radioOut <- renderPrint({ input$radio })
  output$actionOut <- renderPrint({ input$action })
  output$slider1Out <- renderPrint({ input$slider1 })
  output$slider2Out <- renderPrint({ input$slider2 })
  output$textOut <- renderPrint({ input$text })
  
}

shinyApp(ui = ui, server = server)

# Adapted from https://github.com/rstudio/shiny-examples/tree/master/081-widgets-gallery
