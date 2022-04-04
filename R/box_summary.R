boxSummaryUI <- function(id){
  ns <- NS(id)
  box(
    id = ns("box_id"), ## to manipulate box by shinyjs
    title = "Sommaire",
    width = NULL,
    collapsible = TRUE,
    status = "info",
    solidHeader = TRUE,

    h4("Fichiers des données entrantes"),
    verbatimTextOutput(outputId = ns("files")),

    h4("Données entrantes chargées"),
    verbatimTextOutput(outputId = ns("data_objects")),

    h4("Données intermédiaires"),
    verbatimTextOutput(outputId = ns("intermediary"))
  )
}

boxSummaryServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){

      output$files = renderText({
        msg <- "Aucun fichier"
        paste0(
          "Fichier MNT = ", if(length(data$mnt_file)<1) msg else data$mnt_file,
          "\nFichier d'aléa = ",
          if(length(data$hazard_file)<1) msg else data$hazard_file,
          "\nFichier de bâtiments = ",
          if(length(data$building_file)<1) msg else data$building_file
        )
      })

      output$data_objects = renderText(
        paste0(
          "MNT = ", data$mnt_msg,
          "\nAléa = ", data$hazard_msg,
          "\nBâtiment = ", data$building_msg
        )
      )

      output$intermediary = renderText({
        msg_unavailable <- "NA"
        msg_available   <- "Données disponibles"
        paste0(
          "Données de couverture: ",
          if(is.null(data$cover)) msg_unavailable else msg_available,
          "\nDonnées esurf: ",
          if(is.null(data$esurf)) msg_unavailable else msg_available
        )
      })
    }
  )
}
