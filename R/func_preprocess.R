createCover <- function(wse, dtm){
  showNotification(
    id="start", duration=NULL,
    ui=div(p("Création de couverture commencée"),p(Sys.time()))
  )

  showNotification(
    id = "depth", duration=NULL,
    ui=div(p("Création d'un fichier de profondeur (WSE - MNT)."),p(Sys.time())),
    type="message")
  depth <- wse2depth(dtm=dtm, wse=wse)

  showNotification(
    id="classify", duration=NULL,
    ui=(div(p("Classification du fichier de profondeur."),p(Sys.time()))),
    type="message")
  rcl <- matrix(c(0,Inf, 1), ncol=3, byrow=TRUE)
  classified <- terra::classify(
    depth,
    rcl=rcl,
    include.lowest=FALSE,
    right=TRUE,
    othersNA=TRUE)

  showNotification(
    id="polygonize", duration=NULL,
    ui=div(p("Transformation en polygone."),p(Sys.time())),
    type="message"
  )
  cover <- terra::as.polygons(classified)

  showNotification(
    id="reproject", duration=NULL,
    ui=div(p("Reprojection en 'Web Mercator'"),p(Sys.time())),
    type="message"
  )
  cover <- terra::project(cover, 'epsg:4326')
  cover <- sf::st_as_sf(cover)

  showNotification(
    id="simplify", duration=NULL,
    ui=div(p("Simplification du polygone"), p(Sys.time())),
    type="message"
  )
  cover <- rmapshaper::ms_simplify(cover)

  showNotification(
    id="end", duration=NULL,
    ui=div(p("Création de la couverture terminée"),p(Sys.time()))
  )

  # for(id in c("start", "depth","classify","polygonize", "reproject","simplify", "end")){
  #   removeNotification(id)
  # }
  return(cover)
}

computeEsurf <- function(building, cover){

  showNotification(
    id="start_esurf", duration=NULL,
    ui=div(p("Calcul de l'exposition de surface commencée"),p(Sys.time()))
  )

  building_terra <- terra::vect(building)
  cover_terra <- terra::vect(cover)
  esurf <- terra::is.related(building_terra, cover_terra, relation="intersects")

  showNotification(
    id="end_esurf", duration=NULL,
    ui=div(p("Calcul de l'exposition de surface terminée"),p(Sys.time()))
  )

  return(esurf)
}

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
