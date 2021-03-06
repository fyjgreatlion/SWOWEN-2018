# Create a word list from spelling corrections, SUBTLEX and VARCON project
# Custom corrections are included as well as a custom list with proper nouns and acronyms
#
# Author: Simon De Deyne, simon2d@gmail.com
# Last changed: 13 June 2019

library('tidyverse')

# Word list with SUBTLEX (min freq = 2) and VARCON
varcon.file     = './data/dictionaries/SUBTLEXFreqMIN2VARCON.txt'

# Proper nouns, Acronyms
proper.file     = './data/dictionaries/EnglishProperNames.txt'

# Spelling corrections
spelling.file   = './data/dictionaries/EnglishCustomDict.txt'


# Output file that combines the various list of valid lexical entries
output.file     = './data/dictionaries/wordlist.txt'

X.varcon        = read.table(varcon.file, header = TRUE, sep=",", dec=".", quote = "\"",stringsAsFactors = FALSE,
                             encoding = 'UTF-8')
X.proper        = read.table(proper.file, header = FALSE, col.names = c('Word'), sep=",", dec=".", quote = "\"",
                             stringsAsFactors = FALSE, encoding = 'UTF-8')
X.spelling      = read.table(spelling.file, header = FALSE, col.names = c('Original','Correction'), sep="\t", dec=".",
                             quote = "\"",stringsAsFactors = FALSE, encoding = 'UTF-8')
X.spelling      = X.spelling %>% select(Correction) %>% rename(Word = Correction)
X               = bind_rows(X.varcon,X.proper,X.spelling) %>% distinct() %>% arrange(Word)

write.csv(X,output.file,fileEncoding = 'UTF-8',row.names = FALSE)

rm(varcon.file,proper.file,spelling.file,output.file,X.proper,X.spelling,X.varcon,X)