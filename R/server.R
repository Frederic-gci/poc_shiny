#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
server <- function(input, output, session) {
  addResourcePath("www", system.file("www", package = "shinyPOC"))
  roots <- c(Home = fs::path_home(), shinyFiles::getVolumes()())

  # Reactive values:
  data <- reactiveValues(
    "mnt_file" = NULL,
    "mnt" = NULL,
    "mnt_msg" = NULL,
    "hazard_file" = NULL,
    "hazard" = NULL,
    "hazard_msg" = NULL,
    "building_file" = NULL,
    "building" = NULL,
    "building_msg" = NULL,
    "cov_msg"=
      "Aucun fichier de couverture généré",
    "cov" = NULL,
    "esurf_msg"=
      "Aucun calcul esurf",
    "esurf" = NULL
  )

  boxDataServer("box_data", roots=roots, data=data)
  boxPreprocessingServer("box_preprocessing", data=data)
  boxMapServer("box_map")
  boxMetricsServer("box_metrics", data=data)

  observe({
    ## Loading MNT
    if( length(data$mnt_file) >= 1 ){
      tryCatch(
        {
          obj <- NULL
          obj <- terra::rast(data$mnt_file)
          epsg <- terra::crs(obj, describe=TRUE)$code
          data$mnt <- obj
          data$mnt_msg <- paste0("Fichier lu. EPSG: ", epsg)
        },
        error = function(e){
          data$mnt <- NULL
          data$mnt_msg <- paste0("Erreur au chargement du fichier:\n", e)
        }
      )
    } else {
      data$mnt <- NULL
      data$mnt_msg <- "Aucune donnée chargée"
    }

    ## Loading hazard
    if( length(data$hazard_file) >= 1 ){
      tryCatch(
        {
          obj <- NULL
          obj <- terra::rast(data$hazard_file)
          epsg <- terra::crs(obj, describe=TRUE)$code
          data$hazard <- obj
          data$hazard_msg <- paste0("Fichier lu. EPSG: ", epsg)
        },
        error = function(e){
          data$hazard <- NULL
          data$hazard_msg <- paste0("Erreur au chargement du fichier:\n", e)
        }
      )
    } else {
      data$hazard <- NULL
      data$hazard_msg <- "Aucune donnée chargée"
    }

    ## Loading building
    if( length(data$building_file) >= 1 ){
      tryCatch(
        {
          obj <- NULL
          obj <- terra::vect(data$building_file)
          epsg <- terra::crs(obj, describe=TRUE)$code
          data$building <- obj
          data$building_msg <- paste0("Fichier lu. EPSG: ", epsg)
        },
        error = function(e){
          data$building <- NULL
          data$building_msg <- paste0("Erreur au chargement du fichier:\n", e)
        }
      )
    } else {
      data$building <- NULL
      data$building_msg <- "Aucune donnée chargée"
    }

  })
}
