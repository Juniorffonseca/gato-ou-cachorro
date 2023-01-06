# Server
server <- function(input, output) {
  
  previsaoCatDog <- reactive({
    
    image <- image_load(file$datapath,
                        target_size = c(224, 224))
    x <- image_to_array(test_image)
    x <- array_reshape(x, c(1, dim(x)))
    x <- x/255
    pred <- model %>% predict(x)
    
    retorno <- ifelse(pred[1]>pred[2], 'É um gato', 'É um cachorro')
    
    return(retorno)
    
  })
  
  output$contents <- renderTable({
    file <- input$file1
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "imagem", "Por favor faça upload de uma imagem válida"))
    
    image <- image_load(file$datapath,
                        target_size = c(224, 224))
  })
  
  output$txtout <- renderText({
    if (input$submitbutton>0) { 
      paste(previsaoCatDog())
    }
    else
    {
      'A rede neural está pronta para identificar se é gato ou cachorro.'
    }
  })
  
}

