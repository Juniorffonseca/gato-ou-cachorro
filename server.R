# Server
server <- function(input, output) {
  
  image <- reactive({image_load(input$input_image$datapath, target_size = target_size[1:2])})
  
  previsaoCatDog <- reactive({
    
    if(is.null(input$input_image)){return(NULL)}
    x <- image_to_array(image())
    x <- array_reshape(x, c(1, dim(x)))
    x <- x/255
    pred <- model %>% predict(x)
    pred <- data.frame("Animal" = label_list, "Prediction" = t(pred))
    pred <- pred[order(pred$Prediction, decreasing=T),][1:2,]
    pred$Prediction <- sprintf("%.2f %%", 100*pred$Prediction)
    pred

    
  })
  
  output$text <- renderTable({
      (previsaoCatDog())
  })
  
  output$warntext <- renderText({
    req(input$input_image)
    
    if(as.numeric(substr(previsaoCatDog()[1,2],1,4)) >= 30){return(NULL)}
    warntext <- "Não tenho certeza sobre essa imagem."
    warntext
  })
  
  output$output_image <- renderImage({
    req(input$input_image)
    
    outfile <- input$input_image$datapath
    contentType <- input$input_image$type
    list(src = outfile,
         contentType=contentType,
         width = 400)
  }, deleteFile = TRUE)
  
}

