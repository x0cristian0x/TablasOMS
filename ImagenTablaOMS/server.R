library(tidyverse)
library(shiny)
library(shinydashboard)
library(plotly)
library(dashboardthemes)
library(DT)
library(lubridate)

# Read data
data_craneal_05 <- read_csv("data_craneal_05.csv")
data_ee_013 <- read_csv("data_ee_013.csv")
data_ee_05 <- read_csv("data_ee_05.csv")
data_ep_25 <- read_csv("data_ep_25.csv")
data_lp_02 <- read_csv("data_lp_02.csv")
data_ee_519 <- read_csv("data_ee_519.csv")
data_ep_510 <- read_csv("data_ep_510.csv")
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
rm(func_factor)

# Function shiny
shinyServer(function(input, output,session) {
    
  mes <- reactive({
    if ( input$mes >0  ) {
      mes = input$mes
      mes
    } else {
      entrada = as_date(input$fecha )
      hoy= as_date(Sys.time())
      x = hoy - entrada
      mes = round( time_length(x, unit = "month"))
      mes      }   })
  
      output$plot_1 = renderPlotly( {
        talla = input$talla
        p = input$peso
      
        if (input$sexo=="niña" ) {
          data = data_lp_02[data_lp_02$sexo=="niña",]
        } else{data = data_lp_02[data_lp_02$sexo=="niño",]}
        
        g= ggplot(data, aes(x= Longitud, y= Peso, col = Desviacion)) + 
           geom_line( size = .7 )+
           geom_point( x = talla , y = p , col="black")  
        return(g) })
                 
      
      output$plot_2 = renderPlotly( {
        talla = input$talla
        p = input$peso
        
        if (input$sexo=="niña" ) {
          data = data_ep_25[data_ep_25$sexo=="niña",]
        } else{data = data_ep_25[data_ep_25$sexo=="niño",]}
        
        g= ggplot(data, aes(x= Estatura, y= Peso, col = Desviacion)) + 
          geom_line( size = .7 )+
          geom_point( x = talla , y = p , col="black")  
        return(g) })
      
## D Cronica
      output$plot_3 = renderPlotly( {
        talla = input$talla
        semana = input$semana
        
        if (input$sexo=="niña" ) {
          data = data_ee_013[data_ee_013$sexo=="niña",]
        } else{data = data_ee_013[data_ee_013$sexo=="niño",]}
        
        g= ggplot(data, aes(x=Semanas , y= Longitud, col = Desviacion)) + 
          geom_line( size = .7 )+
          geom_point( x = semana , y = talla , col="black")  
        return(g) })
        
      output$plot_4 = renderPlotly( {
        talla = input$talla
        
        if (input$sexo=="niña" ) {
          data = data_ee_05[data_ee_05$sexo=="niña",]
        } else{data = data_ee_05[data_ee_05$sexo=="niño",]}
        
        g= ggplot(data, aes(x= Mes, y= Estatura, col = Desviacion)) + 
          geom_line( size = .7 )+
          geom_point( x = mes() , y = talla , col="black")  
        return(g) })
      
      
      output$plot_5 = renderPlotly( {
        Perimetro_cefalico = input$cefalico

        if (input$sexo=="niña" ) {
          data = data_craneal_05[data_craneal_05$sexo=="niña",]
        } else{data = data_craneal_05[data_craneal_05$sexo=="niño",]}
        
        g= ggplot(data, aes(x=Meses , y= Perimetro_cefalico, 
                            col = Desviacion)) + geom_line( size = .7 )+
          geom_point( x = mes() , y = Perimetro_cefalico , col="black")  
        return(g) })
      
        
      output$date = renderText({
        entrada = as_date(input$fecha )
        hoy= as_date(Sys.time())
        x = hoy - entrada
        round( time_length(x, unit = "month"))   })
      
# 5 19 años
      output$plot_6 = renderPlotly( {
        talla = input$talla
        
        if (input$sexo=="niña" ) {
          data = data_ee_519[data_ee_519$sexo=="niña",]
        } else{data = data_ee_519[data_ee_519$sexo=="niño",]}
        
        g= ggplot(data, aes(x= Meses, y= Estatura, col = Desviacion)) + 
          geom_line( size = .7 )+
          geom_point( x = mes() , y = talla , col="black")  
        return(g) })
 # 5 a 10 años     
      output$plot_7 = renderPlotly( {
        peso = input$peso
        
        if (input$sexo=="niña" ) {
          data = data_ep_510[data_ep_510$sexo=="niña",]
        } else{data = data_ep_510[data_ep_510$sexo=="niño",]}
        
        g= ggplot(data, aes(x= Meses, y= Peso, col = Desviacion)) + 
          geom_line( size = .7 )+
          geom_point( x = mes() , y = peso , col="black")  
        return(g) })
      
# Tablas
      output$tabla_1 = renderDT({
        talla = input$talla
        data_table <- spread(data_lp_02,key = "Desviacion", value = "Peso")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Longitud==talla & 
                     data_table$sexo==input$sexo,]  })
      
      output$tabla_2 = renderDT({
        talla = input$talla
        data_table <- spread(data_ep_25,key = "Desviacion", value = "Peso")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Estatura==talla & 
                     data_table$sexo==input$sexo,]  })
      
      output$tabla_3 = renderDT({
        semana = input$semana
        data_table <- spread(data_ee_013,key = "Desviacion", 
                             value = "Longitud")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Semanas==semana & 
                     data_table$sexo==input$sexo,]  })
      
      output$tabla_4 = renderDT({
        data_table <- spread(data_ee_05,key = "Desviacion", 
                             value = "Estatura")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Mes==mes() & 
                     data_table$sexo==input$sexo,]  })
      
      output$tabla_5 = renderDT({
        data_table <- spread(data_craneal_05,key = "Desviacion",
                             value = "Perimetro_cefalico")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Meses==mes() &
                     data_table$sexo==input$sexo,]  })
      
      output$tabla_6 = renderDT({
        data_table <- spread(data_ee_519,key = "Desviacion",
                             value = "Estatura")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Meses==mes() &
                     data_table$sexo==input$sexo,]  })
      
      output$tabla_7 = renderDT({
        data_table <- spread(data_ep_510,key = "Desviacion",
                             value = "Peso")
        data_table<- data_table[,c(2,1,9,8,7,6,5,4,3)]
        data_table[data_table$Meses==mes() &
                     data_table$sexo==input$sexo,]  })
      
} )