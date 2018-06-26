## first run only
install.packages('extrafont')
## importing fonts takes a few minutes
extrafont::font_import()

## subsequent uses
library(extrafont)
library(ggplot2)
loadfonts()

ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point() +
  ggtitle("Fuel Efficiency of 32 Cars") +
  xlab("Weight (x1000 lb)") + ylab("Miles per Gallon") +
  theme(text=element_text(size=16,  family="Calibri"))
