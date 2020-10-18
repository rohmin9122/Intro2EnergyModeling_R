library(readxl)
library(tibble)

setwd("C:/Users/Rohmin-PC/Desktop/Introduction_to_R")

pop <- read_xlsx("./Data/Population.xlsx", sheet = 1, skip = 5)


# convert list to a classic dataframe
df<- as.data.frame(pop)

# convert list to a tibble dataframe
tib <- as_tibble(pop)




















tib2 <- tibble(x1=1:4,
               x2=c("a", "b", "c", "d"),
               x3=c(TRUE, FALSE, TRUE, FALSE))


tib <- as_tibble(df)
