library(dplyr)


g <- function(x, multiplier){
  return(x*multiplier)
}

f <- function(y, adder){
  return(y+adder)
}


x <- tibble(x=c(1,2,3))


# no pipe
g_output <- g(x, 2)

f_output <- f(g_output, 1)

gf_output <- g(f_output, 3)



# nested functions
final_output2 <- g(f(g(x,2),1),3)



# pipe
final_output3 <- x %>% g(2) %>% f(1) %>% g(3)

