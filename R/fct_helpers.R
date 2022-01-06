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
subset_incorrect_or_wrong_spot <- function(wrong_spot, incorrect_letters) {
  letters2 <- paste0("[^", wrong_spot, "]")
  letters2 <- gsub("\\[\\^\\.\\]", ".", letters2)
  letters2 <- paste(letters2, collapse = "")
  
  # words5 %>%
  #   # "irate" 🟨🟨⬛🟨🟨
  #   str_subset("[^i][^r].[^t][^e]") %>%
  #   str_subset("a", negate = TRUE) %>%
  #   str_subset("i") %>%
  #   str_subset("r") %>%
  #   str_subset("t") %>%
  #   str_subset("e") %>%
  #   # "merit" ⬛🟨🟨🟨🟨
  #   str_subset("m", negate = TRUE) %>%
  #   str_subset(".[^e][^r][^i][^t]")
  
  words <- shinywordle::words %>%
    str_subset(letters2)
  
  words <- words %>% 
    str_subset(paste(incorrect_letters, collapse = "|"), negate = TRUE)
  
  words <- words %>% 
    str_subset(paste(wrong_spot, collapse = "|"))
}
