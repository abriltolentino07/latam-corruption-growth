# 01_get_data.R
# Downloads economic data for 5 Latin American countries from the World Bank

library(WDI)
library(tidyverse)

# Countries: Peru, Mexico, Colombia, Chile, Brazil
countries <- c("PE", "MX", "CO", "CL", "BR")

# Indicators we want (name = World Bank code)
indicators <- c(
  inflation      = "FP.CPI.TOTL.ZG",    # Inflation, consumer prices (annual %)
  gdp_growth     = "NY.GDP.MKTP.KD.ZG", # GDP growth (annual %)
  gdp_per_capita = "NY.GDP.PCAP.KD",    # GDP per capita (constant US$)
  corruption     = "GOV_WGI_CC.EST"     # Control of Corruption (-2.5 to +2.5)
)

# Download data from 1980 to 2024
latam <- WDI(country = countries,
             indicator = indicators,
             start = 1980,
             end = 2024)

# Save a copy in a "data" folder
dir.create("data", showWarnings = FALSE)
write_csv(latam, "data/latam_wdi.csv")

# Quick check: Peru's inflation from 1985 to 1995
latam %>%
  filter(country == "Peru", year >= 1985, year <= 1995) %>%
  select(year, inflation) %>%
  arrange(year)
