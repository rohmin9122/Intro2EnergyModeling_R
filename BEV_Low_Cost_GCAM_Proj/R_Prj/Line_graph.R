library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)


## For trimming GCAM output data ##

# Import Data #
GCAM_output <- read_csv("GCAM_outputs.csv", skip = 1)


# Trim  Data #
wanted_year <- seq(2015, 2050, by = 5)

GCAM_output <- GCAM_output %>%
  select(scenario, region, input, as.character(wanted_year), Units) %>%
  #filter(input == 'elect_td_trn') %>%
  filter(input == 'delivered gas') %>%
  pivot_longer(cols = as.character(wanted_year),
               names_to = "year",
               values_to = "value") %>%
  mutate( scenario = case_when(
    
    scenario == "Reference,date=2020-24-9T11:39:03+09:00" ~ "Reference",
    scenario == "Reference_BEV_Low_Cost,date=2020-24-9T12:21:36+09:00" ~ "BEV_Low_Cost_scenario",
    TRUE ~ scenario
    
  )) %>%
  
  mutate(data_type = "GCAM_simulation")



## For trimming IEA historical data ##
IEA_data <- read_csv("Natural gas final consumption by sector - Korea.csv", skip = 4)
  
# Change Column name from X1 to year
names(IEA_data)[names(IEA_data) == "X1"] <- "year"

# For Unit conversion #
toe_to_EJ <- 0.0000000419
ktoe_to_EJ <- toe_to_EJ * 10^(3)
TJ_to_EJ <- 1/10^(6)

# Trim Data #
IEA_data <- IEA_data %>%
  select(year, Transport, Units) %>%
  rename(value = Transport) %>%
  mutate(scenario = 'Historical_Data',
         region = "South Korea",
         input = "delivered gas",
         Units = "EJ",
         data_type = "IEA_historical_data"
         ) %>%
  mutate(value = value * TJ_to_EJ) %>%
  select(scenario, region, input, Units, year, value, data_type)
  
  
## Bind GCAM output data and IEA data
GCAM_output$year <- as.numeric(GCAM_output$year)
data_for_graph <-
  GCAM_output %>%
  bind_rows(IEA_data)


## Draw graph ##

ggplot(data = data_for_graph, aes(x= year, y = value, group = scenario)) +
  geom_line(mapping = aes(colour = data_type), size = 1.5) +
  
  geom_point(mapping = aes(shape = scenario, colour = data_type), size = 5) +
  
  scale_x_continuous(breaks = unique(data_for_graph$year)) +
  
  labs(title = "Natural Gas Consumption in Trn Sector",
       x = "Year", 
       y = "Natural Gas Consumption (exajoule)") +
  theme(text = element_text(size = 25),
        legend.position = c(0.15, 0.8))
  



  
  
  
