library("tidyverse")
library("ggplot2")



# Faceting
plot_point <- ggplot(data=mpg, aes(cty, hwy)) +
  geom_point()



plot1 <- plot_point +
  facet_wrap(vars(class),
             nrow=2,
             # fixed, free_y, free_x, free
             scales = "fixed")



plot2 <- plot_point +
  facet_wrap(vars(class),
             ncol=2,
             # fixed, free_y, free_x, free
             scales = "free")



plot3 <- plot_point +
  facet_grid(rows = vars(year),
             cols = vars(class),
             # fixed, free_y, free_x, free
             scales = "free")
