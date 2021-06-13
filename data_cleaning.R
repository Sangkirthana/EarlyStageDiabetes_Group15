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

#The dataset contains 520 records with 17 columns. The data dictionary is provided as below
# 1. Age: Indicates the age of the patient.
# 2. Gender: Identify gender of the patient. Male/Female. 
# 3. Polyuria: Indicates if a person passes frequent and passes excessive amounts of urine. Yes/No. 
# 4. Polydipsia: Indicates if a person has excessive thirst or excess drinking. Yes/No. 
# 5. sudden.weight.loss: Indicates if a person have sudden weight loss. Yes/No. 
# 6. weakness: Indicates if a person feels body weakness. Yes/No. 
# 7. Polyphagia: Indicates if a person has excessive or extreme hunger. Yes/No. 
# 8. Genital.thrush: Indicates if a person has fungal infection at the genital area. Yes/No. 
# 9. visual.blurring: Indicates if a person has blurry vision. Yes/No.
# 10. Itching: Indicates if a person has irritating sensation on the skin that causes scratching. Yes/No. 
# 11. Irritability: Indicates if a person if often irritable. Yes/No. 
# 12. delayed.healing: Indicates if a person has slow healing. Yes/No. 
# 13. partial.paresis: Indicates if a person experiences partial weakening of muscles. Yes/No.
# 14. muscle.stiffness: Indicates if muscles feel tight and more difficult to move than you usually do. Yes/No.
# 15. Alopecia: Indicates if a person has condition that causes hair to fall out in small patches. Yes/No. 
# 16. Obesity: Indicates if a person has a BMI over 30. Yes/No. 
# 17. class: Indicates the results of having diabetes. Positive/Negative. 

#Checking for null value
any(is.na(df))

myData <- df %>% 
  rename(
    Results = class
  )

# #Converting age to age_group
# myData[myData$Age < 20, "Age"] <- '20 below'
# myData[myData$Age > 10 & myData$Age <= 20, "Age"] <- '11-20'
# myData[myData$Age > 20 & myData$Age <= 30, "Age"] <- '21-30'
# myData[myData$Age > 30 & myData$Age <= 40, "Age"] <- '31-40'
# myData[myData$Age > 40 & myData$Age <= 50, "Age"] <- '41-50'
# myData[myData$Age > 50 & myData$Age <= 60, "Age"] <- '51-60'
# myData[myData$Age > 60 & myData$Age <= 70, "Age"] <- '61-70'
# myData[myData$Age > 70, "Age"] <- '70 above'
# 
# #filter(df, Age < '20')

# Convert variables classes
# myData$Gender <- factor(myData$Gender, labels=c('Female','Male'))
# myData$Polyuria <- factor(myData$Polyuria, labels=c('Yes','No'))
# myData$Polydipsia <- factor(myData$Polydipsia, labels=c('Yes','No'))
# myData$sudden.weight.loss <- factor(myData$sudden.weight.loss, labels=c('Yes','No'))
# myData$weakness <- factor(myData$weakness, labels=c('Yes','No'))
# myData$Polyphagia <- factor(myData$Polyphagia, labels=c('Yes','No'))
# myData$Genital.thrush <- factor(myData$Genital.thrush, labels=c('Yes','No'))
# myData$visual.blurring <- factor(myData$visual.blurring, labels=c('Yes','No'))
# myData$Itching <- factor(myData$Itching, labels=c('Yes','No'))
# myData$Irritability <- factor(myData$Irritability, labels=c('Yes','No'))
# myData$delayed.healing <- factor(myData$delayed.healing, labels=c('Yes','No'))
# myData$partial.paresis <- factor(myData$partial.paresis, labels=c('Yes','No'))
# myData$muscle.stiffness <- factor(myData$muscle.stiffness, labels=c('Yes','No'))
# myData$Alopecia <- factor(myData$Alopecia, labels=c('Yes','No'))
# myData$Obesity <- factor(myData$Obesity, labels=c('Yes','No'))
# myData$Results <- factor(myData$Results, labels=c('Positive','Negative'))
#class(myData$Results)

#Save cleaned file into new csv
write.csv(myData,'diabetes_cleaned.csv')


