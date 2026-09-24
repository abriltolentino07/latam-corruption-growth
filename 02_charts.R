# 02_charts.R
# Chart of Peru's inflation, 1980-2000

library(tidyverse)

# Load the data we saved in 01_get_data.R
latam <- read_csv("data/latam_wdi.csv", show_col_types = FALSE)
# Keep only Peru, 1980-2000
peru <- latam %>%
  filter(country == "Peru", year >= 1980, year <= 2000)

# Build the chart
p <- ggplot(peru, aes(x = year, y = inflation)) +
  geom_line(linewidth = 1, color = "firebrick") +
  geom_point(color = "firebrick") +
  # Dashed lines marking key events
  geom_vline(xintercept = c(1985, 1990), linetype = "dashed", color = "gray40") +
  annotate("text", x = 1985, y = 6000, label = "García takes office\n(July 1985)",
           hjust = -0.05, size = 3.5) +
  annotate("text", x = 1990, y = 6000, label = "Fujishock\n(Aug 1990)",
           hjust = -0.2, size = 3.5) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Peru's Hyperinflation, 1980-2000",
       subtitle = "Annual inflation, consumer prices (%)",
       x = NULL, y = "Inflation (%)",
       caption = "Source: World Bank World Development Indicators") +
  theme_minimal()

# Show it
print(p)

# Save it as an image for GitHub
dir.create("figures", showWarnings = FALSE)
ggsave("figures/peru_inflation_1980_2000.png", p, width = 8, height = 5, dpi = 300)