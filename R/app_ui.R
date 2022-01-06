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
      column(
        2,
        textInput(
          "l1",
          "1st letter:",
          value = "a"
        )
      ),
      
      column(
        2,
        textInput(
          "l2",
          "2nd letter:",
          value = "t"
        )
      ),
      
      column(
        2,
        textInput(
          "l3",
          "3rd letter:",
          value = "o"
        )
      ),
      
      column(
        2,
        textInput(
          "l4",
          "4th letter:",
          value = "n"
        )
      ),
      
      column(
        2,
        textInput(
          "l5",
          "5th letter:",
          value = "e"
        )
      ),
      
      column(12, br()),
      
      column(
        2,
        radioButtons(
          "l1c",
          "1st letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "l2c",
          "2nd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "l3c",
          "3rd letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "l4c",
          "4th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(
        2,
        radioButtons(
          "l5c",
          "5th letter color:",
          choices = c("gray", "green", "yellow"),
          selected = "gray"
        )
      ),
      
      column(12, br()),
      
      column(
        5,
        h2("Wordle result"),
        plotOutput("coloured_word")
      ),
      
      column(
        5,
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

