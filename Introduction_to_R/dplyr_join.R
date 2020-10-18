library(tidyr)
library(dplyr)


a <- tibble(x1 = c("A", "B", "C"), x2 = 1:3)
b <- tibble(x1 = c("A", "B", "D"), x3 = c(TRUE, FALSE, TRUE))


join1 <- a %>% left_join(b, by="x1")

join2 <- a %>% right_join(b, by="x1")

join3 <- a %>% inner_join(b, by="x1")

join4 <- a %>% full_join(b, by="x1")




c <- cbind(a, x4=c("E","F","G"))
d <- cbind(b, x4=c("E","G","H"))


join5 <- c %>% left_join(d, by=c("x1", "x4"))
