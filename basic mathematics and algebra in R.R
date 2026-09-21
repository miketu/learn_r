require(tidyverse)

# Basic Plot

# Base R
curve(x^2)
par(new=TRUE)
curve(x^3)
points(0.5,0.5,col="purple")
points(0.8,0.8,col="orange")
t
curve(x^4,col="green")

# Ggplot
ggplot(data.frame(x=c(-10,10),y=c(-10,10)),aes(x,y))+
    stat_function(fun= \(x) x^2)+ 
    stat_function(fun= \(x) x^3,color="red")+
    geom_point(aes(x=5,y=-5),size=5)

# Plotting Points 
multiple_points <- ggplot(data.frame(x=c(-10,10),y=c(-10,10)),aes(x,y)) 
multiple_points <- multiple_points + geom_point(aes(x=5,5),color="red")

easier_fill <- rbind( c(0,5),
                      c(1,5),
                      c(3,2) ) |>
                    as.data.frame() |>
                    rename(x=V1,y=V2)

multiple_points <- multiple_points + geom_point(data=easier_fill)
print(multiple_points)
