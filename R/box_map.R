boxMapUI <- function(id){
  ns <- NS(id)
  box(
    id = ns("box_id"), ## to manipulate box by shinyjs
    title = "Carte interactive",
    width = NULL,
    collapsible = TRUE,
    status = "primary",
    solidHeader = TRUE,
    leaflet::leafletOutput(ns("map"))
  )
}

boxMapServer <- function(id, data){
  moduleServer(
    id,
    function(input, output, session){
      output$map <- leaflet::renderLeaflet(
        leaflet() %>%
          addTiles() %>%
          setView(lng =-71.46 , lat =47.07 , zoom=6)
      )
      observe({
        if( is.null(data$building)){
          leafletProxy("map") %>%
            clearGroup(group="building")

        } else {
          ext <- terra::ext(data$building)@ptr$vector

          leafletProxy("map") %>%
            clearGroup(group="building") %>%
            addPolygons(
              group="building",
              data=data$building,
              color="black",
              fillColor= "black",
              fillOpacity=0.6,
              weight=1)  %>%
            flyToBounds(lng1=ext[1], lng2=ext[2], lat1=ext[3], lat2=ext[4])
        }
      })

      observe({
        if( is.null(data$cover)){
          leafletProxy("map")%>%
            clearGroup(group="cover")

        } else {
          leafletProxy("map") %>%
            clearGroup("cover") %>%
            addPolygons(
              group="cover",
              data=data$cover,
              weight=1)
        }
      })

      observe({
        if( ! is.null(data$esurf)){
          col <-rep("green", length(data$esurf))
          col[data$esurf] <- "red"
          leafletProxy("map") %>%
            clearGroup("building") %>%
            addPolygons(
              group="building",
              data=data$building,
              color=col,
              fillColor=col,
              fillOpacity=0.6,
              weight=1
            )
        }
      })
    }
  )
}
