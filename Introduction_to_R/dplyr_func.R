library("readxl")
library("tidyr")
library("dplyr")

setwd("C:/Users/Rohmin-PC/Desktop/Introduction_to_R")

pop <- read_xlsx("./Data/Population.xlsx", sheet = 1, skip = 5)


year_columns <- c(1960:2019)

# reshaping data
pop_wide_long <- pivot_longer(pop,
                              cols= as.character(year_columns),
                              names_to="year",
                              values_to="pop") %>%
  # replace NA to 0
  replace_na(list(pop=0))



pop2 <- pop_wide_long %>%
  # rename columns
  rename(country.name=`Country Name`,
         country.code=`Country Code`,
         indicator.name=`Indicator Name`,
         indicator.code=`Indicator Code`)
  


pop3 <- pop2 %>%
  # filter out rows where code begins with "A" and "B" and year is 2015
  filter((startsWith(country.code, "A")|startsWith(country.code, "B")) & year ==2015) %>%
  # create a new column
  mutate(group=if_else(startsWith(country.code, "A"), "A", "B")) %>%
  # select columns
  select(country.code, group, pop) %>%
  # ascending order
  #arrange(pop)
  # descending order
  arrange(group, desc(pop))



pop4 <- pop3 %>%
  group_by(group) %>%
  summarize(total.pop=sum(pop)) %>%
  ungroup()





