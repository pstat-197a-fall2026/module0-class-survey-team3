# a number
4.5
# check structure
str(4.5)
# stored as double
is.double(4.5)
# an integer
4L
# check structure
str(4L)
# logical value
TRUE
# check structure
str(TRUE)
# arithmetic
TRUE + FALSE
# check structure
str(FALSE + FALSE)
# a character string
'yay'
# check structure
str('yay')
# string arithmetic won't work
# '4' + '1'

# but can be performed after converting character strings to numbers
as.numeric('4') + as.numeric('1')
# a factor
factor(1, levels = c(1, 2), labels = c('blue', 'red'))
# less verbose definition
factor('blue', levels = c('blue', 'red'))
# check structure
str(factor('blue', levels = c('blue', 'red')))


# numeric vector
c(1, 4, 7)
# character vector
c('blue', 'red')
# indexing
c(1, 4, 7)[1]
c(1, 4, 7)[2]
c(1, 4, 7)[3]
c(1, 4, 7)[2:3]
c(1, 4, 7)[c(1, 3)]

# assign a name
my_vec <- c(1, 4, 7)

# check structure
str(my_vec)

# an array
my_ary <- array(data = c(1, 2, 3, 4, 5, 6, 7, 8), 
                dim = c(2, 4))

my_ary
str(my_ary)
# another array
my_oth_ary <- array(data = c(1, 2, 3, 4, 5, 6, 7, 8), 
                    dim = c(2, 2, 2))

my_oth_ary
str(my_oth_ary)

# one element
my_ary[1, 2]
# one element
my_oth_ary[1, 2, 1]
# a slice (second row)
my_ary[2, ]
# a slice (first layer)
my_oth_ary[ , , 1]
# a list
list('cat', c(1, 4, 7), TRUE)
# a named list
list(animal = 'cat',
     numbers = c(1, 4, 7),
     short = TRUE)
# assign a name
my_lst <- list(animal = 'cat',
               numbers = c(1, 4, 7),
               short = TRUE)

# check structure
str(my_lst)

# retrieve an element
my_lst[[1]]

# equivalent
my_lst$animal

# a data frame
my_df <- data.frame(animal = c('cat', 'hare', 'tortoise'),
                    has.fur = c(TRUE, TRUE, FALSE),
                    weight.lbs = c(9.1, 8.2, 22.7))

str(my_df)
my_df

















library(tidyverse)

# Load the current class data from this repository.
background <- read_csv('data/background-clean.csv', show_col_types = FALSE)
interest <- read_csv('data/interest-clean.csv', show_col_types = FALSE)
metadata <- read_csv('data/survey-metadata.csv', show_col_types = FALSE)

# CSVs store proficiency labels as text; define their order explicitly.
background <- background %>%
  mutate(across(ends_with('.prof'),
                ~ factor(.x, levels = c('beg', 'int', 'adv'), ordered = TRUE)))

nrow(background)

nrow(interest)

# print the data frame for inspection in the console
background

# In the RStudio Console, run View(background) to open the data viewer.

metadata %>%
  filter(data.file == 'background-clean.csv') %>%
  select(variable.name, variable.description, variable.type, values.notes)

my_df %>% STEP1() %>% STEP2() %>% STEP3()

# a familiar example
my_vec <- c(1, 2, 5) 
str(my_vec)

# use the pipe operator instead
my_vec %>% str()
