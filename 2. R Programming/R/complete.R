wd <- getwd()
complete <- function(directory, id = 1:332){
  result <- data.frame(matrix(0, nrow=length(id), ncol=2))
  colnames(result) <- c("id", "nobs")
  for (i in seq_along(id)){
    ident <- id[i]
    if (ident<10){
      path <- paste0(wd, "/", directory,"/00", ident,".csv")
      db <- data.frame(read.csv(path))
      result[i, 1] <- ident
      result[i, 2] <- nrow(db[complete.cases(db),])
    }
    else if (9 < ident && ident < 100){
      path <- paste0(wd, "/", directory,"/0", ident,".csv")
      db <- data.frame(read.csv(path))
      result[i, 1] <- ident
      result[i, 2] <- nrow(db[complete.cases(db),])
    }
    else{
      path <- paste0(wd, "/", directory,"/", ident,".csv")
      db <- data.frame(read.csv(path))
      result[i, 1] <- ident
      result[i, 2] <- nrow(db[complete.cases(db),])
    }
    }
result
  }