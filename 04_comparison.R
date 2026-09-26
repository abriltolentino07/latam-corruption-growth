library(tidyverse)
latam <- read_csv("data/latam_wdi.csv", show_col_types = FALSE)

# Each country's crisis years
crises <- tribble(
  ~country,   ~crisis_start, ~crisis_end,
  "Peru",     1988, 1995,
  "Mexico",   1994, 1996,
  "Colombia", 1998, 2000,
  "Chile",    1981, 1984,
  "Brazil",   1981, 1984
)

# Peak, bottom and recovery for one country
recovery_stats <- function(country, crisis_start, crisis_end) {
  one <- latam %>% filter(country == !!country) %>% arrange(year)
  peak   <- one %>% filter(year < crisis_start) %>% slice_max(gdp_per_capita, n = 1)
  bottom <- one %>% filter(year >= crisis_start, year <= crisis_end) %>% slice_min(gdp_per_capita, n = 1)
  back   <- one %>% filter(year > bottom$year, gdp_per_capita >= peak$gdp_per_capita) %>% slice_min(year, n = 1)
  tibble(country, peak_year = peak$year, bottom_year = bottom$year,
         recovery_year = back$year,
         drop_pct = round((bottom$gdp_per_capita - peak$gdp_per_capita) / peak$gdp_per_capita * 100, 1),
         years_to_recover = back$year - peak$year)
}

# Run it for all five countries
results <- pmap_dfr(crises, recovery_stats)
print(results)

# Chart
key_points <- results %>%
  select(country, peak_year, bottom_year, recovery_year) %>%
  pivot_longer(-country, values_to = "year") %>%
  inner_join(latam, by = c("country", "year"))

peaks <- key_points %>% filter(name == "peak_year")

p <- ggplot(latam, aes(x = year, y = gdp_per_capita)) +
  geom_line(linewidth = 1, color = "steelblue") +
  geom_hline(data = peaks, aes(yintercept = gdp_per_capita),
             linetype = "dashed", color = "gray40") +
  geom_point(data = key_points, color = "firebrick", size = 2) +
  facet_wrap(~ country, ncol = 2, scales = "free_y") +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "How Long Did Each Country Take to Recover?",
       subtitle = "GDP per capita (constant US$). Dashed line = pre-crisis peak",
       x = NULL, y = "GDP per capita",
       caption = "Source: World Bank World Development Indicators") +
  theme_minimal()

print(p)
ggsave("figures/latam_comparison.png", p, width = 9, height = 8, dpi = 300)