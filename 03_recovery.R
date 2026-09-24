# 03_recovery.R
# How long did it take Peru's income per person to recover after the crisis?

library(tidyverse)

latam <- read_csv("data/latam_wdi.csv", show_col_types = FALSE)

peru <- latam %>%
  filter(country == "Peru") %>%
  arrange(year)

# 1. Pre-crisis peak: highest GDP per capita before 1988
pre_crisis <- peru %>%
  filter(year < 1988) %>%
  slice_max(gdp_per_capita, n = 1)

# 2. Bottom: lowest GDP per capita during the crisis (1988-1995)
bottom <- peru %>%
  filter(year >= 1988, year <= 1995) %>%
  slice_min(gdp_per_capita, n = 1)

# 3. Recovery: first year after the bottom that is back above the pre-crisis peak
recovery <- peru %>%
  filter(year > bottom$year, gdp_per_capita >= pre_crisis$gdp_per_capita) %>%
  slice_min(year, n = 1)

# Print the results
print(pre_crisis %>% select(year, gdp_per_capita))
print(bottom %>% select(year, gdp_per_capita))
print(recovery %>% select(year, gdp_per_capita))

drop_pct <- (bottom$gdp_per_capita - pre_crisis$gdp_per_capita) /
  pre_crisis$gdp_per_capita * 100
years_to_recover <- recovery$year - pre_crisis$year

cat("Drop from peak to bottom:", round(drop_pct, 1), "%\n")
cat("Years to recover:", years_to_recover, "\n")

# Chart
key_points <- bind_rows(pre_crisis, bottom, recovery)

p <- ggplot(peru, aes(x = year, y = gdp_per_capita)) +
  geom_line(linewidth = 1, color = "steelblue") +
  geom_hline(yintercept = pre_crisis$gdp_per_capita,
             linetype = "dashed", color = "gray40") +
  geom_point(data = key_points, color = "firebrick", size = 3) +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "How Long Did Peru Take to Recover?",
       subtitle = "GDP per capita (constant US$). Dashed line = pre-crisis peak",
       x = NULL, y = "GDP per capita",
       caption = "Source: World Bank World Development Indicators") +
  theme_minimal()

print(p)
ggsave("figures/peru_recovery.png", p, width = 8, height = 5, dpi = 300)