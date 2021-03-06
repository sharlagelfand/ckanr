% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/package_delete.R
\name{package_delete}
\alias{package_delete}
\title{Delete a package}
\usage{
package_delete(id, url = get_default_url(), key = get_default_key(),
  ...)
}
\arguments{
\item{id}{(character) The id of the package. Required.}

\item{url}{Base url to use. Default: \url{http://data.techno-science.ca}. See
also \code{\link{ckanr_setup}} and \code{\link{get_default_url}}.}

\item{key}{A privileged CKAN API key, Default: your key set with \code{\link{ckanr_setup}}}

\item{...}{Curl args passed on to \code{\link[httr]{POST}} (optional)}
}
\description{
Delete a package
}
\examples{
\dontrun{
# Setup
ckanr_setup(url = "https://demo.ckan.org", key = getOption("ckan_demo_key"))

# create a package
(res <- package_create("lions-bears-tigers"))

# show the package
package_show(res)

# delete the package
package_delete(res)
}
}
