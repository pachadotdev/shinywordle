#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  l1 <- reactive({ input$l1 })
  l2 <- reactive({ input$l2 })
  l3 <- reactive({ input$l3 })
  l4 <- reactive({ input$l4 })
  l5 <- reactive({ input$l5 })
  
  l1c <- reactive({ input$l1c })
  l2c <- reactive({ input$l2c })
  l3c <- reactive({ input$l3c })
  l4c <- reactive({ input$l4c })
  l5c <- reactive({ input$l5c })
  
  l <- reactive({ tolower(c(l1(), l2(), l3(), l4(), l5())) })
  
  lc <- reactive({ c(l1c(), l2c(), l3c(), l4c(), l5c()) })
  
  lc_hex <- reactive({ 
    vec <- gsub("gray", "#787b7d", lc()) 
    vec <- gsub("yellow", "#c2b359", vec)
    vec <- gsub("green", "#6ba864", vec)
    vec
  })

  output$coloured_word <- renderPlot(
    { coloured_word(l(), lc_hex()) }
  )

  excluded_letters <- reactive({ 
    vec <- l()[lc() == "gray"]
    paste(vec, collapse = "")
  })

  wrong_spot <- reactive({
    vec <- l()[lc() == "yellow"]
    c(vec, rep("", 5 - length(vec))) 
  })

  known_count <- reactive({
    vec <- l()[lc() == "green"]
    vec2 <- rle(vec)$lengths
    names(vec2) <- rle(vec)$values
    vec2
  })
  
  correct_letters <- reactive({
    vec <- l()
    for (i in seq_along(vec)) {
      if (lc()[i] != "green") {
        vec[i] <- "."
      }
    }
    paste(vec, collapse = "")
  })
  
  possible_words <- reactive({
    filter_words(shinywordle::words,
                 exact = correct_letters(),
                 excluded_letters = excluded_letters(),
                 wrong_spot = wrong_spot(),
                 known_count = known_count()
    )
  })
  
  output$excluded_letters <- renderPrint({
    excluded_letters()
  })
  
  output$wrong_spot <- renderPrint({
    wrong_spot()
  })
  
  output$known_count <- renderPrint({
    known_count()
  })
  
  output$correct_letters <- renderPrint({
    correct_letters()
  })
  
  output$possible_words <- renderTable({
    head(data.frame(word = possible_words()), 20)
  })
}
