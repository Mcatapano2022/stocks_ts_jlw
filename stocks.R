library(fpp3)

# Read data
stocks <- read.csv("nyse_stocks.csv")

#Convert to tsibble()
stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol)

# Plotting 1 stock
selected_stock <- "AAPL"

stocks %>%
  filter(symbol == selected_stock) %>%
  autoplot(volume) +
  labs(title = selected_stock)

# Plotting multiple stocks
selected_stocks <- c("GOOG", "AAPL")

stocks %>%
  filter(symbol %in% selected_stocks) %>%
  autoplot(volume)

#Add dates min and max

server <- function(input,output){
  output$ts_plot <- renderPlot({
    first.date <- input$selected_date_range[1]
    second.date <- input$selected_date_range[2]
    
    plot.selctdate <- stocks[stocks$symbol == input$selected_stock,]
    
    plot.selctdate <- plot.selctdate[plot.selctdate$date >= min_date,]
    plot.selctdate <- plot.selctdatef[plot.selctdate$date <= max_date,]
    
    autoplot(plot.selctdate, .vars = close)
  })
  
}
