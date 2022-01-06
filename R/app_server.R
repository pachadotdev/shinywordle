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
  
  correct_letters <- reactive({
    vec <- l()
    for (i in seq_along(vec)) {
      if (lc()[i] != "green") {
        vec[i] <- "."
      }
    }
    paste(vec, collapse = "")
  })

  incorrect_letters <- reactive({ 
    vec <- l()
    for (i in seq_along(vec)) {
      if (lc()[i] != "gray") {
        vec[i] <- "."
      }
    }
    paste(vec, collapse = "")
  })

  wrong_spot <- reactive({
    vec <- l()
    for (i in seq_along(vec)) {
      if (lc()[i] != "yellow") {
        vec[i] <- "."
      }
    }
    vec
  })
  
  possible_words <- reactive({
    words <- grep(correct_letters(), shinywordle::words, value = T)
    subset_incorrect_or_wrong_spot(words, wrong_spot(), incorrect_letters())
  })
  
  output$correct_letters <- renderPrint({
    correct_letters()
  })
  
  output$incorrect_letters <- renderPrint({
    incorrect_letters()
  })
  
  output$wrong_spot <- renderPrint({
    wrong_spot()
  })
  
  output$possible_words <- renderText({
    paste(possible_words(), collapse = ", ")
  })
}
