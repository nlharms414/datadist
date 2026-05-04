# Generates distance matrix for categorical columns in two data sets.

Computes a distance matrix and distance (similarity) score for the
categorical columns in two data sets.

## Usage

``` r
chardist(dfa, dfb)
```

## Arguments

- dfa:

  data set A to compare to data set B.

- dfb:

  data set B to compare to data set A.

## Value

A distance matrix for the categorical variables between two data sets.

## Examples

``` r
chardist(penguins,penguins_raw)
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#> Warning: Rows and columns not equal. Best matches found.
#>         studyName    Species     Island Individual ID Clutch Completion
#> species 0.2434762 0.00000000 0.09275284     0.9710063         0.5449229
#> island  0.3362290 0.09275284 0.00000000     0.9710063         0.4521701
#> sex     0.3188379 0.19709978 0.15072336     0.9797019         0.7794163
#>               Sex  Comments
#> species 0.1970998 0.5406288
#> island  0.1507234 0.4478760
#> sex     0.0000000 0.4895165
#> attr(,"dfa")
#> [1] "penguins"
#> attr(,"dfb")
#> [1] "penguins_raw"
```
