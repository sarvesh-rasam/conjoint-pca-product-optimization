#Perceptual and Preference Mapping

# Install Packages (if needed)
#install.packages("data.table")

# Load Packages and set seed
library(data.table)
set.seed(40426973)

## Read in the perception and preference data 
per <- read.csv(file.choose())## Choose PCA data file

## Run Principle Components Analysis on Preceptions
pca <- prcomp(per[,2:length(per)], retx = TRUE, scale = TRUE)

## Print Singular Values
singular_values <- pca$sdev
print(singular_values)

## Print Loading Factors
loading_factors <- pca$rotation
print(loading_factors)

## Calculate and Print Proportion of Variance Explained (PVEs)
PVEs <- singular_values ^ 2 / sum(singular_values ^ 2)
cat("Proportion of Variance Explained:", PVEs, "\n")

## Perceptual Map Data - Attribute Factors and CSV File
attribute <- as.data.table(colnames(per[,2:length(per)])); setnames(attribute, 1, "Attribute")
factor1 <- pca$rotation[,1]*pca$sdev[1]; factor2 <- pca$rotation[,2]*pca$sdev[2]; path <- rep(1, nrow(attribute))
pca_factors <- subset(cbind(attribute, factor1, factor2, path), select = c(Attribute, factor1, factor2, path))
pca_origin <- cbind(attribute, factor1 = rep(0,nrow(attribute)), factor2 = rep(0,nrow(attribute)), path = rep(0,nrow(attribute)))
pca_attributes <- rbind(pca_factors, pca_origin)
write.csv(pca_attributes, file = file.choose(new=TRUE), row.names = FALSE) ## Name file perceptions_attributes.csv

## Perceptual Map Data - Brand Factors and CSV File
score1 <- (pca$x[,1]/apply(abs(pca$x),2,max)[1])
score2 <- (pca$x[,2]/apply(abs(pca$x),2,max)[2])
pca_scores <- subset(cbind(per, score1, score2), select = c(Model, score1, score2))
write.csv(pca_scores, file = file.choose(new=TRUE), row.names = FALSE) ## Name file perceptions_scores.csv
