# UI

ui <- dashboardPage(
  skin="green",
  
  #(1) Header
  dashboardHeader(title=tags$h1("Bird-App",style="font-size: 120%; font-weight: bold; color: white"),
                  titleWidth = 350,
                  tags$li(class = "dropdown"),
                  dropdownMenu(type = "notifications", icon = icon("question-circle", "fa-1x"), badgeStatus = NULL,
                               headerText="",
                               tags$li(a(href = "https://forloopsandpiepkicks.wordpress.com",
                                         target = "_blank",
                                         tagAppendAttributes(icon("icon-circle"), class = "info"),
                                         "Created by Junin"))
                  )),
  
  #(2) Sidebar
  
  dashboardSidebar(
    width=350,
    fileInput("input_image","File" ,accept = c('.jpg','.jpeg')), 
    tags$br(),
    tags$p("Upload the image here.")
  ),
  
  #(3) Body
  
  dashboardBody(
    h4("Instruction:"),
    tags$br(),tags$p("1. Take a picture of a bird."),
    tags$p("2. Crop image so that bird fills out most of the image."),
    tags$p("3. Upload image with menu on the left."),
    tags$br(),
    
    fluidRow(
      column(h4("Image:"),imageOutput("output_image"), width=6),
      column(h4("Result:"),tags$br(),textOutput("warntext",), tags$br(),
             tags$p("This animal is probably a:"),tableOutput("text"),width=6)
    ),tags$br()
    
  ))
  