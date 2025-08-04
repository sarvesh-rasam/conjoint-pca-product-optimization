###########Conjoint Analysis########################
# Install the package if not already installed
# install.packages("conjoint")

## Load Packages and Set Seed
library(conjoint)
library(readxl)
set.seed(40426973)

###########Defining Attribute Levels########################
## Set up attributes and levels as list
attrib.level <- list(Environmental_Friendliness = c("0% CO2 reduction", "30% CO2 reduction", "50% CO2 reduction"),
                     Delivery_Time = c("14 days", "21 days", "30 days"),
                     Service_Level = c("5-year warranty", "5-year warranty & free maintenance", "5-year warranty & free maintenance and installation & upgradeability"),
                     Price = c("1000 GBP", "1200 GBP", "1500 GBP"),
                     Quality_of_material = c("Market average", "A bit higher than market average"),
                     Marketing_Proficiency = c("Not very proficient and poor communication", "Very proficient and have good communication skiils"))


## Read the Product Profile dataset
design <- read.csv(file.choose())
design <- design[, !names(design) %in% c("Product.Profile")]

## Check for correlation in fractional factorial design
print(cor(caEncodedDesign(design)))

###########Conjoint Analysis Study########################
## Read in the survey preference results
pref <- subset(read_excel(file.choose()), select = -c(1))# Choose the file named Conjoint Preferences

# Setting up attributes and levels as a vector and Estimating the part-worths for each respondent 
attrib.vector <- data.frame(unlist(attrib.level, use.names = FALSE))
colnames(attrib.vector) <- c("levels")
part.worths <- NULL

for (i in 1:ncol(pref)) {
  temp <- caPartUtilities(pref[,i], design, attrib.vector)
  ## Defining the Baseline Case
  ## Base Case: Environment friendliness -  0% CO2 reduction, Delivery Time -  14 days, Service Level - 5 year warranty, Price - 1000 GBP, Quality of material - Market average, Marketing proficiency - not very proficient and poor communication
  Base_EF <- temp[,"0% CO2 reduction"]; Base_DT <- temp[,"14 days"]; Base_SL <- temp[,"5-year warranty"]
  Base_Price <- temp[,"1000 GBP"]; Base_QOM <- temp[,"Market average"]; Base_MP <- temp[,"Not very proficient and poor communication"]
  
  ## Adjust Intercept
  temp[,"intercept"] <- temp[,"intercept"] - Base_EF - Base_DT - Base_SL - Base_Price - Base_QOM - Base_MP
  
  ## Adjust Coefficients
  ##Environmental Friendliness
  L1 <- length(attrib.level$Environmental_Friendliness) + 1 ## Add 1 for the intercept
  for (j in 2:L1) {temp [,j] <- temp[,j] - Base_EF}
  ## Delivery Time 
  L2 <- length(attrib.level$Delivery_Time) + L1
  for (k in (L1 + 1): L2){temp[,k] <- temp[,k] - Base_DT}
  ## Service level
  L3 <- length(attrib.level$Service_Level) + L2
  for (l in (L2 + 1): L3){temp[,l] <- temp[,l] - Base_SL}
  ## Price
  L4 <- length(attrib.level$Price) + L3
  for (m in (L3 + 1): L4){temp[,m] <- temp[,m] - Base_Price}
  ## Quality of material
  L5 <- length(attrib.level$Quality_of_material) + L4
  for (n in (L4 + 1): L5){temp[,n] <- temp[,n] - Base_QOM}
  ## Marketing Proficiency
  L6 <- length(attrib.level$Marketing_Proficiency) + L5
  for (o in (L5 + 1): L6){temp[,o] <- temp[,o] - Base_MP}
  part.worths <- rbind(part.worths, temp)
}
rownames(part.worths) <- colnames(pref)

## Export part-worths from analysis
write.csv(part.worths, file.choose(new=TRUE), row.names = FALSE) ## Name the file conjoint-pathworths.csv
