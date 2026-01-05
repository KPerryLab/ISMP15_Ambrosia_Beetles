options(timeout = 600)
install.packages("magick")
install.packages("sf")
library(magick)
library(sf)
image <- image_read("C:/Users/jessi/OneDrive/Documents/FLIR/FLIR Thermal Studio Import/FullSet-Thermal/Am 2-3.jpg")
plot(image) # Optional: display the image

# Assuming 'image' is loaded using magick
image_info <- image_info(image)
width <- image_info$width
height <- image_info$height

poly_coords <- locator(type = "p", pch = 16, col = "red")

# Format coordinates for st_polygon()
# Ensure the first and last points are the same to close the polygon
x_coords <- c(poly_coords$x, poly_coords$x[1])
y_coords <- c(poly_coords$y, poly_coords$y[1])
coords_matrix <- cbind(x_coords, y_coords)

# Create the sfg (simple feature geometry) object
polygon_sfg <- st_polygon(list(coords_matrix))

# Create the sfc (simple feature collection) object
# Because this is an image plot without a real-world CRS, you can use NA
polygon_sfc <- st_sfc(polygon_sfg)

# Create the final sf object
my_sf_polygon <- st_sf(data.frame(id = 1, geometry = polygon_sfc))

#select random points
random_points <- st_sample(my_sf_polygon, size = 15)

#plot random points over image
plot(image) 
plot(my_sf_polygon, col = NA, main = "Random Points in Polygon", add=T)
plot(random_points, col = "red", add = TRUE, pch = 20)

