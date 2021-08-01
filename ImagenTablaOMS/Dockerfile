FROM rocker/tidyverse:latest

WORKDIR /app

COPY . /app

EXPOSE 5024

RUN install2.r --error \
    shiny \
    shinydashboard  \
    lubridate  \
    DT  \
    dashboardthemes  \
    plotly

CMD ["Rscript", "start.R"]