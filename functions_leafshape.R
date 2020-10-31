# -------------------------------------------------------------
binImage <- function(path = NULL, image = NULL)
{
   if(is.null(path)) im <- image else im <- readImage(path)
   # k-means
   dat <- imageData(im)
      dat <- data.frame(red = c(dat[,, 1]), green = c(dat[,, 2]), 
         blue = c(dat[,, 3]))
   centro <- rbind(leaf = c(0.4, 0.6, 0.3), back = rep(0.9, 3))
   k <- kmeans(dat, centers = centro)
   # binary image
   clus <- k$cluster
   binclus <- ifelse(clus < 2, 1, 0)
   binary <- array(binclus, dim = dim(im)[1:2])
   # output
   return(binary)
}

# -------------------------------------------------------------
identifyShape <- function(path = NULL, image = NULL, binarized = NULL) 
{
   if(is.null(path)) im <- image else im <- readImage(path)
   if(is.null(binarized)) bin <- binImage(image = im) else bin <- binarized
   bin <- bwlabel(fillHull(bin))
   # borders coordinates
   oc <- ocontour(bin)
   n <- sapply(oc, length)
   o <- which(n > max(n)*0.4)[1]
   coords <- oc[[o]]
   # normalized distances from the centroid
   dis <- sqrt(apply(sweep(coords, 2, colMeans(coords))^2, 1, sum))
   shape <- dis/max(dis)
   #output
   out <- list(borders = coords, shape.vector = shape)
   return(out)
}


