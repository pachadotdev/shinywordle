#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    fluidPage(
      h1("shinywordle"),
      
      # word 1 ----
      
      column(
        2,
        textInput(
          "w1",
          "First Word:",
          value = ""
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc11",
          "1st letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc12",
          "2nd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc13",
          "3rd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc14",
          "4th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc15",
          "5th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      # word 2 ----
      
      column(
        2,
        textInput(
          "w2",
          "Second Word:",
          value = ""
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc21",
          "1st letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc22",
          "2nd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc23",
          "3rd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc24",
          "4th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc25",
          "5th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      # word 3 ----
      
      column(
        2,
        textInput(
          "w3",
          "Third Word:",
          value = ""
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc31",
          "1st letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc32",
          "2nd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc33",
          "3rd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc34",
          "4th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc35",
          "5th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      # word 4 ----
      
      column(
        2,
        textInput(
          "w4",
          "Fourth Word:",
          value = ""
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc41",
          "1st letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc42",
          "2nd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc43",
          "3rd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc44",
          "4th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc45",
          "5th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      # word 5 ----
      
      column(
        2,
        textInput(
          "w5",
          "Fifth Word:",
          value = ""
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc51",
          "1st letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc52",
          "2nd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc53",
          "3rd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc54",
          "4th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "lc55",
          "5th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      # results ----
      
      column(
        6,
        h2("Wordle result"),
        plotOutput("coloured_word")
      ),
      
      column(
        6,
        h2("Possible words"),
        # verbatimTextOutput("correct_letters"),
        # verbatimTextOutput("incorrect_letters"),
        # verbatimTextOutput("wrong_spot"),
        textOutput("possible_words")
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'shinywordle'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

