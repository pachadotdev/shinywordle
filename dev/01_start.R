# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
## 
## /!\ Note: if you want to change the name of your app during development, 
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
## 
golem::fill_desc(
  pkg_name = "shinywordle", # The Name of the package containing the App 
  pkg_title = "Solving a Wordle with assistance from R", # The Title of the package containing the App 
  pkg_description = "Wordle is a free word-guessing game available online: guess the five-letter word in six tries or fewer. This introduces functions for finding strong and weak matches for characters in a word to solve the game.", # The Description of the package containing the App 
  author_first_name = "Mauricio", # Your First Name
  author_last_name = "Vargas", # Your Last Name
  author_email = "mv.sepulveda@mail.utoronto.ca", # Your Email
  repo_url = "https://github.com/pachadotdev/shinywordle" # The URL of the GitHub Repo (optional) 
)

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_apache_license()
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct("M Vargas")
usethis::use_lifecycle_badge( "Experimental" )
usethis::use_news_md( open = FALSE )

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Use Recommended Packages ----
golem::use_recommended_deps()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon() # path = "path/to/ico". Can be an online file. 
golem::remove_favicon()

## Add helper functions ----
golem::use_utils_ui()
golem::use_utils_server()

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )
