# Removes categorical variable columns with only one category.

A function that removes categorical variables from a data frame if they
only contain one category. Desiged for use with chardist().

## Usage

``` r
rm_single_cat(df)
```

## Arguments

- df:

  data frame to remove one category categorical variables from.

## Value

A data frame with categorical variables containing only one category
removed.

## Examples

``` r
# example code
head(rm_single_cat(penguins_raw))
#>   studyName Sample Number                             Species    Island
#> 1   PAL0708             1 Adelie Penguin (Pygoscelis adeliae) Torgersen
#> 2   PAL0708             2 Adelie Penguin (Pygoscelis adeliae) Torgersen
#> 3   PAL0708             3 Adelie Penguin (Pygoscelis adeliae) Torgersen
#> 4   PAL0708             4 Adelie Penguin (Pygoscelis adeliae) Torgersen
#> 5   PAL0708             5 Adelie Penguin (Pygoscelis adeliae) Torgersen
#> 6   PAL0708             6 Adelie Penguin (Pygoscelis adeliae) Torgersen
#>   Individual ID Clutch Completion   Date Egg Culmen Length (mm)
#> 1          N1A1               Yes 2007-11-11               39.1
#> 2          N1A2               Yes 2007-11-11               39.5
#> 3          N2A1               Yes 2007-11-16               40.3
#> 4          N2A2               Yes 2007-11-16                 NA
#> 5          N3A1               Yes 2007-11-16               36.7
#> 6          N3A2               Yes 2007-11-16               39.3
#>   Culmen Depth (mm) Flipper Length (mm) Body Mass (g)    Sex Delta 15 N (o/oo)
#> 1              18.7                 181          3750   MALE                NA
#> 2              17.4                 186          3800 FEMALE           8.94956
#> 3              18.0                 195          3250 FEMALE           8.36821
#> 4                NA                  NA            NA   <NA>                NA
#> 5              19.3                 193          3450 FEMALE           8.76651
#> 6              20.6                 190          3650   MALE           8.66496
#>   Delta 13 C (o/oo)                       Comments
#> 1                NA Not enough blood for isotopes.
#> 2         -24.69454                           <NA>
#> 3         -25.33302                           <NA>
#> 4                NA             Adult not sampled.
#> 5         -25.32426                           <NA>
#> 6         -25.29805                           <NA>
```
