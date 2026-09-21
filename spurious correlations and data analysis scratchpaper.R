require(NHANES)
require(tidyverse)

dataset <- NHANES |>
    filter(!is.na(BMI) & !is.na(Testosterone))


ggplot(dataset,aes(x=dataset$MaritalStatus,y=Testosterone))+geom_boxplot()+facet_grid(.~dataset$AgeDecade)

