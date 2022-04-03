createCover <- function(wse, dtm){
  showNotification("Création de couverture commencée")

  showNotification("Création d'un fichier de profondeur à partir du MNT et du fichier WSE.", type="message")
  depth <- wse2depth(dtm=dtm, wse=wse)

  showNotification("Création d'un polygone à partir du fichier de profondeur.", type="default")
  rcl <- matrix(c(0,Inf, 1), ncol=3, byrow=TRUE)
  classified <- terra::classify(
    depth,
    rcl=rcl,
    include.lowest=FALSE,
    right=TRUE,
    othersNA=TRUE)
  cover <- terra::as.polygons(classified)
  cover <- terra::project(cover, 'epsg:4326')
  cover <- sf::st_as_sf(cover)

  showNotification("Simplification du polygone", type="default")
  cover <- rmapshaper::ms_simplify(cover)

  showNotification("Création de la couverture terminée", type="message")

  return(cover)
}

# computeEsurf <- function(building, cover){
#   NULL
# }

wse2depth <- function(dtm, wse){
  if( ! all.equal(terra::ext(wse),terra::ext(dtm)) || ! all.equal(terra::res(wse), terra::res(dtm))){

    showNotifcation("Le MNT et le fichier d'aléa doivent être concurrents.", type='error')
  } else {
    concurrent_dtm <- dtm
  }
  depth <- wse - dtm
}

# projectDtmLikeWse <-function(dtm, wse){
#   NULL
# }
