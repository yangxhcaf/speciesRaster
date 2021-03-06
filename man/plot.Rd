% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.speciesRaster.R
\name{plot.speciesRaster}
\alias{plot.speciesRaster}
\title{Plot speciesRaster}
\usage{
\method{plot}{speciesRaster}(
  x,
  log = FALSE,
  colorRampRange = NULL,
  legend = TRUE,
  col = c("blue", "yellow", "red"),
  basemap = "worldmap",
  box = TRUE,
  axes = TRUE,
  location = "right",
  add = FALSE,
  singleSpCol = gray(0.9),
  ...
)
}
\arguments{
\item{x}{object of class \code{speciesRaster}}

\item{log}{boolean; should the cell values be logged?}

\item{colorRampRange}{numeric vector of min and max value for scaling the color
ramp. Automatically inferred if set to \code{NULL}. This is relevant if multiple
plots are desired on the same scale. See \code{\link{getMultiMapRamp}}. Not intended to leaflet option.}

\item{legend}{boolean; should legend be included?}

\item{col}{either a vector of color names that will be interpolated, or a color ramp
function that takes an integer (see for example \code{\link{colorRampPalette}})}

\item{basemap}{if \code{NULL}, then only the raster is plotted. 
If \code{'worldmap'}, then vector map is plotted.
If \code{'leaflet'}, then the \code{leaflet} package is used.}

\item{box}{boolean; should box be drawn around plot?}

\item{axes}{boolean; should axes be included?}

\item{location}{location of legend, if included. See \code{\link{addRasterLegend}}.}

\item{add}{Logical. Wether to add to current plot}

\item{singleSpCol}{color for single-species cells. See details.}

\item{...}{additional parameters will be passed to the \code{\link{addRasterLegend}} function.}
}
\value{
Nothing is returned.
}
\description{
Plot a speciesRaster object.
}
\details{
If \code{x} is a metric as generated with \code{cellMetrics_speciesRaster} that returns 0 
	for single-species cells, then those cells (that have a value of 0) will be plotted in gray (or any color
	as specified with \code{singleSpCol}).
}
\examples{
plot(tamiasSpRas)

plot(tamiasSpRas, legend=FALSE, axes=FALSE, box=FALSE)
addRasterLegend(tamiasSpRas, location = 'top', ramp=c('blue','yellow','red'))

# Example for how to plot multiple speciesRasters on the same color scale
# for illustration purposes, we will compare weighted endemism to
# phylogenetic weighted endemism
tamiasSpRas <- addPhylo_speciesRaster(tamiasSpRas, tamiasTree)
spRas1 <- cellMetrics_speciesRaster(tamiasSpRas, metric='weightedEndemism')
spRas2 <- cellMetrics_speciesRaster(tamiasSpRas, metric='phyloWeightedEndemism')
# get global min and max values
minmax <- getMultiMapRamp(list(spRas1, spRas2))
par(mfrow = c(1,2))
plot(spRas1, colorRampRange = log(minmax), log = TRUE, location='right')
plot(spRas2, colorRampRange = log(minmax), log = TRUE, location='left')

\donttest{
# use leaflet for plotting
plot(tamiasSpRas, basemap = 'leaflet')
}

}
\author{
Pascal Title
}
