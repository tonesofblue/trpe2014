library(shiny)

shinyUI(
    
    pageWithSidebar(
    
        headerPanel("Developing Data Products Course Project"),
        
        sidebarPanel(
            width = 2,
            
            selectInput("colorScheme", "Choose color scheme:",
                        c("White - Red" = 1,
                          "White - Green" = 2,
                          "White - Blue" = 3,
                          "ColorBrewer - Reds" = 4,
                          "ColorBrewer - RdPu" = 5,
                          "ColorBrewer - Purples" = 6,
                          "ColorBrewer - PuBu" = 7,
                          "ColorBrewer - OrRd" = 8,
                          "ColorBrewer - Oranges" = 9,
                          "ColorBrewer - Greens" = 10,
                          "ColorBrewer - BuPu" = 11,
                          "ColorBrewer - BuGn" = 12,
                          "ColorBrewer - Blues" = 13),
                        selectize = FALSE),
            
            radioButtons("candidate", "Select canditate:", 
                         c("Erdoğan" = "P1", "İhsanoğlu" = "P2", "Demirtaş" = "P3")),
            
            submitButton(text = "Apply")
        ),
        
        mainPanel(
            plotOutput('map',height = "600px"),
            
            tags$div(tags$h3("Documentation"),
                     tags$h4("About This Data Product"),
                     tags$p("Turkish Presidential Elections were held on 10 August 2014.
                             Three candidates ran for election. This data product intends to
                             show distribution of votes, in percent, across Turkey."),
                     tags$h4("How To Use This Data Product"),
                     tags$p("There is a side panel on the right of the page. Panel
                             contains several widgets. Using first widgets one can change
                             color scheme that is used to display the vote distribution.
                             Moreover, candidate whose vote distribution is shown can be
                             selected. Changes are submitted by Apply button to update
                             the map."))
        )
    )
)