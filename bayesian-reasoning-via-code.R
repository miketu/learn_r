
# Animation to Show Off Coin Flips and Dice Tosses! ------------------------

library(animation)
ani.options(interval = 0.01, nmax = 50)

flip.coin(faces = c("Head",  "Tail"), type = "n", prob = c(0.5, 0.5)) ## "Fair coin"
flip.coin(faces = c("Head",  "Tail"), type = "n", prob = c(0.8, 0.2)) ## "Cheating coin"

flip.coin(faces = c(1,2,3,4,5,6), type = "n", prob = c(1/6, 1/6,1/6,1/6,1/6,1/6),col=c(1,2,3,4,5,6)) ## "Six Sided Dice"

# Individual Case of a coin flip ---------------------------
require(tidyverse)
individual_demo <- sample(c("Heads","Tails"),size=10,replace=TRUE,prob=c(0.5,0.5)) |>
    as.data.frame() |>
    rename(rolls = 1)

ggplot(individual_demo)+
    theme_bw()+
    geom_bar(aes(x=as.factor(rolls)))+ylim(c(0,10))


# Trial of Trials (Discrete Case) ---------------------------------------

# Now let's try to flip 10 times and count a LOT 
fair_coin_values <- data.frame()
unfair_coin_values <- data.frame()

for(x in 1:500)
{
    fair_coin_values <- rbind(fair_coin_values,sum(sample(seq(1:2),size=10,replace=TRUE)==1)) #Fair Dice
    unfair_coin_values <- rbind(unfair_coin_values,sum(sample(seq(1:2),size=10,replace=TRUE,prob=c(0.65,0.35))==1))
    
}

collected_values <- data.frame(fair_coin_values,unfair_coin_values) |>
    rename(faircoin=1,unfaircoin=2)

ggplot(data=collected_values)+geom_histogram(aes(x=faircoin),binwidth=0.5,fill="green",alpha=0.3)+geom_histogram(aes(x=unfaircoin),binwidth=0.5,fill="red",alpha=0.5)

#ggplot(data=collected_values)+geom_density(aes(x=faircoin),fill="green",alpha=0.1)+geom_density(aes(x=unfaircoin),fill="red",alpha=0.1)

# We can approximate the "shape" of this curve with the "Beta Distribution"


# How do we detect a cheating coin? -----------------------------------

require(rethinking)
require(tidyverse)

ggplot(data.frame(mu=c(-50,50)),aes(mu))+stat_function(fun= \(mu) dnorm(mu,8,0.1)) # Plot of Mu
ggplot(data.frame(sigma=c(-1,5)),aes(sigma))+stat_function(fun= \(sigma) dexp(sigma,1)) # Plot of Sigma

priors <- alist(
                y ~ dnorm(mu,sigma),
                 mu ~ dnorm(8,0.1), 
                sigma ~ dnorm(1)
)

unfair_fit <- quap(
            priors,
            data=list(y=collected_values$unfaircoin),
            start=list(mu=5,sigma=1)
            )

summary(unfair_fit)

fair_fit <- quap(
    priors,
    data=list(y=collected_values$faircoin),
    start=list(mu=5,sigma=1)
)

summary(fair_fit)


ggplot(data=collected_values,aes(x=faircoin))+
    geom_histogram(aes(y=..density..),binwidth=0.5,fill="green",alpha=0.3)+ 
      stat_function(color="red",fun = \(faircoin) dnorm(faircoin,summary(fair_fit)$mean[1],summary(fair_fit)$mean[2]))+
      stat_function(color="blue",fun = \(faircoin) dnorm(faircoin,8,0.1))+
      xlim(c(-50,50))
     

# TODO Experimental Work on T-tests

require(NHANES)
require(tidyverse)

weight_data_set <- NHANES |>
    filter(!is.na(PhysActive)) |>
    select(PhysActive,Weight) |>
    drop_na()

ggplot(a,aes(x=PhysActive,y=Weight))+geom_boxplot(outlier.shape=NA)+geom_point()

exercises <- filter(a,PhysActive=="Yes")
slackers <- filter(a,PhysActive=="No")

t.test(exercises$Weight,slackers$Weight) #Traditional Test


require(rethinking)


weight_data_set_bayesian <- weight_data_set |>
    mutate(PhysActive = if_else(PhysActive=="Yes",1,0)) 

ggplot(data.frame(mu=c(-50,50)),aes(mu))+stat_function(fun= \(mu) dnorm(mu,0,5))

priors <- alist(
    Weight ~ dnorm(mu,sigma),
    mu <-  a*PhysActive+b,
    a ~ dnorm(0,1),
    sigma ~ dnorm(0,1),
    b ~ dnorm(80,10)
)

fit <- quap(
    priors,
    data=weight_data_set,
    start=list(a=0,b=80,sigma=0.1,mu=0.1)
)
precis(fit)

plot(y=weight_data_set$Weight,x=weight_data_set$PhysActive)            
