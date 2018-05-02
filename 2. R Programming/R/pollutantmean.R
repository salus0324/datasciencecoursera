wd <- getwd()
pollutantmean <- function(directory, pollutant, id=1:332){
  vec <- vector()
  for (i in id){
    if (i<10){
      path <- paste0(wd, "/", directory,"/00", i,".csv")
      db <- data.frame(read.csv(path))
      na <- !is.na(db[pollutant])
      vec <- c(vec, (db[pollutant])[na])
    }
    else if (9 < i && i < 100){
      path <- paste0(wd, "/", directory,"/0", i,".csv")
      db <- data.frame(read.csv(path))
      na <- !is.na(db[pollutant])
      vec <- c(vec, (db[pollutant])[na])
    }
    else{
      path <- paste0(wd, "/", directory,"/", i,".csv")
      db <- data.frame(read.csv(path))
      na <- !is.na(db[pollutant])
      vec <- c(vec, (db[pollutant])[na])
    }
  }
  mean(vec)
}
