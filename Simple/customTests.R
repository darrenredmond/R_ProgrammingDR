# Get the swirl state
getState <- function() {
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

# Get the value which a user either entered directly or was computed
# by the command he or she entered.
getVal <- function() {
  getState()$val
}

# Get the last expression which the user entered at the R console.
getExpr <- function() {
  getState()$expr
}

loadDigest <- function() {
  if (!require("digest")) install.packages("digest")
  library(digest)
}

loadGoogle <- function() {
  if (!require("googleformr")) install.packages("googleformr")
  library(googleformr)
}

loadFailMessage <- function() {
  message("Grade submission failed.")
  message("Press ESC if you want to exit this lesson and you")
  message("want to try to submit your grade at a later time.")
}

loadPassMessage <- function() {
  message("Grade submission succeeded!")
}

dbs_on_demand <- function() {
  loadDigest()
  loadGoogle()
  selection <- getState()$val
  if (selection == "Yes") {
    course <- "r_simple"
    email <- readline("What is your email address? ")
    student_number <- readline("What is your student number? ")
    hash <- digest(paste(course, student_number), "md5", serialize = FALSE)
    form_id <- '1WDH2A0YpI7ghnetd4f_H9cdpGo9frH4X5KOfXo850tw'
    post_answers <- googleformr::gformr(form_id)
    post_this <- c(email, student_number, hash, course)
    status_code <- httr::status_code(post_answers(post_content=post_this))
    if (status_code >= 200 && status_code < 300) {
      loadPassMessage()
    } else {
      loadFailMessage()
      return(FALSE)
    }
  }
  TRUE
}
