#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- shinyServer(function(input, output,session) {
  load("data/data_craneal_05.rda")
  load("data/data_ee_013.rda")
  load("data/data_ee_05.rda")
  load("data/data_ep_25.rda")
  load("data/data_lp_02.rda")
  load("data/data_ee_519.rda")
  load("data/data_ep_510.rda")
  # Converts to factors
  func_factor <-function(x){
    x<- factor(x, levels = c("+3 SD","+2 SD","+1 SD","Mediana",
                             "-1 SD","-2 SD","-3 SD")) }
  data_craneal_05$Desviacion <- func_factor(data_craneal_05$Desviacion)
  data_ee_013$Desviacion <- func_factor(data_ee_013$Desviacion)
  data_ee_05$Desviacion <- func_factor(data_ee_05$Desviacion)
  data_ep_25$Desviacion <- func_factor(data_ep_25$Desviacion)
  data_lp_02$Desviacion <- func_factor(data_lp_02$Desviacion)
  data_ee_519$Desviacion <- func_factor(data_ee_519$Desviacion)
  data_ep_510$Desviacion <- func_factor(data_ep_510$Desviacion)
  
  # Function shiny 
  mes <- reactive({
    if ( input$mes >0  ) {
      mes = input$mes
      mes
    } else {
      entrada = lubridate::as_date(input$fecha )
      hoy= lubridate::as_date(Sys.time())
      x = hoy - entrada
      mes = round( lubridate::time_length(x, unit = "month"))
      mes      }   })
  
  output$plot_1 = plotly::renderPlotly( {
    talla = input$talla
    p = input$peso
    
    if (input$sexo=="niña" ) {
      data = data_lp_02[data_lp_02$sexo=="niña",]
    } else{data = data_lp_02[data_lp_02$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x= Longitud, y= Peso, col = Desviacion)) + 
      ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = talla , y = p , col="black")  
    return(g) })
  
  
  output$plot_2 = plotly::renderPlotly( {
    talla = input$talla
    p = input$peso
    
    if (input$sexo=="niña" ) {
      data = data_ep_25[data_ep_25$sexo=="niña",]
    } else{data = data_ep_25[data_ep_25$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x= Estatura, y= Peso, col = Desviacion)) + 
      ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = talla , y = p , col="black")  
    return(g) })
  
  ## D Cronica
  output$plot_3 = plotly::renderPlotly( {
    talla = input$talla
    semana = input$semana
    
    if (input$sexo=="niña" ) {
      data = data_ee_013[data_ee_013$sexo=="niña",]
    } else{data = data_ee_013[data_ee_013$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x=Semanas , y= Longitud, col = Desviacion)) + 
      ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = semana , y = talla , col="black")  
    return(g) })
  
  output$plot_4 = plotly::renderPlotly( {
    talla = input$talla
    
    if (input$sexo=="niña" ) {
      data = data_ee_05[data_ee_05$sexo=="niña",]
    } else{data = data_ee_05[data_ee_05$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x= Mes, y= Estatura, col = Desviacion)) + 
      ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = mes() , y = talla , col="black")  
    return(g) })
  
  
  output$plot_5 = plotly::renderPlotly( {
    Perimetro_cefalico = input$cefalico
    
    if (input$sexo=="niña" ) {
      data = data_craneal_05[data_craneal_05$sexo=="niña",]
    } else{data = data_craneal_05[data_craneal_05$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x=Meses , y= Perimetro_cefalico, 
                                          col = Desviacion)) + ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = mes() , y = Perimetro_cefalico , col="black")  
    return(g) })
  
  
  output$date = renderText({
    entrada = lubridate::as_date(input$fecha )
    hoy= lubridate::as_date(Sys.time())
    x = hoy - entrada
    round( lubridate::time_length(x, unit = "month"))   })
  
  # 5 19 años
  output$plot_6 = plotly::renderPlotly( {
    talla = input$talla
    
    if (input$sexo=="niña" ) {
      data = data_ee_519[data_ee_519$sexo=="niña",]
    } else{data = data_ee_519[data_ee_519$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x= Meses, y= Estatura, col = Desviacion)) + 
      ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = mes() , y = talla , col="black")  
    return(g) })
  # 5 a 10 años     
  output$plot_7 = plotly::renderPlotly( {
    peso = input$peso
    
    if (input$sexo=="niña" ) {
      data = data_ep_510[data_ep_510$sexo=="niña",]
    } else{data = data_ep_510[data_ep_510$sexo=="niño",]}
    
    g= ggplot2::ggplot(data, ggplot2::aes(x= Meses, y= Peso, col = Desviacion)) + 
      ggplot2::geom_line( size = .7 )+
      ggplot2::geom_point( x = mes() , y = peso , col="black")  
    return(g) })
  
  # Tablas
  output$tabla_1 = DT::renderDT({
    talla = input$talla
    data_table <- tidyr::spread(data_lp_02,key = "Desviacion", value = "Peso")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Longitud==talla & 
                 data_table$sexo==input$sexo,]  })
  
  output$tabla_2 = DT::renderDT({
    talla = input$talla
    data_table <- tidyr::spread(data_ep_25,key = "Desviacion", value = "Peso")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Estatura==talla & 
                 data_table$sexo==input$sexo,]  })
  
  output$tabla_3 = DT::renderDT({
    semana = input$semana
    data_table <- tidyr::spread(data_ee_013,key = "Desviacion", 
                                value = "Longitud")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Semanas==semana & 
                 data_table$sexo==input$sexo,]  })
  
  output$tabla_4 = DT::renderDT({
    data_table <- tidyr::spread(data_ee_05,key = "Desviacion", 
                                value = "Estatura")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Mes==mes() & 
                 data_table$sexo==input$sexo,]  })
  
  output$tabla_5 = DT::renderDT({
    data_table <- tidyr::spread(data_craneal_05,key = "Desviacion",
                                value = "Perimetro_cefalico")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Meses==mes() &
                 data_table$sexo==input$sexo,]  })
  
  output$tabla_6 = DT::renderDT({
    data_table <- tidyr::spread(data_ee_519,key = "Desviacion",
                                value = "Estatura")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Meses==mes() &
                 data_table$sexo==input$sexo,]  })
  
  output$tabla_7 = DT::renderDT({
    data_table <- tidyr::spread(data_ep_510,key = "Desviacion",
                                value = "Peso")
    data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
    data_table[data_table$Meses==mes() &
                 data_table$sexo==input$sexo,]  })
  
} )