letter_freqs  <- strsplit('etaoinshrdlcumwfgypbvkjxqz', '')[[1]]
letter_scores <- setNames(1:26, letter_freqs)

#' Score letters
#' @export
score_letters <- function(letters) sum(letter_scores[tolower(letters)])

#' Filter words based upon "Wordle" game state
#'
#' @param words character vector of candidate words
#' @param exact single string representing known characters in the word, with
#'        '.' used to indicate the letter at this position is unknown.
#'        E.g. For a 5 letter word if the 3rd and 4th letters are known to be 'a' and 'c', but
#'        all other letters are unknown, then \code{exact = "..ac."}
#' @param excluded_letters string containing letters known to not be in the word
#' @param wrong_spot a character vector the same length as the number of letters 
#'        in the target word.  Each string in this vector represents all letters
#'        which are known to be part of the word, but in the wrong spot.
#'        E.g. if 'a' has been attempted as the first character, and it exists
#'        in the word, but worlde claims it is not yet in the correct position,
#'        then \code{wrong_spot = c('a', '', '', '', '')}
#' @param known_count name character vector giving letters and their known counts.
#'        E.g. This can be used if it is known definitively that there is only 
#'        one letter 'e' in the target word, in which case
#'        \code{known_count = c(e = 1)}
#' @export
filter_words <- function(words, exact = ".....", excluded_letters = "", wrong_spot = c('', '', '', '', ''), known_count = c()) {
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Build a regex to match the exact case, but exclude any words which 
  # contain excluded letters, or letters in the wrong spot
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  excluded_letters <- rep(excluded_letters, nchar(exact))
  
  stopifnot(length(wrong_spot) == nchar(exact))
  excluded_letters <- paste(excluded_letters, wrong_spot, sep = "")
  excluded_letters <- ifelse(nchar(excluded_letters) == 0, '.', paste0("[^", excluded_letters, "]"))
  
  regex <- strsplit(exact, '')[[1]]
  regex <- ifelse(regex == '.', excluded_letters, regex)
  regex <- paste(regex, collapse = "")
  regex <- paste0('^', regex, '$')
  
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Keep only words which match the exact case, and do not contain excluded
  # letters, or letters in the wrong spot
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  words <- grep(regex, words, value = TRUE, ignore.case = TRUE)
  
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Built a vector of all included letters regardless of whether they're in
  # the wrong spot or not.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  included_letters1 <- strsplit(exact, '')[[1]]
  included_letters2 <- unlist(strsplit(wrong_spot, ''))
  included_letters  <- c(included_letters1, included_letters2)
  included_letters  <- included_letters[included_letters != '.']
  included_letters  <- sort(unique(included_letters))
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Check that we have all included letters required
  # Do this by comparing the sorted letters within each word vs a sorted regex
  # e.g. to check for letters 'r' and 'e' in 'rebel'
  #  grepl('e.*r', 'beerl')
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if (length(included_letters) > 0) {
    
    sorted_included_letters <- paste(sort(included_letters), collapse = ".*")
    
    split_words <- strsplit(words, '')
    sorted_letters <- vapply(split_words, function(letters) {
      paste0(sort(letters), collapse = "")
    }, character(1))
    
    matching_included_letters <- which(grepl(sorted_included_letters, sorted_letters))
    words <- words[matching_included_letters]
  }
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # enforce a known count e.g. if it is known that there is only a single
  # 'e' then drop words like "rebel" from the list of candidate words
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  split_words <- strsplit(words, '')
  for (i in seq_along(known_count)) {
    letter <- names(known_count)[1]
    count  <- known_count[[1]]
    match_counts <- vapply(split_words, function(x) {
      sum(x == letter) == count
    }, logical(1))
    words <- words[match_counts]
  }
  
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Re-order words by their score. lowest first.
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  split_words <- strsplit(words, '')
  word_scores <- vapply(split_words, score_letters, numeric(1))
  words[order(word_scores)]
}

#' Show words in colour
#' @export
coloured_word <- function (word, colours) {
  n <- length(word)
  colours <- matrix(colours, ncol = n, byrow = TRUE)
  old <- par(pty = "s", mar = c(0, 0, 0, 0))
  on.exit(par(old))
  size <- length(word)
  plot(c(0, size), c(0, -size), type = "n", xlab = "", ylab = "", 
       axes = FALSE)
  rect(col(colours) - 1, -row(colours) + 1, col(colours), 
       -row(colours), col = colours, border = NA)
  text(col(colours) - 0.5, -row(colours) + 0.5, toupper(word), cex = 2, col = "white")
}


