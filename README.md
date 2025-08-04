# Marketing Analytics Project: Conjoint Analysis and PCA

## Overview
Conducted conjoint analysis on 18 product profiles and PCA on 32 product models to optimize a new circular product design. Used R for part-worth utilities (e.g., Environmental Friendliness utility 2.133) and PCA (first singular value 2.57). Created Tableau visualizations for insights.

## Tools
- R (conjoint package), Tableau

## Methodology
Performed ratings-based conjoint analysis with OLS regression on 10 respondents’ data, and PCA on a 32x11 dataset. Visualized results in Tableau.

## Findings
- Environmental Friendliness (2.133 importance) and Quality of Material (2.882) were key drivers.
- PCA revealed Feature 7, 8, 10 correlations and model clusters (e.g., Model 17, 19, 25).

## Recommendations
- Prioritize eco-friendly design and quality.
- Use PCA insights for competitive positioning.

## Data
- Location: `data/README.md`
- Note: Datasets kept local due to confidentiality.

## Output
- Location: `output/`
- Includes: `conjoint-partworths.csv`, `perceptions_attributes.csv`, `perceptions_scores.csv`, and visualization screenshots.
- Note: Tableau visualizations inaccessible due to subscription expiry; screenshots from assignment document or R-regenerated included.

## Code
- Location: `code/`
- Includes: `conjoint.R`, `pca.R`.