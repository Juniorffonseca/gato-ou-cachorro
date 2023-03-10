# Carregando pacotes -----------------------------------------------------------
library(tidyverse)
library(keras)
library(tensorflow)
library(reticulate)

# Training
setwd("C:/Users/anonb/Documents/Cats_Recognition")
label_list <- dir("dados_brutos/")
output_n <- length(label_list)
save(label_list, file="label_list.R")

# Tamanho das imagens
width <- 224
height <- 224
target_size <- c(width, height)
rgb <- 3 #color channels

path_train <- "dados_brutos/"
train_data_gen <- image_data_generator(rescale = 1/255, 
                                       validation_split = .2)

train_images <- flow_images_from_directory(path_train,
                                           train_data_gen,
                                           subset = 'training',
                                           target_size = target_size,
                                           class_mode = "categorical",
                                           shuffle=F,
                                           seed = 2021)

validation_images <- flow_images_from_directory(path_train,
                                                train_data_gen, 
                                                subset = 'validation',
                                                target_size = target_size,
                                                class_mode = "categorical",
                                                seed = 2021)


mod_base <- application_xception(weights = 'imagenet', 
                                 include_top = FALSE, input_shape = c(224, 224, 3))
freeze_weights(mod_base) 

model_function <- function(learning_rate = 0.001, 
                           dropoutrate=0.2, n_dense=1024){
  
  k_clear_session()
  
  model <- keras_model_sequential() %>%
    mod_base %>% 
    layer_global_average_pooling_2d() %>% 
    layer_dense(units = n_dense) %>%
    layer_activation("relu") %>%
    layer_dropout(dropoutrate) %>%
    layer_dense(units=output_n, activation="softmax")
  
  model %>% compile(
    loss = "categorical_crossentropy",
    optimizer = optimizer_adam(learning_rate = 0.001),
    metrics = "accuracy"
  )
  
  return(model)
  
}

model <- model_function()
model

batch_size <- 32
epochs <- 3
hist <- model %>% fit(
  train_images,
  steps_per_epoch = train_images$n %/% batch_size, 
  epochs = epochs, 
  validation_data = validation_images,
  validation_steps = validation_images$n %/% batch_size,
  verbose = 2
)

model %>% save_model_tf("cat_dog_mod")

model %>% evaluate(validation_images)


save(model, file = 'model.rda')

# Testando em imagens aleat??rias

test_image <- image_load("teste.jpeg",
                         target_size = target_size)
test_image2 <- image_load('teste2.jpeg',
                           target_size = target_size)
x <- image_to_array(test_image)
x <- array_reshape(x, c(1, dim(x)))
x <- x/255
y <- image_to_array(test_image2)
y <- array_reshape(y, c(1, dim(y)))
y <- y/255
pred <- model %>% predict(x)
pred <- model %>% predict(y)
