library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Interactive Data Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      # Input: Dropdown menu for selecting a dataset
      selectInput(
        inputId = "dataset",
        label = "Choose a dataset:",
        choices = c("mtcars", "iris"),
        selected = "mtcars"
      ),
      
      # Input: Slider for selecting the number of rows to display
      sliderInput(
        inputId = "rows",
        label = "Number of rows to display:",
        min = 5,
        max = 20,
        value = 10
      ),
      
      # Input: Checkbox to toggle summary statistics
      checkboxInput(
        inputId = "show_summary",
        label = "Show Summary Statistics",
        value = TRUE
      )
    ),
    
    mainPanel(
      # Output: Display the filtered dataset as a table
      h3("Dataset Preview"),
      tableOutput("data_table"),
      
      # Output: Display summary statistics
      h3("Summary Statistics"),
      conditionalPanel(
        condition = "input.show_summary == true",
        verbatimTextOutput("data_summary")
      ),
      
      # Output: Scatterplot
      h3("Scatterplot"),
      plotOutput("scatter_plot")
    )
  )
)
