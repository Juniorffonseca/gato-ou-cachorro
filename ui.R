# UI

  ui <- fluidPage(theme = shinytheme("cyborg"),
    navbarPage(
      'Gato ou Cachorro',
      tabPanel('Identificar',
               sidebarPanel(verbatimTextOutput('textout'),
        fileInput("file1", "Faça upload de sua Imagem", accept = c('.jpg', '.jpeg')),
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
  