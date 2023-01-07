# UI

ui <- dashboardPage(title='Gato ou Cachorro?',
  skin="green",
  
  #(1) Header
  dashboardHeader(title=tags$h1("Gato ou Cachorro?",style="font-size: 120%; font-weight: bold; color: white"),
                  titleWidth = 350,
                  tags$li(class = "dropdown"),
                  dropdownMenu(type = "notifications", icon = icon("question-circle", "fa-1x"), badgeStatus = NULL,
                               headerText="",
                               tags$li(a(href = "https://juniorffonseca.github.io/Portfolio/",
                                         target = "_blank",
                                         tagAppendAttributes(icon("icon-circle"), class = "info"),
                                         "Meu Portfólio"))
                  )),
  
  #(2) Sidebar
  
  dashboardSidebar(
    width=350,
    fileInput("input_image","File" ,accept = c('.jpg','.jpeg')), 
    tags$br()
  ),
  
  #(3) Body
  
  dashboardBody(
    h4("Instruções:"),
    tags$br(),tags$p("1. Pegue uma imagem de um gato ou de um cachorro."),
    tags$p("2. Caso o animal não seja a maior parte da imagem, corte um pouco a imagem."),
    tags$p("3. Faça upload no menu da esquerda."),
    tags$br(),
    
    fluidRow(
      column(h4("Imagem:"),imageOutput("output_image"), width=6),
      column(h4("Resultado:"),tags$br(),textOutput("warntext",), tags$br(),
             tags$p("Nessa imagem provavelmente temos um:"),tableOutput("text"),width=6)
    ),tags$br()
    
  ))
  