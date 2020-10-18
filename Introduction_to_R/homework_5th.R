require("readxl")
require("writexl")
require("readr")

# Set working directory
setwd("C:/Users/Rohmin-PC/Desktop/Introduction_to_R")



# constant variable
START_YEAR <- 2010
END_YEAR <- 2015
CONV_KGOE_TO_TOE <- 1/1000 # 1kg of oil equivalent= 1/1000 Ton of oil equivalent
CONV_ONE_TO_BILL <- 1/1000000000



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
totalEn <- data.frame(matrix(0, ncol=END_YEAR-START_YEAR+2, nrow=1))
colnames(totalEn) <- c("country.code", START_YEAR:END_YEAR) # set column names
totalEn$country.code <- "WORLD" 


# compute total energy
cntCodes <- unique(pcEn$`Country Code`)
for(code in cntCodes){
  for (year in START_YEAR:END_YEAR) {
    
    # we can't use number as a variable name
    # so convert numeric value to character value.
    col_year <- as.character(year)
    
    pcEn_year <- pcEn[pcEn$`Country Code`== code, col_year]
    pop_year <- pop[pop$`Country Code`== code, col_year]
    
    
    # total energy = energy per capita * population
    # convert unit from kgoe to bill. TOE 
    totalEn_year <- pcEn_year * pop_year * CONV_KGOE_TO_TOE * CONV_ONE_TO_BILL
    
    
    # store the total energy into new data frame
    totalEn[1, col_year] <-  totalEn[1, col_year]+ totalEn_year
  }
}


# save data as csv file
write_csv(totalEn, path = "./Output/world_total_energy.csv")



