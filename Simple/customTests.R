
loadDBSSubmission <- function(){
  if (!require("dbssubmission")) install.packages("dbssubmission")
  library(dbssubmission)
}

dbs_on_demand <- function(){
  loadDBSSubmission()
  return (dbssubmission::submit_dbs_on_demand("r_simple"))
}
