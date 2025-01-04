library(shiny)

# Define the server logic
server <- function(input, output) {
  # Reactive expression to fetch the selected dataset
  dataset <- reactive({
    if (input$dataset == "mtcars") {
      mtcars
    } else {
      iris
    }
  })
  
  # Reactive expression to filter the dataset based on the slider input
  filtered_data <- reactive({
    head(dataset(), input$rows)
  })
  
  # Output: Render the filtered dataset as a table
  output$data_table <- renderTable({
    filtered_data()
  })
  
  # Output: Render summary statistics for the filtered dataset
  output$data_summary <- renderPrint({
    summary(filtered_data())
  })
  
  # Output: Render a scatterplot
  output$scatter_plot <- renderPlot({
    data <- dataset()
    
    # Use the first two numeric columns for the scatterplot
    numeric_columns <- sapply(data, is.numeric)
    numeric_data <- data[, numeric_columns]
    
    if (ncol(numeric_data) >= 2) {
      plot(
        numeric_data[, 1],
        numeric_data[, 2],
        main = paste("Scatterplot of", colnames(numeric_data)[1], "vs", colnames(numeric_data)[2]),
        xlab = colnames(numeric_data)[1],
        ylab = colnames(numeric_data)[2],
        col = "blue",
        pch = 19
      )
    } else {
      plot(1, type = "n", xlab = "", ylab = "", main = "Not enough numeric data to plot.")
      text(1, 1, "No numeric data available for scatterplot.", cex = 1.5)
    }
  })
}
