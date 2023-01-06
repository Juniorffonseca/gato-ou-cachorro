# Carregando pacotes -----------------------------------------------------------
library(tidyverse)
library(keras)
library(tensorflow)
library(reticulate)

# Sources ----------------------------------------------------------------------
source('ui.R')
source('server.R')

# Rede Neural ------------------------------------------------------------------
load(file = 'model.rda')

#Criando o app -----------------------------------------------------------------
shinyApp(ui = ui, server = server)