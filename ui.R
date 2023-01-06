# UI

  ui <- fluidPage(theme = shinytheme("cyborg"),
    navbarPage(
      'Gato ou Cachorro',
      tabPanel('Identificar',
               sidebarPanel(
        fileInput("file1", "Faça upload de sua Imagem", accept = "image/*"),
        actionButton('submitbutton', 'Enviar', 
                     class = 'btn btn-primary'),
      ),
      mainPanel(
        h5("Resultado:"),
        verbatimTextOutput('txtout'),
      )
    )
  )
)
  