require("readxl")
require("writexl")

# Set working directory
setwd("D:/Proejct_GitHub/Intro2EnergyModeling_R/Introduction_to_R")



# constant variable
START_YEAR <- 2000
END_YEAR <- 2015
CONV_KGOE_TO_TOE <- 1/1000 # 1kg of oil equivalent= 1/1000 Ton of oil equivalent



# importing data of xlsx file without NA values
getXlsxFile <- function(fileName, sheetNum, skipRow){
  
  filePath <- paste0("./Data/", fileName, ".xlsx")
  
  dat <- read_xlsx(path = filePath,
                   sheet = sheetNum,
                   skip = skipRow)
  
  # change NA to 0
  dat[is.na(dat)] <- 0
  
  return(dat)
}



# load data files
pcEn <- getXlsxFile("Energy_Use", 1, 5) # energy use per capita (unit: kgoe per capita)
pop <- getXlsxFile("Population", 1, 5) # population (unit: one person)



# create a new data frame in which total energy use will be stored
# length of columns (END_YEAR-START_YEAR+2): country.code, START_YEAR, ...., END_YEAR
totalEn <- data.frame(matrix(0, ncol=END_YEAR-START_YEAR+2, nrow=nrow(pcEn)))
colnames(totalEn) <- c("country.code", START_YEAR:END_YEAR) # set column names

# get country code from pcEnergy data
cntCodes <- unique(pcEn$`Country Code`)
totalEn$country.code <- unique(pcEn$`Country Code`) # initialize country code


# compute total energy
for(code in cntCodes){
  for (year in START_YEAR:END_YEAR) {
    
    # we can't use number as a variable name
    # so convert numeric value to character value.
    col_year <- as.character(year)
    
    pcEn_year <- pcEn[pcEn$`Country Code`== code, col_year]
    pop_year <- pop[pop$`Country Code`== code, col_year]
    
    
    # total energy = energy per capita * population
    # convert unit from kgoe to TOE 
    totalEn_year <- pcEn_year * pop_year * CONV_KGOE_TO_TOE
    
    
    # store the total energy into new data frame
    totalEn[totalEn$country.code == code, col_year] <- totalEn_year
  }
}


# save data as xlsx file
write_xlsx(totalEn, path = "./Output/total_energy.xlsx")



