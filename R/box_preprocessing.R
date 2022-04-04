boxPreprocessingUI <- function(id){
  ns <- NS(id)
  box(
    title = "Prétraitement",
    width = NULL,
    collapsible = TRUE,
    collapsed = TRUE,
    status = "primary",
    solidHeader = TRUE,

    h4("Production d'un polygone de couverture d'eau"),
    p("Utilisation du MNT et du fichier WSE d'aléa pour produire un polygone de couverture d'eau en surface."),

    div(class="input-group form-group",
      tags$input(
        id=ns("cover_status"),
        type="text", readonly="readonly",
        placeholder="Requiert un MNT et un fichier d'aléa",
        class="form-control"
      ),
      span(class="input-group-btn",
        actionButton(inputId = ns("create_coverage"), "Créer la couverture")
      )
    ),

    h4("Calcul de l'intersection entre le bati et la couverture d'eau"),
    p("Utilisation du fichier de bâtiment et du fichier de couverture d'eau pour identifier les bâtiments touchés par l'eau de surface (Esurf)."),

    div(class="input-group form-group",
      tags$input(
        id=ns("esurf_status"),
        type="text", readonly="readonly",
        placeholder="Requiert un fichier de bâtiment et un polygone de couverture.",
        class="form-control"
      ),
      span(class="input-group-btn",
        actionButton(inputId = ns("compute_esurf"), "Calculer ESurf")
      )
    ),

  )
}

boxPreprocessingServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){

      observeEvent(input$create_coverage,{
        if( is.null(data$mnt) || is.null(data$hazard)){
          showNotification("Un MNT et un fichier d'élévation d'eau sont nécessaire pour produire la couverture d'eau.", type="error")
        } else {
          cover <- createCover(wse=data$hazard, dtm=data$mnt)
          data$cover <- cover
        }
      })
      observeEvent(input$compute_esurf,{
        showNotification("Bouton 'compute_esurf' actionné.", type="message")
      })

      observe({
        if( ! is.null(data$cover)){
          msg <- "Couverture générée!"
        } else if( length(data$mnt_file) < 1 || length(data$hazard_file) < 1){
          msg <- "Un MNT et un fichier d'aléa sont requis"
        } else {
          msg <- "Aucun fichier de couverture généré"
        }

        updateTextInput(
          session=session,
          inputId="cover_status",
          value=msg
        )
      })

      observe({
        if( ! is.null(data$esurf)){
          msg <- "Esurf calculé"
        } else if( is.null(data$cover) || is.null(data$building) ){
          msg <-"Des données de couverture et de bâtiments sont requises"
        } else {
          msg <- "Aucune donnée calculée"
        }

        updateTextInput(
          session=session,
          inputId="esurf_status",
          value=msg
        )
      })
    }
  )
}
