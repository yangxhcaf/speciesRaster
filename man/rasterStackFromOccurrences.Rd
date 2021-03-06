% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rasterStackFromOccurrences.R
\name{rasterStackFromOccurrences}
\alias{rasterStackFromOccurrences}
\title{Occurrences to rasterStack}
\usage{
rasterStackFromOccurrences(
  occ,
  resolution = 50000,
  extent = "auto",
  coordHeaders = c("long", "lat"),
  taxonHeader = "taxon",
  crs = "+init=epsg:4326"
)
}
\arguments{
\item{occ}{a table of species coordinates, a list of species-specific tables of coordinates, 
a spatial coordinates object, or a species-specific list of spatial coordinate objects (sf or sp).
If in table form, each coordinate pair must have an associated species name. If in list form, 
each element of the list must be named with the name of the species.}

\item{resolution}{vertical and horizontal size of raster cell, in coordinate units.}

\item{extent}{if 'auto', then the maximal extent of the coordinates will be used. 
If not auto, can be a SpatialPolygon or sf object, in which case the resulting rasterStack
will be cropped and masked with respect to the polygon, or a spatial coordinates object, 
from which an extent object will be generated, or a numeric vector of length 4 
with minLong, maxLong, minLat, maxLat.}

\item{coordHeaders}{headers for longitude and latitude columns (x and y), only necessary if \code{occ} is a table.}

\item{taxonHeader}{header for taxon labels, only necessary if \code{occ} is a table.}

\item{crs}{coordinate reference system, only necessary if \code{occ} is a table. Otherwise, this
information is pulled from \code{occ}. EPSG:4326 indicates unprojected long/lat.}
}
\value{
an object of class \code{RasterStack} where all rasters contain values of 
either NA or 1.
}
\description{
Takes a set of occurrences and rasterizes the coordinates for each taxon.
}
\details{
If there are spaces in taxon names, those will be replaced with underscores.

	Any SpatialPolygon or SpatialPoints objects are converted to objects of class \code{sf}.
}
\examples{
library(raster)
library(sf)
# example dataset: a list of 24 chipmunk distributions as polygons
# To illustrate usage, we will randomly sample some coordinates from each species polygon
# and generate a couple of alternative input formats

# list of sf spatial objects
spOccList <- lapply(tamiasPolyList, function(x) st_sample(x, size = 10, type= 'random'))
spStack <- rasterStackFromOccurrences(spOccList, resolution = 50000, crs = st_crs(tamiasPolyList[[1]]))

# list of coordinate tables
spOccList2 <- lapply(spOccList, function(x) st_coordinates(x))
spStack <- rasterStackFromOccurrences(spOccList2, resolution = 50000, crs = st_crs(tamiasPolyList[[1]]))

# single table of coordinates
spOccList3 <- spOccList2
for (i in 1:length(spOccList3)) {
	spOccList3[[i]] <- cbind.data.frame(taxon = names(spOccList3)[i], spOccList3[[i]])
	colnames(spOccList3[[i]]) <- c('taxon', 'X', 'Y')
}
spOccList3 <- do.call(rbind, spOccList3)
rownames(spOccList3) <- NULL
spOccList3[, 'taxon'] <- as.character(spOccList3[, 'taxon'])
spStack <- rasterStackFromOccurrences(spOccList3, resolution = 50000, 
	coordHeaders = c('X', 'Y'), crs = st_crs(spOccList[[1]]))

# a single labeled spatial object
spOccList4 <- st_as_sf(spOccList3[, c('taxon', 'X', 'Y')], coords = c('X','Y'), 
	crs = st_crs(spOccList[[1]])$proj4string)
spStack <- rasterStackFromOccurrences(spOccList4, resolution = 50000)
	

}
\author{
Pascal Title
}
