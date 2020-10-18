library("readxl")
library("tibble")
library("dplyr")
library("tidyr")
library("ggplot2")
library("scales")

# Set working directory
setwd("D:/Proejct_GitHub/Intro2EnergyModeling_R/Introduction_to_R")


# constant variable
YEARS <- c(2000, 2005, 2010)
CONV_KGOE_TO_TOE <- 1/1000 # 1kg of oil equivalent= 1/1000 Ton of oil equivalent


# importing data of xlsx file without NA values
getXlsxFile <- function(fileName, sheetNum, skipRow){
  
  filePath <- paste0("./Data/", fileName, ".xlsx")
  
  dat <- read_xlsx(path = filePath,
                   sheet = sheetNum,
                   skip = skipRow) %>%
    # wide to long
    pivot_longer(cols= as.character(c(1960:2019)),
                 names_to="year",
                 values_to="value") %>%
    # change NA to 0
    replace_na(list(value=0))

  return(dat)
}


# load data files
pcEn <- getXlsxFile("Energy_Use", 1, 5) # energy use per capita (unit: kgoe per capita)
pop <- getXlsxFile("Population", 1, 5) # population (unit: one person)


# compute total energy
totalEn <- pcEn %>%
  # join two data tables by country code
  left_join(pop, by=c("year", "Country Code")) %>%
  # filter country code beginning with ‘E’, and year 2000, 2005, and 2010
  filter(year%in%YEARS & startsWith(`Country Code`, "E")) %>%
  # compute total energy use by country (unit: TOE)
  mutate(total.en = value.x*value.y*CONV_KGOE_TO_TOE) %>%
  # Select country code, year, and total energy columns
  select(`Country Code`, year, total.en)



# draw chart
plot.totalEn <- ggplot(data = totalEn, aes(x=`Country Code`, y=total.en)) +
  # add bar plot
  geom_bar(mapping = aes(fill = `Country Code`),
           stat = "identity",
           color = "#000000",
           size = 0.5)+
  # specify y value format
  scale_y_continuous( labels = comma) +
  # specify colors manually
  scale_fill_manual(values = c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99',
                               '#e31a1c','#fdbf6f','#ff7f00','#cab2d6','#6a3d9a',
                               '#8dd3c7','#ffffb3','#bebada')) +
  # devide a plot into subplots based on year
  facet_grid(cols = vars(year)) +
  # Add labels
  labs(title = "Total Energy",
       caption = "Note: Data is obtained from World Bank.",
       y = "Total Energy (Unit: TOE)") +
  # Change angle of x axis label and legend position
  theme(axis.text.x = element_text(angle = 45),
        legend.position = "bottom")

