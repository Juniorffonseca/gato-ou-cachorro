# Server
server <- function(input, output) {
  output$contents <- renderTable({
    file <- input$file1
    ext <- tools::file_ext(file$datapath)
    
    req(file)
    validate(need(ext == "imagem", "Por favor faça upload de uma imagem válida"))
    
    image <- image_load(file$datapath,
                        target_size = c(224, 224))
  })
  
  