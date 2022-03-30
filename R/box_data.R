boxDataUI <- function(id){
  ns <- NS(id)
  box(
    title = "Données",
    width = NULL,
    collapsible = TRUE,
    status = "primary",
    solidHeader = TRUE,

    h4("Modèle numérique de terrain"),
    p("Chargez un modèle numérique de terrain en format geotiff en projection EPSG:32198 (NAD83 / Québec Lambert)."),
    fileChooserWithResetUI(id=ns("mnt")),

    h4("Données d'aléa"),
    p("Chargez un fichier d'élévation d'eau en format geotiff et projection EPSG:32198 (NAD83 / Québec Lambert)."),
    fileChooserWithResetUI( id=ns("hazard") ),

    h4("Bâtiments"),
    p("Chargez un fichier de bâtiments en format gpkg et projection EPSG:32198 (NAD83 / Québec Lambert)."),
    fileChooserWithResetUI( id=ns("building") ),

    tags$hr(),
    actionButton(
      inputId = ns("reset"),
      label = "Réinitialiser",
      class= "pull-right"
    )
  )
}

boxDataServer <- function(id, roots, data){
  moduleServer(
    id,
    function(input, output, session){
      reset <- reactiveVal(0)

      mnt_file_input <- fileChooserWithResetServer(
        id="mnt",
        label="Fichier MNT",
        title="Choisir un modèle numérique de terrain",
        multiple=FALSE,
        filetypes = c("tif", "tiff", "geotiff", "TIFF", "TIF"),
        roots = roots,
        reset = reset
      )

      hazard_file_input <- fileChooserWithResetServer(
        id="hazard",
        label="Fichier d'aléa",
        title="Choisir un fichier d'élévation d'eau",
        multiple=FALSE,
        filetypes = c("tif", "tiff", "geotiff", "TIFF", "TIF"),
        roots = roots,
        reset = reset
      )

      building_file_input <- fileChooserWithResetServer(
        id="building",
        label="Fichier de bâtiments",
        title="Choisir un fichier de bâtiments",
        multiple=FALSE,
        filetypes = c("gpkg"),
        roots = roots,
        reset = reset
      )

      observe({
        data$mnt_file = shinyFiles::parseFilePaths(roots, mnt_file_input())$datapath
        data$hazard_file = shinyFiles::parseFilePaths(roots, hazard_file_input())$datapath
        data$building_file = shinyFiles::parseFilePaths(roots, building_file_input())$datapath
      })

      observeEvent(input$reset, {
        reset(reset() + 1)
      })

    }
  )
}
