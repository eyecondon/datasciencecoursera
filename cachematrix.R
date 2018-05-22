##  "C:/Users/Don/Desktop/R/Coursera/Class - R Programming/R_Programming_Class_Assignment"
## 
##  Lexical Scoping Assignment for Week 3 in R Programming Class.  

##  LEXICAL scoping (also known as STATIC scoping ) is used with many programming languages that 
##   sets the scope (range of functionality) of a variable so that it may only be called or referenced 
##   from within the block of code in which it is defined. The scope is determined when the code is compiled.

## --------------------------------------------------------------------------

## This first function will set the value of the vector

makeVector <- function(x = numeric()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        list(set = set, get = get,
             setmean = setmean,
             getmean = getmean)
}


## The following function calculates the mean of the special "vector"
## created with the above function. However, it first checks to see if the
## mean has already been calculated. If so, it `get`s the mean from the
## cache and skips the computation. Otherwise, it calculates the mean of
## the data and sets the value of the mean in the cache via the `setmean`
## function.


makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        list(set = set, get = get,
             setmean = setmean,
             getmean = getmean)
}


## Creating a function that caches an inverse matrix

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'

 inv <- x$getInverse()
 if(!is.null(inv)){
         message("getting cached data")
         return(inv)
 }
        data <- x$get()
        inv <- solve(data)
        x$setInverse(inv)
        inv
        
        }
