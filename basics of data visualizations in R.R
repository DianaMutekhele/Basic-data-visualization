
################################################################################
##########Lab 7 Basics of Visualization Code using R ###########################
########## Copyright - HURU School Data Science Dpt. 2021 ######################
################################################################################


install.packages("ggplot2")
install.packages("ggpol")
# Another way of installing from the cutting edge
#devtools::install_github('ggpol')
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpol)

###################### Basics #######################
glimpse(mpg)

### Basics of plotting using pipes
# Data
# ggplot function - call x-y columns
# geom - defines geometric features to be added - here you can set their size and colors
# facet-wrap - you can create multiple plots
# theme - gives theme of plot


#### One plot - Two continous variables #########
mpg %>% 
  #pipes help you manipulate data before plotting
  ggplot(mapping = aes(x = displ, y = hwy)) + 
  geom_point()

##### Plot a third variable using color
mpg %>% 
  ggplot(mapping = aes(x = displ, y = hwy, color=class)) + 
  geom_point()

##### Modifying Labels, Legends and Headings 
plot <- mpg %>% 
  ggplot(mapping = aes(x = displ, y = hwy, color=class)) + 
  geom_point()


plot + labs(title = "Highway Mileage vs Displacement", 
            subtitle = "Analysing the mpg data",
            caption = "Fig. 2: Plot of Highway Mileage vs Displacement)",
            x = "Vehicle Displacement",
            y = " Highway Mileage"
            )

#### Zooming the axis of one plot #########
mpg %>% 
  #pipes help you manipulate data before plotting
  ggplot(mapping = aes(x = displ, y = hwy)) + 
  geom_point()+
  coord_cartesian(xlim = c(3, 5),ylim=c(20,30))


#### One plot - Discrete -  Continous Variables #########

mpg %>% 
  ggplot(mapping = aes(x = manufacturer)) +
  geom_bar()



#### Multiple Plots #########
mpg %>% 
  ggplot(mapping = aes(x = displ, y = hwy)) + 
  geom_point()+ facet_wrap(~ class)


# The boxplot compactly displays the distribution of a continuous variable. It visualises five summary statistics (the median, two hinges and two whiskers), and all "outlying" points individually.

mpg %>% 
  ggplot(mapping = aes(x = class, y = hwy)) +
  geom_boxplot()


# Checking out data distribution

mpg %>% 
  ggplot(mapping = aes(x = class, y = hwy)) +
  geom_boxplot(outlier.shape = NA) + geom_jitter(width = 0.2)

# Can indicate outliers
mpg %>% 
  ggplot(mapping = aes(x = class, y =hwy)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 1)

# Orientation follows the discrete axis
mpg %>% 
  ggplot(mapping = aes(x = hwy, y = class)) +
  geom_boxplot()

# You can add color arguments to the box plot using the verb or hex codes
mpg %>% 
  ggplot(mapping = aes(x = hwy, y = class)) +
  geom_boxplot(fill = "skyblue", colour = "#3366FF")


# Where most of the data is visually - use notches
mpg %>% 
  ggplot(mapping = aes(x = hwy, y = class)) +
  geom_boxplot(notch = T)

# Adding color to notches based on a new variable
mpg %>% 
  ggplot(mapping = aes(x = hwy, y = class)) +
  geom_boxplot(notch = TRUE)

##################### Advanced Libraries buit on top of ggplot2 ########################

# German parliament seats visualization

bt <- data.frame(
  parties = factor(c("CDU", "CSU", "AfD", "FDP", "SPD", 
                     "Linke", "Gruene", "Fraktionslos"),
                   levels = c("CDU", "CSU", "AfD", "FDP", "SPD", 
                              "Linke", "Gruene", "Fraktionslos")),
  seats   = c(250, 46, 92, 80, 13, 69, 67, 2),
  colors  = c("black", "blue", "lightblue", "yellow", 
              "red","purple", "green", "grey"),
  stringsAsFactors = FALSE)

ggplot(bt) + 
  geom_parliament(aes(seats = seats, fill = parties), color = "black") + 
  scale_fill_manual(values = bt$colors, labels = bt$parties) +
  coord_fixed() + 
  theme_void()

# 

