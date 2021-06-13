#------------------------------Load libraries-----------------------------------
library(caret)
library(data.table)
library(dplyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)

#------------------------------Load data----------------------------------------
#Load raw dataset
df <-read.csv('diabetes_data_upload.csv')
df1 <-data.frame(df,stringsAsFactors = FALSE)

#Load data dictionary
dict <- as.data.frame(read.csv("dict.csv"))

#Load cleaned dataset
myData <- read.csv('diabetes_cleaned.csv')
myData = subset(myData, select = -c(X))

#------------------------------UI-----------------------------------------------
ui <- dashboardPage(skin="purple",
  header <- dashboardHeader(title = "Early Stage Diabetes"),
  
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("bars")),
      menuItem("Dataset", tabName = "dataset", icon = icon("database")),
      menuItem("Descriptive Analysis", tabName = "descriptive", icon = icon("chart-area")),
      menuItem("EDA", tabName = "eda", icon = icon("chart-bar")),
      menuItem("Prediction", tabName = "predict", icon = icon("chart-line"))
    )
  ),
  
  body <- dashboardBody(
    tabItems(
      
#------------------------------Overview Tab-------------------------------------      
      tabItem(tabName = "overview",
              h1("Overview"),
              h2("Group 15 (Sugar Rush)"),
              h3("Team Members:", br(),
                 "1. Sangkirthana Mahaletchnan (S2022161)", br(), 
                 "2. Eliza Joanne Marianathan (S2022162)"),
              
              br(),
              
              box(width = 6, height = 400,
                h2("Introduction"),
                h4("Diabetes is considered as one of the deadliest and chronic diseases which 
                   caused by increase in blood sugar. Even though diabetes is one of deathliest 
                   disease, there are various methods available to treat diabetes if it is identified 
                   early. The problem is, diabetes can be treated easily if identified at early stage. 
                   However, early prediction of diabetes is quite a challenging task."),
             
              h2("Questions Asked"),
              h4("1. How to predict diabetes disease in an early stage based on symptoms?"),
              h4("2. What is the relationship between age and diabetes result with different symptoms of diabetes?"),
              h4("3. What insights could we draw from diabetes data?"),
              ),
              
              box(width = 6, height = 400,
                HTML('<center><iframe width="550" height="350" align = "center" src="https://www.youtube.com/embed/D8FZyCgbjJo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>'),
              ),
              
              br(),
              
              h2("User Guide"),
              
              box(width = 3, height = 250, background = "purple",
                h2("Overview tab"),
                h3("Shows the information on the topic, question asked and user guide"),
              ),
              
              box(width = 2, height = 250, background = "purple",
                  h2("Dataset tab"),
                  h3("Shows the description of the dataset used and the data dictionary"),
              ),
              
              box(width = 2, height = 250, background = "purple",
                  h2("Descriptive Analysis tab"),
                  h3("Shows the characteristics of individual variable"),
              ),
              
              box(width = 2, height = 250, background = "purple",
                  h2("EDA tab"),
                  h3("Shows the exploratory data analysis of symptoms"),
              ),
              
              box(width = 3, height = 250, background = "purple",
                  h2("Prediction tab"),
                  h3("Shows the interactive diabetes prediction using logistic regression model"),
              ),
              
      ),

#------------------------------Dataset Tab--------------------------------------   
      tabItem(tabName = "dataset",
              h1("About the Dataset"),
              h3("The dataset contains 520 records with 17 columns. The data dictionary is provided as below:"),
              h2('Data Dictionary'), tabPanel("dict",DT::dataTableOutput("table_df2")),
              h2('Early Stage Diabetes Dataset'),tabPanel("df1",DT::dataTableOutput("table_df1"))
      ),

#------------------------------Descriptive Analysis Tab-------------------------  

      tabItem(tabName = "descriptive",
              h2("Descriptive Data Analysis"),
              box(width = "12", background = "purple",
                  radioButtons('a', 'Select variable: ', 
                               list('Gender'='gender1',
                                    'Age'='age1')),
              ),
              
              plotOutput('dplot')
        
      ),

#------------------------------EDA Tab------------------------------------------  
      tabItem(tabName = "eda",
              h2("Exploratory Data Analysis"),
              box(background = "purple",
                radioButtons('q', 'Select variable:', 
                             list('Age'='age', 
                                  #'Gender'='gender',
                                  'Diabetes Results'='results')),
                radioButtons('t', 'Select early stage symptoms:', 
                             list('Polyuria'='polyuria', 
                                  'Polydipsia' = 'polydipsia',
                                  'Sudden Weight Loss' = 'weight', 
                                  'Weakness' = 'weak',
                                  'Polyphagia' = 'polyphagia', 
                                  'Genital Thrush' = 'thrush',
                                  'Visual Blurring' = 'blur', 
                                  'Itching' = 'itch',
                                  'Irritability' = 'irrit', 
                                  'Partial Paresis' = 'paresis',
                                  'Delayed Healing' = 'delay',
                                  'Muscle Stiffness' = 'stiff',
                                  'Alopecia' = 'alopecia',
                                  'Obesity' = 'obesity')),
                ),
              
              box(
                plotOutput('eplot')
                ),
),


#------------------------------Prediction Tab-----------------------------------  

      tabItem(tabName = "predict",
              h2("Prediction"),
              box(width = "4", background = "purple",
                  numericInput("Age", label = "Age", value = 40),
                  selectInput("Polyuria", "Polyuria (Frequent & Excessive Urine):", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("Polydipsia", "Polydipsia (Excessive Thirst)", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("sudden.weight.loss", "Sudden Weight Loss", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("weakness", "Feeling Body Weakness", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  
              ),
              
              box(width = "4", background = "purple",
                  selectInput("Polyphagia", "Polyphagia (Excessive Hunger)", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("Genital.thrush", "Genital Thrush (Fungal Infection)", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("visual.blurring", "Visual Blurring", 
                              choices = list("Yes" = "Yes", 
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("Itching", "Itching",
                              choices = list("Yes" = "Yes",
                                             "No" = "No"),
                              selected = "No"),
                  selectInput("Irritability", "Irritability", 
                               choices = list("Yes" = "Yes", 
                                              "No" = "No"),
                               selected = "No"),
                ),
              
              box(width = "4", background = "purple",
                selectInput("delayed.healing", "Delayed Healing", 
                            choices = list("Yes" = "Yes", 
                                           "No" = "No"),
                            selected = "No"),
                selectInput("partial.paresis", "Partial Paresis (Weakening of Muscles)", 
                            choices = list("Yes" = "Yes", 
                                           "No" = "No"),
                            selected = "No"),
                selectInput("muscle.stiffness", "Muscle Stiffness", 
                            choices = list("Yes" = "Yes", 
                                           "No" = "No"),
                            selected = "No"),
                selectInput("Alopecia", "Alopecia (Hair Falling)", 
                            choices = list("Yes" = "Yes", 
                                           "No" = "No"),
                            selected = "No"),
                selectInput("Obesity", "Obesity", 
                            choices = list("Yes" = "Yes", 
                                           "No" = "No"),
                            selected = "No"),
              ),
              
              box(width = "12",
                  valueBoxOutput('ibox', width = 15),
                  box(width = "1",
                  actionButton("refresh",label = "PREDICT"),
                ),
              ),
              
              )
      )
),

dashboardPage(header, sidebar, body)

)

#------------------------------Server-------------------------------------------
server <- function(input, output) {

#------------------------------Dataset Visualization----------------------------
  #table for dataset
  output$table_df1 <- DT::renderDataTable({df}, options = list(scrollX = TRUE))
  #table for data dictionary
  output$table_df2 <- DT::renderDataTable({dict}, options = list(scrollX = TRUE, pageLength = 20))
  
#------------------------------Descriptive Analysis-----------------------------
  output$dplot<- renderPlot({
    
    df_gender<-df %>%
      group_by(Gender) %>%
      summarise(counts = n())
    df_gender
    
    df_Age<-df %>%
      group_by(Age) %>%
      summarise(counts = n())
    df_Age
    
    #------------------------------gender---------------------------------------
    if(input$a=='gender1'){
      d <-ggplot(data = df_gender, mapping = aes(x="", y=counts,  fill=Gender)) +
        geom_bar(stat="identity",width=1, color="white") +
        coord_polar("y", start=0)+
        geom_text(aes(y = cumsum(counts) - 0.5*counts, label = counts), color = "white")+
        ggtitle("Gender Distribution")+
        theme_void()+
        theme(plot.title = element_text(hjust = 0.5))
    }
    
    #------------------------------age------------------------------------------
    if(input$a=='age1'){
      d <-ggplot(data=df_Age, aes(x=Age, y=counts, group=1)) +
        geom_line()+
        geom_point(color="red")+
        ggtitle("Age Distribution")+
        theme(plot.title = element_text(hjust = 0.5))
    }
    
    d
  })
  
  
#------------------------------EDA----------------------------------------------
    
  output$eplot<- renderPlot({
    
    #------------------------------with results---------------------------------
    if(input$q=='results'){
      
      if(input$t=='polyuria'){
        g<-ggplot(data=myData,aes(x=Results,fill=Polyuria)) + 
          geom_bar(data=subset(myData,Polyuria=="Yes")) + 
          geom_bar(data=subset(myData,Polyuria=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) + 
          ggtitle("Relationship between Polyuria and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='polydipsia'){
        g<-ggplot(data=myData,aes(x=Results,fill=Polydipsia)) + 
          geom_bar(data=subset(myData,Polydipsia=="Yes")) + 
          geom_bar(data=subset(myData,Polydipsia=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) + 
          ggtitle("Relationship between Polydipsia and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='weight'){
        g<-ggplot(data=myData,aes(x=Results,fill=sudden.weight.loss)) + 
          geom_bar(data=subset(myData,sudden.weight.loss=="Yes")) + 
          geom_bar(data=subset(myData,sudden.weight.loss=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) + 
          ggtitle("Relationship between Sudden Weight Loss and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='weak'){
        g<-ggplot(data=myData,aes(x=Results,fill=weakness)) + 
          geom_bar(data=subset(myData,weakness=="Yes")) + 
          geom_bar(data=subset(myData,weakness=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) + 
          ggtitle("Relationship between Weakness and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='polyphagia'){
        g<-ggplot(data=myData,aes(x=Results,fill=Polyphagia)) + 
          geom_bar(data=subset(myData,Polyphagia=="Yes")) + 
          geom_bar(data=subset(myData,Polyphagia=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Polyphagia and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='thrush'){
        g<-ggplot(data=myData,aes(x=Results,fill=Genital.thrush)) + 
          geom_bar(data=subset(myData,Genital.thrush=="Yes")) + 
          geom_bar(data=subset(myData,Genital.thrush=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Genital Thrush and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
  
      if(input$t=='blur'){
        g<-ggplot(data=myData,aes(x=Results,fill=visual.blurring)) + 
          geom_bar(data=subset(myData,visual.blurring=="Yes")) + 
          geom_bar(data=subset(myData,visual.blurring=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Visual Blurring and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='itch'){
        g<-ggplot(data=myData,aes(x=Results,fill=Itching)) + 
          geom_bar(data=subset(myData,Itching=="Yes")) + 
          geom_bar(data=subset(myData,Itching=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Itching and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
     
      if(input$t=='irrit'){
        g<-ggplot(data=myData,aes(x=Results,fill=Irritability)) + 
          geom_bar(data=subset(myData,Irritability=="Yes")) + 
          geom_bar(data=subset(myData,Irritability=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Irritability and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='delay'){
        g<-ggplot(data=myData,aes(x=Results,fill=delayed.healing)) + 
          geom_bar(data=subset(myData,delayed.healing=="Yes")) + 
          geom_bar(data=subset(myData,delayed.healing=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Delayed Healing and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='paresis'){
        g<-ggplot(data=myData,aes(x=Results,fill=partial.paresis)) + 
          geom_bar(data=subset(myData,partial.paresis=="Yes")) + 
          geom_bar(data=subset(myData,partial.paresis=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Partial Paresis and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='stiff'){
        g<-ggplot(data=myData,aes(x=Results,fill=muscle.stiffness)) + 
          geom_bar(data=subset(myData,muscle.stiffness=="Yes")) + 
          geom_bar(data=subset(myData,muscle.stiffness=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Muscle Stiffness and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='alopecia'){
        g<-ggplot(data=myData,aes(x=Results,fill=Alopecia)) + 
          geom_bar(data=subset(myData,Alopecia=="Yes")) + 
          geom_bar(data=subset(myData,Alopecia=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Alopecia and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='obesity'){
        g<-ggplot(data=myData,aes(x=Results,fill=Obesity)) + 
          geom_bar(data=subset(myData,Obesity=="Yes")) + 
          geom_bar(data=subset(myData,Obesity=="No"),aes(y=..count..*(-1))) + 
          scale_y_continuous(breaks=seq(-1000,1000,20),labels=abs(seq(-1000,1000,20))) +
          ggtitle("Relationship between Obesity and Diabetes Results") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
    }
    
    #------------------------------with age-------------------------------------
    else if(input$q=='age'){
      
      if(input$t=='polyuria'){
        g<-ggplot(df, aes(x=Polyuria, y=Age, fill=Polyuria)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Polyuria") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='polydipsia'){
        g<-ggplot(df, aes(x=Polydipsia, y=Age, fill=Polydipsia)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Polydipsia") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='weight'){
        g<-ggplot(df, aes(x=sudden.weight.loss, y=Age, fill=sudden.weight.loss)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Sudden Weight Loss") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='weak'){
        g<-ggplot(df, aes(x=weakness, y=Age, fill=weakness)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Weakness") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='polyphagia'){
        g<-ggplot(df, aes(x=Polyphagia, y=Age, fill=Polyphagia)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Polyphagia") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='thrush'){
        g<-ggplot(df, aes(x=Genital.thrush, y=Age, fill=Genital.thrush)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Genital Thrush") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='blur'){
        g<-ggplot(df, aes(x=visual.blurring, y=Age, fill=visual.blurring)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Visual Blurring") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='itch'){
        g<-ggplot(df, aes(x=Itching, y=Age, fill=Itching)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Itching") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='irrit'){
        g<-ggplot(df, aes(x=Irritability, y=Age, fill=Irritability)) + 
          geom_violin(trim = FALSE) +
          ggtitle("Relationship between Age and Irritability") +
          theme(plot.title = element_text(hjust = 0.5))+
          coord_flip()
      }
      
      if(input$t=='delay'){
        g<-ggplot(df, aes(x=delayed.healing, y=Age, fill=delayed.healing)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Delayed Healing") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='paresis'){
        g<-ggplot(df, aes(x=partial.paresis, y=Age, fill=partial.paresis)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Partial Paresis") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='stiff'){
        g<-ggplot(df, aes(x=muscle.stiffness, y=Age, fill=muscle.stiffness)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Muscle Stiffness") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='alopecia'){
        g<-ggplot(df, aes(x=Alopecia, y=Age, fill=Alopecia)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Alopecia") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
      
      if(input$t=='obesity'){
        g<-ggplot(df, aes(x=Obesity, y=Age, fill=Obesity)) + 
          geom_violin(trim = FALSE) + 
          ggtitle("Relationship between Age and Obesity") +
          theme(plot.title = element_text(hjust = 0.5)) +
          coord_flip()
      }
    }
   
    g
    
  })
  
#------------------------------Prediction------------------------------
  
  output$finaltable<-renderTable({
    table_title<-c('Age',
                   'Polyuria',
                   'Polydipsia',
                   'sudden.weight.loss',
                   'weakness',
                   'Polyphagia',
                   'Genital.thrush',
                   'visual.blurring',
                   'Itching',
                   'Irritability',
                   'delayed.healing',
                   'partial.paresis',
                   'muscle.stiffness',
                   'Alopecia',
                   'Obesity')

    table_content<-c(input$Age,
                     input$Polyuria,
                     input$Polydipsia,
                     input$sudden.weight.loss,
                     input$weakness,
                     input$Polyphagia,
                     input$Genital.thrush,
                     input$visual.blurring,
                     input$Itching,
                     input$Irritability,
                     input$delayed.healing,
                     input$partial.paresis,
                     input$muscle.stiffness,
                     input$Alopecia,
                     input$Obesity)

    df<-data.frame('Factor'= table_title,'Value'= table_content)
    df
  },
  rownames = FALSE)

  training_set <- read.csv("diabetes_cleaned.csv")

  colnames(training_set)
  training_set = subset(training_set, select = -c(X, Gender))
  #head(training_set)

  input_data= eventReactive(input$refresh, {
    data= data.frame(Age = input$Age,
                     Polyuria = input$Polyuria,
                     Polydipsia = input$Polydipsia,
                     sudden.weight.loss = input$sudden.weight.loss,
                     weakness = input$weakness,
                     Polyphagia = input$Polyphagia,
                     Genital.thrush = input$Genital.thrush,
                     visual.blurring = input$visual.blurring,
                     Itching = input$Itching,
                     Irritability = input$Irritability,
                     delayed.healing = input$delayed.healing,
                     partial.paresis = input$partial.paresis,
                     muscle.stiffness = input$muscle.stiffness,
                     Alopecia = input$Alopecia,
                     Obesity = input$Obesity)

    return(data)
  })

  #encoding target feature as factor
  training_set$Results<-as.factor(training_set$Results)

  #Fitting logistic regression model with the dataset
  classifier = glm(formula = Results~. , family = binomial, data = training_set)
  final_prediction = eventReactive(input$refresh, {
    prob_pred = predict(classifier,input_data(), type = 'response' )
    return(prob_pred)
  })

  output$ibox = renderValueBox({
    valueBox(
      " ", ifelse( final_prediction() >= 0.5 , 
                             yes = 'POSITIVE RESULT: You need to go to a doctor!', 
                             no = 'NEGATIVE RESULT: You do NOT have diabetes but 
                   if you have symptoms it is good to for a check up!'), 
      color = ifelse(final_prediction() >= 0.5, 'red','green')
    )
  })

}
shinyApp(ui, server)
