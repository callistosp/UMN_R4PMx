# Shiny template for single file applications.

# Note: Run the application by clicking the 'Run App' button above.

# Load the package
library(shiny) 

# User interface
ui <- fluidPage() 

# A function to build the UI
server <- function(input, output){} 

# Combine the UI and server function to create the Shiny app.
shinyApp(ui = ui, server = server)