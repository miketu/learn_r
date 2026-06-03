# Introductory Image

library(opencv)
library(imager)
# get webcam size
test <- ocv_picture() |>
        ocv_resize(width=300,height=300) |>
        ocv_write("test.bmp")

raw_image <- load.image("test.bmp")

