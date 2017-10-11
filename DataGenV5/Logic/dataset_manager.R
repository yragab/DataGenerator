
library(plyr)
library(dplyr)


# Get a dataset if dataframe
getDataset <- function (dataset_id, by = "name") {
  if (by == "name") {
    dataset = tryCatch(
      eval(parse(text = dataset_id)),
      error = function(e) {
        return(NULL)
      }
    )
  } else {
    dataset = read_csv(dataset_id)
  }
  return(dataset)
}

# Function to extract details of a built in dataset 
getDatasetDetails <- function(dataset_id, by = "name") {
  dataset = getDataset(dataset_id, by) 
  if (is.data.frame(dataset)) {
    dataset.dims = dim(dataset)
    dataset.size = format(object.size(dataset), units = "auto")
    dataset.details = as.data.frame(
      append(list(dataset_id), as.list(c(dataset.dims, dataset.size))),
      stringsAsFactors = FALSE)
    names(dataset.details) = c("dataset", "records", "variables", "size")
    return(dataset.details)
  } else {
    return(NULL)
  }
}

# Get details of built in datasets
getBuiltinDatasetDetails <- function() {
  # Pull name, description and package of built in datasets
  built.in.datasets = as.data.frame(data()$results, stringsAsFactors = FALSE) %>%
    select(dataset = Item, description = Title, package = Package) %>%
    filter(package != ".")
  # Extract details of each dataset
  dataset.details = rbind.fill(lapply(built.in.datasets$dataset, getDatasetDetails))
  # Merge saved details and extracted details
  built.in.dataset.details = inner_join(built.in.datasets, dataset.details)
  # Return to caller
  return(built.in.dataset.details)
}

# Get details of previously created datasets
getCreatedDatasets <- function(folder_path) {
  dataset_paths = paste(getDataPath(),
                        list.files(path = getDataPath(), pattern = "*.csv"),
                        sep = "")
  datasets = rbind.fill(lapply(dataset_paths, getDatasetDetails, "path"))
  return(datasets)
}

getVariableName <- function(passed.dataset.name, passed.variable.index, by = "name") {
  dataset = getDataset(passed.dataset.name, by)
  variable.name = names(dataset[passed.variable.index])[1]
  return(variable.name)
}

getVariable <- function(passed.dataset.name, passed.variable.index, by = "name") {
  dataset = getDataset(passed.dataset.name, by)
  variable = dataset[[passed.variable.index]]
  return(variable)
}


