library("tidyverse")
library("ggplot2")
library("readr")


#National Parks in California
ca <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/ca.csv") 



# Scatter plot
plot_point <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_point()


plot_point2 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_point(mapping = aes(colour = park_name,
                           shape = park_name))


plot_point3 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_point(mapping = aes(colour = park_name,
                           shape = park_name)) +
  scale_shape_manual(values = c(0:5, 9, 11, 14))
  


plot_point4 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_point(mapping = aes(colour = park_name,
                           shape = park_name)) +
  scale_shape_manual(values = c(0:5, 9, 11, 14)) +
  scale_color_manual(values = c('#e41a1c','#377eb8','#4daf4a',
                                '#984ea3','#ff7f00','#ffff33',
                                '#a65628','#f781bf','#999999'))



plot_point5 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_point(mapping = aes(colour = park_name,
                           shape = park_name),
             size = 5,
             alpha = 0.1) +
  scale_shape_manual(values = c(0:5, 9, 11, 14)) +
  scale_color_manual(values = c('#e41a1c','#377eb8','#4daf4a',
                                '#984ea3','#ff7f00','#ffff33',
                                '#a65628','#f781bf','#999999'))





# Line plot
plot_line <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_line(mapping = aes(colour = park_name,
                          linetype= park_name),
            size=1,
            alpha = 0.5) 


plot_line2 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_line(mapping = aes(colour = park_name,
                          linetype= park_name),
            size=1) +
  geom_point(mapping = aes(colour = park_name),
             size=2)


plot_line3 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_line(mapping = aes(colour = park_name,
                          linetype= park_name),
            size=1) +
  geom_point(mapping = aes(colour = park_name),
             size=2) +
  scale_color_brewer(palette="RdPu")


plot_line4 <- ggplot(data = ca %>%
                       filter(park_name=="Yosemite National Park")) +
  geom_line(aes(x=year, y=visitors)) +
  geom_smooth(aes(x=year, y=visitors))






# Area plot
plot_area <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_area(mapping = aes(fill = park_name),
            color = "#000000")



plot_area2 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_area(mapping = aes(fill = park_name),
            color = "#000000",
            linetype = 2,
            size = 0.5,
            alpha = 1) +
  scale_fill_brewer(palette = "YlOrRd")



plot_area3 <- ggplot(data = ca, aes(x=year, y=visitors)) +
  geom_area(mapping = aes(fill = park_name),
            color = "#000000",
            linetype = 2,
            size = 0.5,
            alpha = 1) +
  scale_fill_manual(values = c('#a6cee3','#1f78b4','#b2df8a',
                               '#33a02c','#fb9a99','#e31a1c',
                               '#fdbf6f','#ff7f00','#cab2d6'))





# Bar plot

#2016 Visitation for all Pacific West National Parks
visit_16 <- read_csv("https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/visit_16.csv")


plot_bar <- ggplot(data = visit_16, aes(x=state, y=visitors)) +
  geom_bar(mapping = aes(fill = park_name),
           stat = "identity",
           color = "#000000",
           linetype = 2,
           size = 0.5,
           alpha = 1)



plot_bar2 <- ggplot(data = visit_16, aes(x=state, y=visitors)) +
  geom_bar(mapping = aes(fill = park_name),
           stat = "identity",
           position = "dodge",
           color = "#000000",
           linetype = 2,
           size = 0.5,
           alpha = 1)



plot_bar3<- ggplot(data = visit_16, aes(x=state, y=visitors)) +
  geom_bar(mapping = aes(fill = park_name),
           stat = "identity",
           color = "#000000",
           linetype = 2,
           size = 0.5,
           alpha = 1) +
  scale_fill_manual(values = c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99',
                               '#e31a1c','#fdbf6f','#ff7f00','#cab2d6','#6a3d9a',
                               '#8dd3c7','#ffffb3','#bebada','#fb8072','#80b1d3',
                               '#fdb462','#b3de69'))



plot_bar4<- ggplot(data = visit_16, aes(x=state, y=visitors)) +
  geom_bar(mapping = aes(fill = park_name),
           stat = "identity",
           color = "#000000",
           linetype = 2,
           size = 0.5,
           alpha = 1) +
  coord_flip()



# Bar plot + V line


meanVisitor <- mean(visit_16$visitors)

plot_bar4<- ggplot(data = visit_16, aes(x=state, y=visitors)) +
  geom_bar(mapping = aes(fill = park_name),
           stat = "identity",
           position = "dodge",
           color = "#000000",
           linetype = 2,
           size = 0.5,
           alpha = 1) +
  geom_hline(aes(yintercept = meanVisitor),
             color = "#ff0000",
             size=2,
             linetype=2)




# Save
setwd("D:/Proejct_GitHub/Intro2EnergyModeling_R/Introduction_to_R")

ggsave("./Output/plot_test2.png", plot=plot_bar4, width = 5, height = 5)







