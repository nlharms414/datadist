# Compares two catecorical (or factor) columns between two data sets.

The distance between two character (or factor) variables is being
calculated.

## Usage

``` r
chardist_XY(varA, varB)
```

## Arguments

- varA:

  vector from dataset A

- varB:

  vector from dataset B

## Value

A a binary response indicating if two variables are identical, a
marginal distance between the two variables as factors, and objects
returned by use of dscore().

## Examples

``` r
# example code
chardist_XY(penguins$species, penguins_raw$Sex)
#> use the stringdist package to find a string distance between the values
#> Warning: Rows and columns not equal. Best matches found.
#> $identical
#> [1] FALSE
#> 
#> $`marginal distance`
#> [1] 1
#> 
#> $distmat
#> $distmat$mappings
#>      dfA    dfB       dist
#> 1 Adelie FEMALE 0.05347911
#> 2 Gentoo   MALE 0.14362067
#> 
#> $distmat$distmat
#>               FEMALE       MALE
#> Adelie    0.05347911 0.06246193
#> Chinstrap 0.29695532 0.30593814
#> Gentoo    0.13463785 0.14362067
#> attr(,"dfa")
#> [1] "dfA"
#> attr(,"dfb")
#> [1] "dfB"
#> 
#> $distmat$distscore
#> [1] 0.1970998
#> 
#> $distmat$extracols
#> [1] "Chinstrap"
#> 
#> 
```
