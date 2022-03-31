boxPreprocessingUI <- function(id){
  ns <- NS(id)
  box(
    title = "Prétraitement",
    width = NULL,
    collapsible = TRUE,
    status = "primary",
    solidHeader = TRUE,

    h4("Production d'un polygone de couverture d'eau"),
    p("Utilisation du MNT et du fichier WSE d'aléa pour produire un polygone de couverture d'eau en surface."),

    div(class="input-group form-group",
      tags$input(
        id=ns("coverage_status"),
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
        showNotification("Bouton 'create_coverage' actionné.", type="message")
      })
      observeEvent(input$compute_esurf,{
        showNotification("Bouton 'compute_esurf' actionné.", type="message")
      })

      observe({
        cov_status_msg <- reactive({
          if( length(data$mnt_file) < 1 || length(data$hazard_file) < 1){
            "Un MNT et un fichier d'aléa sont requis"
          } else {
            data$cov_msg
          }
        })
        updateTextInput(
          session=session,
          inputId="coverage_status",
          value=cov_status_msg()
        )

        esurf_status_msg <- reactive({
          if( is.null(data$cov) || length(data$building_file) < 1 ){
            "Un fichier de bâtiment et un polygone de couverture sont requis"
          } else {
            data$esurf_msg
          }
        })
        updateTextInput(
          session=session,
          inputId="esurf_status",
          value=esurf_status_msg()
        )
      })

    }
  )
}
