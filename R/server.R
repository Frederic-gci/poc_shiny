#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import leaflet
#' @noRd
server <- function(input, output, session) {
  addResourcePath("www", system.file("www", package = "shiny4oracle"))
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
    "cover" = NULL,
    "esurf" = NULL
  )

  boxDataServer("box_data", roots=roots, data=data)
  boxPreprocessingServer("box_preprocessing", data=data)
  boxMapServer("box_map", data=data)
  boxSummaryServer("box_summary", data=data)
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
          data$mnt_msg <- paste0("Fichier lu. EPSG initial: ", epsg)
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
  })

  observe({
    ## Loading hazard
    if( length(data$hazard_file) >= 1 ){
      tryCatch(
        {
          obj <- NULL
          obj <- terra::rast(data$hazard_file)
          epsg <- terra::crs(obj, describe=TRUE)$code
          data$hazard <- obj
          data$hazard_msg <- paste0("Fichier lu. EPSG initial: ", epsg)
        },
        error = function(e){
          data$hazard <- NULL
          data$hazard_msg <- paste0("Erreur au chargement du fichier:\n", e)
        }
      )
    } else {
      data$cover <- NULL
      data$hazard <- NULL
      data$hazard_msg <- "Aucune donnée chargée"
    }
  })

  observe({
    ## Loading building
    if( length(data$building_file) >= 1 ){
      tryCatch(
        {
          obj <- NULL
          obj <- terra::vect(data$building_file)
          epsg <- terra::crs(obj, describe=TRUE)$code
          obj <- terra::project(obj, "epsg:4326")
          obj <- sf::st_as_sf(obj)
          data$building <- obj
          data$building_msg <- paste0("Fichier lu. EPSG initial: ", epsg)
        },
        error = function(e){
          data$building <- NULL
          data$building_msg <- paste0("Erreur au chargement du fichier:\n", e)
        }
      )
    } else {
      data$esurf <- NULL
      data$building <- NULL
      data$building_msg <- "Aucune donnée chargée"
    }
  })

  observe({
    if( length(data$building_file >= 1) &&
        length(data$mnt_file >=1 ) &&
        length(data$hazard_file >=1 )){
      shinyjs::js$collapse(NS("box_data", "box_id"))
      shinyjs::js$collapse(NS("box_preprocessing", "box_id"))
    }
  })
  observe({
    if( ! is.null(data$cover) && ! is.null(data$esurf)){
      shinyjs::js$collapse(NS("box_preprocessing", "box_id"))
    }
  })
}
