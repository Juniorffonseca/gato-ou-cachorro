# Carregando pacotes -----------------------------------------------------------
library(tidyverse)
library(keras)
library(tensorflow)
library(reticulate)

# Training
setwd("C:/Users/anonb/Documents/Projeto2")
label_list <- dir("dados_brutos/")
output_n <- length(label_list)
save(label_list, file="label_list.R")

# Tamanho das imagens
width <- 64
height <- 64
target_size <- c(width, height)
rgb <- 3 #color channels

path <- "dados_brutos/"

train_image_files_path <- file.path(path, "cats", "Training")
valid_image_files_path <- file.path(path, "cats", "Test")

train_data_gen = image_data_generator(
  rescale = 1/255
)

valid_data_gen <- image_data_generator(
  rescale = 1/255
)

train_image_array_gen <- flow_images_from_directory(train_image_files_path, 
                                                    train_data_gen,
                                                    target_size = target_size,
                                                    class_mode = 'categorical',
                                                    classes = '',
                                                    seed = 42)
