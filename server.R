library(shiny)
library(rgdal)
library(RColorBrewer)

colorSchemes <-  list(c("White", "Red"),
                      c("White", "Green"),
                      c("White", "Blue"),
                      brewer.pal(4, "Reds"),
                      brewer.pal(4, "RdPu"),
                      brewer.pal(4, "Purples"),
                      brewer.pal(4, "PuBu"),
                      brewer.pal(4, "OrRd"),
                      brewer.pal(4, "Oranges"),
                      brewer.pal(4, "Greens"),
                      brewer.pal(4, "BuPu"),
                      brewer.pal(4, "BuGn"),
                      brewer.pal(4, "Blues"))

layer <-  readOGR("./layer", "trpe2014")

titles <- list("P1" = "Turkish Presidential Election, 2014\nDistribution of Votes of Erdoğan", 
               "P2" = "Turkish Presidential Election, 2014\nDistribution of Votes of İhsanoğlu",
               "P3" = "Turkish Presidential Election, 2014\nDistribution of Votes of Demirtaş")

scaleRect <- function(x1, y1, x2, y2, n, ramp) {
    d <- 1 / n
    u <- d * 0:n
    s <- d * (x2 - x1)
    
    x <- x1 + u * (x2 - x1)
    
    rect(x - s / 2, y1, x + s / 2, y2, col = rgb(ramp(u), max = 255), border = NA, xpd = TRUE)
    
    tu <- c(0, 0.25, 0.5, 0.75, 1)
    tx <- x1 + tu * (x2 - x1)
    t <- c("0", "25%", "50%", "75%","100%")
    
    text(tx, y1 + 0.5 * (y2 - y1), t, xpd = TRUE)
}

shinyServer(
    function(input, output) {
        output$diag <- renderPrint({input$colorScheme})
        
        output$map <- renderPlot({
            ramp <- colorRamp(colorSchemes[[as.numeric(input$colorScheme)]])
            colorData <- layer@data[[input$candidate]]
            plot(layer,   border="gray", col = rgb(ramp(colorData), max = 255))
            title(main = titles[[input$candidate]])
            box <- par("usr")
            scaleRect(box[1],box[3], box[1] + 0.2 * (box[2] - box[1]), box[3] + 0.05 * (box[4] - box[3]), 50, ramp)
        })
    }
)