library(plumber)
plumbobject <- plumb("stockfunction.R")
plumbobject$run(port=8000)

