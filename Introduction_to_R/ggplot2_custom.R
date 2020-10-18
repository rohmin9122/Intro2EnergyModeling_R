library("tidyverse")
library("ggplot2")
library("readr")
library("scales")


# National Parks in California
ca <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/ca.csv") 


# Line plot
plot <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_line(mapping = aes(colour = park_name))



# Theme
plot2 <- plot +
  theme_gray() 



# Label
plot3.1 <- plot +
  # Add labels
  labs(title = "Add a title above the plot",
       subtitle = "Add a subtitle below title",
       caption = "Add a caption below plot",
       x = "X axis label",
       y = "Y axis label")


plot3.2 <- plot +
  # Add labels
  labs(title = "Add a title above the plot",
       subtitle = "Add a subtitle below title",
       caption = "Add a caption below plot",
       x = "X axis label",
       y = "Y axis label") +
  # Change font size
  theme(text = element_text(size = 18),
        axis.text.x = element_text(angle = 45))



# Scales
# you should install "scales" packages to use the functions
plot4.1 <- plot +
  scale_y_continuous( labels = comma)


plot4.2 <- plot +
  scale_y_continuous( labels = label_number(scale = 1 / 1000)) +
  labs(y = "visitors (1000)")



# Legend position
plot5.1 <- plot +
  theme(legend.position = "left")


# Remove legend 
plot5.2 <- plot +
  theme(legend.position = "none")


# Legend title
plot5.3 <- plot +
  # labs(fill ='NEW LEGEND TITLE') if the plot is a kind of bar or area
  labs(color='NEW LEGEND TITLE') 

















