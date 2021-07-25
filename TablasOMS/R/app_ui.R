#' The application User-Interface
#' Listo
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    shinydashboard::dashboardPage(
      
      shinydashboard::dashboardHeader( title = "Crecimiento Infantil", 
                                       shinydashboard::dropdownMenu( type = "messages", 
                                                                     shinydashboard::messageItem("my correo","correo", 
                                                                                                 href = "" ),
                                                                     shinydashboard::messageItem("my fb", "fb", 
                                                                                                 href = "", 
                                                                                                 icon = icon("life-ring")))),
      
      shinydashboard::dashboardSidebar(
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
      
      shinydashboard::dashboardBody(dashboardthemes::shinyDashboardThemes(
        theme = "grey_dark"),
        
        tabsetPanel(type= "tabs", id = "tabselected", # id para condition
                    tabPanel("Peso, Longitud de 0 a 2 años", 
                             h3("Desnutricion Aguda 0 a 2 años"), 
                             plotly::plotlyOutput("plot_1"), h3("tabla"),
                             DT::DTOutput("tabla_1")),
                    tabPanel("Peso, Estatura 2 a 5 años", 
                             h3("Desnutricion Aguda 2 a 5 años"),
                             plotly::plotlyOutput("plot_2"), h3("tabla"),
                             DT::DTOutput("tabla_2")),
                    tabPanel("Edad, Estatura 0 a 13 semanas", 
                             h3("Desnutricion Cronica 0 a 13 semanas"),
                             plotly::plotlyOutput("plot_3"), h3("tabla"),
                             DT::DTOutput("tabla_3"), value = 3),
                    tabPanel("Edad, Estatura 0 a 5 años", 
                             h3("Desnutricion Cronica 0 a 5 años"),
                             plotly::plotlyOutput("plot_4"), h3("Tabla"), 
                             DT::DTOutput("tabla_4"), textOutput("date")),
                    tabPanel("P. Cefalico, 0 a 5 años", 
                             h3("Perimetro Cefalico De 0 a 5 años"),
                             plotly::plotlyOutput("plot_5"), h3("Tabla"), 
                             DT::DTOutput("tabla_5")),
                    tabPanel("Niñ@s Mayores de 5 años", 
                             h3("Estatura entre 5 y 19 años"),
                             plotly::plotlyOutput("plot_6"), 
                             h3("Tabla de Estatura de 5 a 19 años"), 
                             DT::DTOutput("tabla_6"),
                             h3("Peso de 5 a 10 años"),
                             plotly::plotlyOutput("plot_7"),
                             h3("Tabla de Peso de 5 a 10 años"), 
                             DT::DTOutput("tabla_7"))
        ))
      
    )
    
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'TablasOMS'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

