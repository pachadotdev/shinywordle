#' Show words in colour
#' @export
coloured_word <- function (word, colours) {
  n <- length(word)
  colours <- matrix(colours, ncol = n, byrow = TRUE)
  old <- par(pty = "s", mar = c(0, 0, 0, 0))
  on.exit(par(old))
  size <- length(word)
  plot(c(0, size), c(0, -size/2), type = "n", xlab = "", ylab = "", 
       axes = FALSE)
  rect(col(colours) - 1, -row(colours) + 1, col(colours), 
       -row(colours), col = colours, border = NA)
  text(col(colours) - 0.5, -row(colours) + 0.5, toupper(word), cex = 2, col = "white")
}

#' Subset words from input
#' @importFrom magrittr %>%
#' @importFrom stringr str_subset
#' @export
subset_wrong_spot <- function(list_of_words, wrong_spot) {
  if (length(wrong_spot) > 0) {
    for (w in wrong_spot) {
      list_of_words <- grep(
        w,
        list_of_words,
        value = T
      )
    }
    
    wrong_spot <- paste0("[^", wrong_spot, "]")
    wrong_spot <- gsub("\\[\\^\\.\\]", ".", wrong_spot)
    wrong_spot <- paste(wrong_spot, collapse = "")
    
    list_of_words <- list_of_words %>%
      str_subset(wrong_spot)
  }
  
  list_of_words
}

subset_incorrect_letters <- function(list_of_words, incorrect_letters) {
  # list_of_words <- list_of_words %>% 
  #   str_subset(paste(incorrect_letters, collapse = "|"), negate = TRUE)
  
  list_of_words <- grep(paste(incorrect_letters, collapse = "|"), 
                        list_of_words, value = T, invert = T)
  
  list_of_words
}
