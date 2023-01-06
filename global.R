# Carregando pacotes -----------------------------------------------------------
library(shiny)
library(shinydashboard)
library(rsconnect)
library(keras)
library(tensorflow)
library(tidyverse)

# Sources ----------------------------------------------------------------------
source('ui.R')
source('server.R')

# Rede Neural ------------------------------------------------------------------
model <- load_model_tf('cat_dog_mod')
label_list <- c('cats', 'dogs')
target_size <- c(224,224,3)
options(scipen=999)

#Criando o app -----------------------------------------------------------------
shinyApp(ui = ui, server = server)