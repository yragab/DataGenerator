
library(rjson)

json.sample = "{
  \"Uniform\" : {
    \"name\": \"Uniform\", 
    \"fun\" : \"runif\", 
    \"params\" : [
      {\"label\" : \"Min\", \"id\" : \"first_distribution_parameter\",  \"pname\" : \"min\", \"initial_value\" : \"0\"},
      {\"label\" : \"Max\", \"id\" : \"second_distribution_parameter\", \"pname\" : \"max\", \"initial_value\" : \"1\"}
    ]
  },
  \"Gaussian\" : {
    \"name\": \"Gaussian\", 
    \"fun\" : \"rnorm\", 
    \"params\" : [
      {\"label\" : \"Mean\", \"id\" : \"first_distribution_parameter\", \"pname\" : \"mean\", \"initial_value\" : \"0\"},
      {\"label\" : \"Standard deviation\", \"id\" : \"second_distribution_parameter\", \"pname\" : \"sd\", \"initial_value\" : \"1\"}
    ]
  },
  \"Poisson\" : {
    \"name\": \"Poisson\", 
    \"fun\" : \"rpois\", 
    \"params\" : [
      {\"label\" : \"Lambda\", \"id\" : \"first_distribution_parameter\", \"pname\" : \"lambda\", \"initial_value\" : \"3\"}
    ]
  },
  \"Student T\" : {
    \"name\": \"Student T\", 
    \"fun\" : \"rt\", 
    \"params\" : [
      {\"label\" : \"Degrees of Freedom\", \"id\" : \"first_distribution_parameter\", \"pname\" : \"df\", \"initial_value\" : \"5\"}
    ]
  },
  \"Log Normal\" : {
    \"name\": \"Log Normal\", 
    \"fun\" : \"rlnorm\", 
    \"params\" : [
      {\"label\" : \"Meanlog\", \"id\" : \"first_distribution_parameter\", \"pname\" : \"meanlog\", \"initial_value\" : \"0\"},
      {\"label\" : \"SDlog\", \"id\" : \"second_distribution_parameter\", \"pname\" : \"sdlog\", \"initial_value\" : \"1\"}
    ]
  },
  \"Binomial\" : {
    \"name\": \"Binomial\", 
    \"fun\" : \"rbinom\", 
    \"params\" : [
      {\"label\" : \"Number of Trials\", \"id\" : \"first_distribution_parameter\", \"pname\" : \"size\", \"initial_value\" : \"3\"},
      {\"label\" : \"Probability of success on each trial\", \"id\" : \"second_distribution_parameter\", \"pname\" : \"prob\", \"initial_value\" : \"0.5\"}
    ]
  }
}"

config = fromJSON(json.sample)

getDistributions <- function() {
  distributions = lapply(config, function(x) {x$name})
  return(distributions)
}

getDistributionParameters <- function(passed.distribution) {
  distribution_parameters = config[[passed.distribution]]$params
  return(distribution_parameters)
}

getDistributionFunction <- function(passed.distribution) {
  distribution_function = config[[passed.distribution]]$fun
  return(distribution_function)
}

getDistributionParamterIds <- function(passed.distribution) {
  distribution_parameters = getDistributionParameters(passed.distribution)
  distribution_parameter_ids = sapply(distribution_parameters, function(x) {x$id})
  return(distribution_parameter_ids)
}








