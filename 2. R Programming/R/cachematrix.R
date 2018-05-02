## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  # Default value for inverse matrix i
  i <- NULL
  # set the input matrix
  set <- function(y = matrix()){
    x <<- y
    i <<- NULL
  }
  # get input the matrix
  get <- function() x
  # set the inverse matrix
  setinverse <- function(inverse) i <<-inverse
  # get the inverse matrix
  getinverse <- function() i
  # return the list of functions that would be used for cacheSolve function below
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  i <- x$getinverse()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinverse(i)
  i
}