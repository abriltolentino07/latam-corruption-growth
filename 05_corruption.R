library(tidyverse)
latam <- read_csv("data/latam_wdi.csv", show_col_types = FALSE)

p <- latam %>%
  filter(year >= 1996, !is.na(corruption)) %>%
  ggplot(aes(x = year, y = corruption)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray40") +
  geom_line(linewidth = 1, color = "steelblue") +
  geom_point(color = "steelblue", size = 1) +
  facet_wrap(~ country, ncol = 2) +
  labs(title = "Control of Corruption in Five Countries, 1996-2024",
       subtitle = "Higher = less corruption. Dashed line = world average (0)",
       x = NULL, y = "Control of Corruption",
       caption = "Source: World Bank Worldwide Governance Indicators") +
  theme_minimal()

print(p)
ggsave("figures/latam_corruption.png", p, width = 9, height = 8, dpi = 300)