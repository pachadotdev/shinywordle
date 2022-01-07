#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # word 1 ----
  
  w1 <- reactive({ input$w1 })
  l11 <- reactive({ substr(w1(), 1, 1) })
  l12 <- reactive({ substr(w1(), 2, 2) })
  l13 <- reactive({ substr(w1(), 3, 3) })
  l14 <- reactive({ substr(w1(), 4, 4) })
  l15 <- reactive({ substr(w1(), 5, 5) })
  
  lc11 <- reactive({ input$lc11 })
  lc12 <- reactive({ input$lc12 })
  lc13 <- reactive({ input$lc13 })
  lc14 <- reactive({ input$lc14 })
  lc15 <- reactive({ input$lc15 })
  
  l1 <- reactive({ tolower(c(l11(), l12(), l13(), l14(), l15())) })
  
  lc1 <- reactive({ c(lc11(), lc12(), lc13(), lc14(), lc15()) })
  
  lc1_hex <- reactive({ 
    vec <- gsub("gray", "#787b7d", lc1()) 
    vec <- gsub("yellow", "#c2b359", vec)
    vec <- gsub("green", "#6ba864", vec)
    vec
  })
  
  # word 2 ----
  
  w2 <- reactive({ input$w2 })
  l21 <- reactive({ substr(w2(), 1, 1) })
  l22 <- reactive({ substr(w2(), 2, 2) })
  l23 <- reactive({ substr(w2(), 3, 3) })
  l24 <- reactive({ substr(w2(), 4, 4) })
  l25 <- reactive({ substr(w2(), 5, 5) })
  
  lc21 <- reactive({ input$lc21 })
  lc22 <- reactive({ input$lc22 })
  lc23 <- reactive({ input$lc23 })
  lc24 <- reactive({ input$lc24 })
  lc25 <- reactive({ input$lc25 })
  
  l2 <- reactive({ tolower(c(l21(), l22(), l23(), l24(), l25())) })
  
  lc2 <- reactive({ c(lc21(), lc22(), lc23(), lc24(), lc25()) })
  
  lc2_hex <- reactive({ 
    vec <- gsub("gray", "#787b7d", lc2()) 
    vec <- gsub("yellow", "#c2b359", vec)
    vec <- gsub("green", "#6ba864", vec)
    vec
  })
  
  # word 3 ----
  
  w3 <- reactive({ input$w3 })
  l31 <- reactive({ substr(w3(), 1, 1) })
  l32 <- reactive({ substr(w3(), 2, 2) })
  l33 <- reactive({ substr(w3(), 3, 3) })
  l34 <- reactive({ substr(w3(), 4, 4) })
  l35 <- reactive({ substr(w3(), 5, 5) })
  
  lc31 <- reactive({ input$lc31 })
  lc32 <- reactive({ input$lc32 })
  lc33 <- reactive({ input$lc33 })
  lc34 <- reactive({ input$lc34 })
  lc35 <- reactive({ input$lc35 })
  
  l3 <- reactive({ tolower(c(l31(), l32(), l33(), l34(), l35())) })
  
  lc3 <- reactive({ c(lc31(), lc32(), lc33(), lc34(), lc35()) })
  
  lc3_hex <- reactive({ 
    vec <- gsub("gray", "#787b7d", lc3()) 
    vec <- gsub("yellow", "#c2b359", vec)
    vec <- gsub("green", "#6ba864", vec)
    vec
  })
  
  # word 4 ----
  
  w4 <- reactive({ input$w4 })
  l41 <- reactive({ substr(w4(), 1, 1) })
  l42 <- reactive({ substr(w4(), 2, 2) })
  l43 <- reactive({ substr(w4(), 3, 3) })
  l44 <- reactive({ substr(w4(), 4, 4) })
  l45 <- reactive({ substr(w4(), 5, 5) })
  
  lc41 <- reactive({ input$lc41 })
  lc42 <- reactive({ input$lc42 })
  lc43 <- reactive({ input$lc43 })
  lc44 <- reactive({ input$lc44 })
  lc45 <- reactive({ input$lc45 })
  
  l4 <- reactive({ tolower(c(l41(), l42(), l43(), l44(), l45())) })
  
  lc4 <- reactive({ c(lc41(), lc42(), lc43(), lc44(), lc45()) })
  
  lc4_hex <- reactive({ 
    vec <- gsub("gray", "#787b7d", lc4()) 
    vec <- gsub("yellow", "#c2b359", vec)
    vec <- gsub("green", "#6ba864", vec)
    vec
  })
  
  # results ----
  
  output$coloured_word <- renderPlot({
    ln <- if (nchar(w4()) > 0) {
        l4()
      } else {
        if (nchar(w3()) > 0) { 
          l3() 
        } else {
          if (nchar(w2()) > 0) {
            l2()
          } else {
            l1()
          }
        }
      }
    
    lcn_hex <- if (nchar(w4()) > 0) {
        lc4_hex()
      } else {
        if (nchar(w3()) > 0) { 
          lc3_hex() 
        } else {
          if (nchar(w2()) > 0) {
            lc2_hex()
          } else {
            lc1_hex()
          }
        }
      }
    
    coloured_word(ln, lcn_hex) 
  })
  
  correct_letters <- reactive({
    vec <- if (nchar(w4()) > 0) {
      l4()
    } else {
      if (nchar(w3()) > 0) { 
        l3()
      } else {
        if (nchar(w2()) > 0) {
          l2()
        } else {
          l1()
        }
      }
    }
    
    vec_col <- if (nchar(w4()) > 0) {
      lc4()
    } else {
      if (nchar(w3()) > 0) { 
        lc3()
      } else {
        if (nchar(w2()) > 0) {
          lc2()
        } else {
          lc1()
        }
      }
    }
    
    for (i in seq_along(vec)) {
      if (vec_col[i] != "green") {
        vec[i] <- "."
      }
    }
    
    paste(vec, collapse = "")
  })

  incorrect_letters <- reactive({ 
    vec <- if (nchar(w4()) > 0) {
      c(l4(), l3(), l2(), l1())
    } else {
      if (nchar(w3()) > 0) { 
        c(l3(), l2(), l1())
      } else {
        if (nchar(w2()) > 0) {
          c(l2(), l1())
        } else {
          l1()
        }
      }
    }
    
    vec_col <- if (nchar(w4()) > 0) {
      c(lc4(), lc3(), lc2(), lc1())
    } else {
      if (nchar(w3()) > 0) { 
        c(lc3(), lc2(), lc1())
      } else {
        if (nchar(w2()) > 0) {
          c(lc2(), lc1())
        } else {
          lc1()
        }
      }
    }
    
    for (i in seq_along(vec)) {
      if (vec_col[i] != "gray") {
        vec[i] <- "."
      }
    }
    
    unique(vec[vec != "."])
  })

  wrong_spot_1 <- reactive({
    vec <- l1()
    vec_col <- lc1()
    
    for (i in seq_along(vec)) {
      if (vec_col[i] != "yellow") {
        vec[i] <- "."
      }
    }
    
    vec
  })
  
  wrong_spot_2 <- reactive({
    vec <- if (nchar(w2()) > 0) {
          l2()
        } else {
          l1()
        }
    
    vec_col <- if (nchar(w2()) > 0) {
          lc2()
        } else {
          lc1()
        }
    
    for (i in seq_along(vec)) {
      if (vec_col[i] != "yellow") {
        vec[i] <- "."
      }
    }
    
    vec
  })
  
  wrong_spot_3 <- reactive({
    vec <- if (nchar(w3()) > 0) { 
        l3()
      } else {
        if (nchar(w2()) > 0) {
          l2()
        } else {
          l1()
        }
      }
    
    vec_col <- if (nchar(w3()) > 0) { 
        lc3()
      } else {
        if (nchar(w2()) > 0) {
          lc2()
        } else {
          lc1()
        }
      }
    
    for (i in seq_along(vec)) {
      if (vec_col[i] != "yellow") {
        vec[i] <- "."
      }
    }
    
    vec
  })
  
  wrong_spot_4 <- reactive({
    vec <- if (nchar(w4()) > 0) {
      l4()
    } else {
      if (nchar(w3()) > 0) { 
        l3()
      } else {
        if (nchar(w2()) > 0) {
          l2()
        } else {
          l1()
        }
      }
    }
    
    vec_col <- if (nchar(w4()) > 0) {
      lc4()
    } else {
      if (nchar(w3()) > 0) { 
        lc3()
      } else {
        if (nchar(w2()) > 0) {
          lc2()
        } else {
          lc1()
        }
      }
    }
    
    for (i in seq_along(vec)) {
      if (vec_col[i] != "yellow") {
        vec[i] <- "."
      }
    }
    
    vec
  })  

  possible_words <- reactive({
    words <- grep(correct_letters(), shinywordle::words, value = T)
    words <- subset_wrong_spot(words, wrong_spot_1())
    words <- subset_wrong_spot(words, wrong_spot_2())
    words <- subset_wrong_spot(words, wrong_spot_3())
    words <- subset_wrong_spot(words, wrong_spot_4())
    words <- subset_incorrect_letters(words, 
      incorrect_letters()[!incorrect_letters() %in% 
                            c(wrong_spot_4(),
                              wrong_spot_3(),
                              wrong_spot_2(),
                              wrong_spot_1())])
    words
  })
  
  output$correct_letters <- renderPrint({
    correct_letters()
  })
  
  output$incorrect_letters <- renderPrint({
    incorrect_letters()
  })
  
  output$wrong_spot <- renderPrint({
    wrong_spot_4()
  })
  
  output$possible_words <- renderText({
    paste(possible_words(), collapse = ", ")
  })
}
