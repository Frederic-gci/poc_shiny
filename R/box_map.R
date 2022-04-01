boxMapUI <- function(id){
  ns <- NS(id)
  box(
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
          setView(lng =-70.79229 , lat =46.22183 , zoom=12)
      )

      observe({
        if( is.null(data$building)){
          leafletProxy("map") %>%
            clearGroup(group="building")

        } else {
          leafletProxy("map") %>%
            clearGroup(group="building") %>%
            addPolygons(
              group="building",
              data=data$building,
              color="black",
              fillColor= "black",
              fillOpacity=0.6,
              weight=1)
        }
      })
    }
  )
}
