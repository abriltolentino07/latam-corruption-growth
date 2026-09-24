# latam-corruption-growth
Analysis of Peru's 1980s hyperinflation, 1990s recovery, and the role of corruption, using World Bank data in R.

## Question
How did Peru go from hyperinflation in the late 1980s to one of Latin America's
most stable economies, and how does corruption relate to economic growth across
the region?

## Data
- World Bank World Development Indicators (inflation, GDP growth, GDP per capita)
- World Bank Worldwide Governance Indicators (Control of Corruption)

## Tools
R

## The Hyperinflatio
Peru's inflation peaked at **7,482% in 1990**, meaning prices rose about
76x in a single year (roughly 43% per month). After the August 1990
"Fujishock" stabilization program, inflation fell to 410% in 1991 and
about 11% by 1995.

![Peru's Hyperinflation, 1980-2000](figures/peru_inflation_1980_2000.png)

## How Long Did Recovery Take?
Peru's GDP per capita (inflation-adjusted) peaked at $3,910 in 1981, fell
32.5% to $2,640 by 1992, and didn't return to its pre-crisis level until
2006, **25 years later**. Notably, the decline began in the early 1980s,
before the hyperinflation, which suggests the region-wide debt crisis
also played a role.

![Peru GDP per capita recovery](figures/peru_recovery.png)

## Status
In progress: next step is comparing Peru with Mexico, Colombia, Chile, and Brazil.
