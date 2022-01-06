words <- tolower(readLines("/usr/share/dict/words"))
words <- stringr::str_replace_all(words, "[[:punct:]]", "")
words <- words[nchar(words) == 5]
use_data(words, overwrite = T)
