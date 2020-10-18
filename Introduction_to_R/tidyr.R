require(readxl)
require(tidyr)

setwd("C:/Users/Rohmin-PC/Desktop/Introduction_to_R")

pop <- read_xlsx("./Data/Population.xlsx", sheet = 1, skip = 5)


year_columns <- c(1960:2019)

# wide to long
pop_wide_long <- pivot_longer(pop,
                              cols= as.character(year_columns),
                              names_to="year",
                              values_to="population")



# long to wide
pop_long_wide <- pivot_wider(pop_wide_long,
                             names_from = "year",
                             values_from  = "population")
