#install and load packages
install.packages(c("ggplot2", "tidyr", "dplyr"))
library(ggplot2)
library(tidyr)
library(dplyr)

#create data frame
completeness_data <- data.frame(
  Completeness = c("<50%", "50-74%", "75-89%", "90-99%", "100%"),
  Before = c(10, 20, 57, 9, 4),
  After = c(1, 9, 39, 34, 17)
)

#pivot longer for ggplot
data_long <- completeness_data %>%
  pivot_longer(cols = c("Before", "After"),
               names_to = "Period",
               values_to = "Percentage")

#ensure correct order for Completeness and Period
data_long$Completeness <- factor(data_long$Completeness,
                                 levels = c("<50%", "50-74%", "75-89%", "90-99%", "100%"))
data_long$Period <- factor(data_long$Period, levels = c("Before", "After"))

#side-by-side bar chart with bold labels
ggplot(data_long, aes(x = Completeness, y = Percentage, fill = Period)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_text(aes(label = Percentage),
            position = position_dodge(width = 0.9), 
            vjust = -0.3, 
            size = 4, 
            fontface = "bold") +
  labs(
    title = "Completeness Before and After Intervention",
    x = "Completeness Category",
    y = "Percentage of Records"
  ) +
  scale_fill_manual(values = c("Before" = "#336699",  #muted QMUL Blue
                               "After" = "#66A182")) + #muted Green-Teal
  theme_minimal(base_size = 14) +
   theme(panel.grid = element_blank())

#save plot as PNG
ggsave("bar_chart.png", width = 8, height = 6, dpi = 300)

