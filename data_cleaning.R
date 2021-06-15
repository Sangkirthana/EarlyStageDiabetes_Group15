#Data Cleaning
library(tidyverse)

#Load dataset
df <- read.csv('diabetes_data_upload.csv')
head(df)

#List structure of dataset
str(df)

#Get number of rows
nrow(df)

#Get number of columns
ncol(df)

#Checking for null value
any(is.na(df))

myData <- df %>% 
  rename(
    Results = class
  )

#Convert variables classes
myData$Gender <- factor(myData$Gender, labels=c('Female','Male'))
myData$Polyuria <- factor(myData$Polyuria, labels=c('Yes','No'))
myData$Polydipsia <- factor(myData$Polydipsia, labels=c('Yes','No'))
myData$sudden.weight.loss <- factor(myData$sudden.weight.loss, labels=c('Yes','No'))
myData$weakness <- factor(myData$weakness, labels=c('Yes','No'))
myData$Polyphagia <- factor(myData$Polyphagia, labels=c('Yes','No'))
myData$Genital.thrush <- factor(myData$Genital.thrush, labels=c('Yes','No'))
myData$visual.blurring <- factor(myData$visual.blurring, labels=c('Yes','No'))
myData$Itching <- factor(myData$Itching, labels=c('Yes','No'))
myData$Irritability <- factor(myData$Irritability, labels=c('Yes','No'))
myData$delayed.healing <- factor(myData$delayed.healing, labels=c('Yes','No'))
myData$partial.paresis <- factor(myData$partial.paresis, labels=c('Yes','No'))
myData$muscle.stiffness <- factor(myData$muscle.stiffness, labels=c('Yes','No'))
myData$Alopecia <- factor(myData$Alopecia, labels=c('Yes','No'))
myData$Obesity <- factor(myData$Obesity, labels=c('Yes','No'))
myData$Results <- factor(myData$Results, labels=c('Positive','Negative'))
class(myData$Results)

#Save cleaned file into new csv
write.csv(myData,'diabetes_cleaned.csv')