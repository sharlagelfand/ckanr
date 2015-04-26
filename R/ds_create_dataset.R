#' Datastore - create a dataset
#'
#' @export
#' @importFrom httr upload_file add_headers
#'
#' @param package_id (character) Package ID to add dataset to (required)
#' @param name (character) Name of the new dataset (required)
#' @param path (character) Path of the file to add (required)
#' @param key API key (required)
#' @template args
#' @references
#' \url{http://docs.ckan.org/en/latest/api/index.html#ckan.logic.action.create.resource_create}
#' @examples \donttest{
#' ds_create_dataset(package_id='testingagain', name="mydata",
#'                    path="~/github/sac/theplantlist/Actinidiaceae.csv",
#'                    key=getOption('ckan_demo_key'))
#' }

ds_create_dataset <- function(package_id, name, path, key,
                              url = 'http://demo.ckan.org', as='list', ...) {
  path <- path.expand(path)
  ext <- strsplit(basename(path), "\\.")[[1]]
  ext <- ext[length(ext)]
  body <- list(package_id = package_id, name = name, format = ext, url = 'upload', upload = upload_file(path))
  res <- POST(file.path(url, 'api/action/resource_create'), add_headers(Authorization = key), body = body, ...)
  stop_for_status(res)
  res <- content(res, "text")
  switch(as, json = res, list = jsl(res), table = jsd(res))
}

#' Add a new table to a datastore
#'
#' BEWARE: This function still doesn't quite work yet.
#'
#' @export
#' @param resource_id (string) Resource id that the data is going to be stored against.
#' @param force (logical) Set to \code{TRUE} to edit a read-only resource. Default: FALSE
#' @param resource (dictionary) Resource dictionary that is passed to resource_create().
#' Use instead of \code{resource_id} (optional)
#' @param aliases (character) Names for read only aliases of the resource. (optional)
#' @param fields (list) Fields/columns and their extra metadata. (optional)
#' @param records (list) The data, eg: \code{[{"dob": "2005", "some_stuff": ["a", "b"]}]} (optional)
#' @param primary_key (character) Fields that represent a unique key (optional)
#' @param indexes (character) Indexes on table (optional)
#' @param key API key (required)
#' @template args
#' @references \url{http://bit.ly/1G9cnBl}
#' @examples \donttest{
#' ds_create(resource_id="iris2", records=iris, key=getOption('ckan_demo_key'))
#' }

ds_create <- function(resource_id = NULL, resource = NULL, force = FALSE, aliases = NULL,
  fields = NULL, records = NULL, primary_key = NULL, indexes = NULL,
  key, url = 'http://demo.ckan.org', as='list', ...) {
  body <- cc(list(resource_id = resource_id, resource = resource, force = force, aliases = aliases,
               fields = fields, records = convert(records), primary_key = primary_key, indexes = indexes))
  res <- POST(file.path(url, 'api/action/datastore_create'), add_headers(Authorization = key), body = body, ...)
  stop_for_status(res)
  res <- content(res, "text")
  switch(as, json = res, list = jsl(res), table = jsd(res))
}

convert <- function(x){
  if (!is.null(x)) {
    jsonlite::toJSON(x)
  } else {
    NULL
  }
}