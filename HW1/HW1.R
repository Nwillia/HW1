



---
  title: "HW2"
output:
  html_document:
  df_print: paged
---
  
  # Summary
  
  We are going to produce an R package with functions with documentation, error messages, and tests (extra credit). The application is functionality to visualize and process data and estimates on family planning worldwide. Note that we already worked with the estimates in Intermediate R, HW1. Relevant code and functions from that HW are included in this Rmd in the section below, followed by the exercises for this HW.

Reference
https://rfortherestofus.com/2021/02/how-to-use-git-github-with-r/
  
  ## What to hand in
  
  An R notebook called hw1_exercises.Rmd and associated knitted html that shows the function calls and output as displayed in the hw1 starter Rmd/pdf with example solutions, as well as the link to your GitHub repo.


Grading: 20 points

- 15 points for exercise 1
- 5 points for exercise 2

```{r setup}
library(tidyverse)
library(readxl)
library(testthat)
library(assertthat)
library(devtools)
#knitr::opts_chunk$set(include = FALSE)
```

# Starter code for visualizing family planning estimates (from Intermediate R, HW1)
In HW1, we worked with table Model-based_estimates_Countries_2019.xlsx from https://www.un.org/en/development/desa/population/publications/dataset/contraception/data/Table_Model-based_estimates_Countries_2019.xlsx#Main, which contains estimates of modern contraceptive use (mCPR) among married women in the sheet "FP Indicators". In this HW, we are using the processed version of this data set stored in est.csv, with

- Country or area = country name
- iso	= country iso code
- Year = the reference year that the estimate refers to
- Median = point estimate of modern use among married women, in percentage    
- L95	U95 = lower and upper bounds of 95% uncertainty intervals, respectively.
- L80	U80 = lower and upper bounds of 80% uncertainty intervals, respectively.

In HW1, we wrote code to produce the plot below, which shows mCPR (%) among married women against time in Afghanistan (country iso code 4), lines are median estimates. I name the plotting here plot_cp_hw1 to avoid confusion/conflicts with the function that you will store in your package.
```{r}
est <- read_csv("est.csv")
```

```{r}
# note: just adding _hw1 to the function name here to not get confused with the function
# that you will add to your package (which will be called plot_cp).
plot_cp_hw1 <- function(est, iso_code) {
  est2 <- est %>%
    filter(iso == iso_code)
  
  est2 %>%
    ggplot(aes(x = Year, y = Median)) +
    geom_line() +
    geom_smooth(
      stat = "identity",
      aes(ymax = U95, ymin = L95)
    ) +
    labs(x = "Time", y = "Modern use (%)", title = est2$`Country or area`[1])
}
```

```{r, include = T}
plot_cp_hw1(est, iso_code = 4)
```
