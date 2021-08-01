library(tidyverse)
library(shiny)
library(shinydashboard)
library(plotly)
library(dashboardthemes)
library(DT)


dashboardPage(
  
    dashboardHeader( title = "Crecimiento Infantil", 
                     dropdownMenu( type = "messages", 
                                  messageItem("my correo","correo", 
                                              href = "" ),
                                  messageItem("my fb", "fb", 
                                              href = "", 
                                              icon = icon("life-ring")))),
    
    dashboardSidebar(
            h4("Coloque la Fecha de Nacimiento o los Meses de Nacimiento"),
            dateInput("fecha", label = "Fecha de Nacimiento", value = Sys.time()),
            
            numericInput("mes", label = "Meses de Nacimiento", value = 0),
            numericInput("talla", label = " Longitud/Estatura en cm.", 
                         value = 20),
            numericInput("peso", label = " Peso en Kilogramos", 
                         value = 20),
            selectInput("sexo", label = "Selecione el sexo", 
                        choices = c("niño", "niña")),
            numericInput("cefalico", label = " Perimetro Cefalico en cm", 
                         value = 20),
            conditionalPanel( condition = "input.tabselected==3",
                              sliderInput( "semana", 
                                           label = "Semanas de nacimiento", 
                                           min = 0, max = 13, value = 0))
                              ),
    
    dashboardBody(shinyDashboardThemes(
        theme = "grey_dark"),
        
        tabsetPanel(type= "tabs", id = "tabselected", # id para condition
                    tabPanel("Peso, Longitud de 0 a 2 años", 
                             h3("Desnutricion Aguda 0 a 2 años"), 
                             plotlyOutput("plot_1"), h3("tabla"),
                             DTOutput("tabla_1")),
                    tabPanel("Peso, Estatura 2 a 5 años", 
                             h3("Desnutricion Aguda 2 a 5 años"),
                             plotlyOutput("plot_2"), h3("tabla"),
                             DTOutput("tabla_2")),
                    tabPanel("Edad, Estatura 0 a 13 semanas", 
                             h3("Desnutricion Cronica 0 a 13 semanas"),
                             plotlyOutput("plot_3"), h3("tabla"),
                             DTOutput("tabla_3"), value = 3),
                    tabPanel("Edad, Estatura 0 a 5 años", 
                             h3("Desnutricion Cronica 0 a 5 años"),
                             plotlyOutput("plot_4"), h3("Tabla"), 
                             DTOutput("tabla_4"), textOutput("date")),
                    tabPanel("P. Cefalico, 0 a 5 años", 
                             h3("Perimetro Cefalico De 0 a 5 años"),
                             plotlyOutput("plot_5"), h3("Tabla"), 
                             DTOutput("tabla_5")),
                    tabPanel("Niñ@s Mayores de 5 años", 
                             h3("Estatura entre 5 y 19 años"),
                             plotlyOutput("plot_6"), 
                             h3("Tabla de Estatura de 5 a 19 años"), 
                             DTOutput("tabla_6"),
                             h3("Peso de 5 a 10 años"),
                             plotlyOutput("plot_7"),
                             h3("Tabla de Peso de 5 a 10 años"), 
                             DTOutput("tabla_7")),
                    tabPanel("INFORMACION", includeMarkdown("about.md"))
                    ))
    
    )
