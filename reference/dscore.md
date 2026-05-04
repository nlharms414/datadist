# Generates distance score for a distance matrix and maps variables.

Computes a distance matrix and distance (similarity) score for the
numerical or categorical variables of two data frames. Also gives
mappings for the best matched variables between two data sets.
\`dscore()\` can also compute a similarity score and provide mappings
for two individual categorical variables between two data sets. Mappings
will map the best matched categories between the two variables.

## Usage

``` r
dscore(dmat)
```

## Arguments

- dmat:

  distance matrix between numerical variables, categorical variables, or
  two individual categorical variables between two data sets.

## Value

A list containing a dataframe with variable mappings & distances,
overall data distance score, original distance matrix, and extra columns
(if any) that could not be matched.

## Examples

``` r
dscore(numdist(penguins,penguins_raw))
#> Warning: Rows and columns not equal. Best matches found.
#> $mappings
#>      penguins        penguins_raw      dist
#> 1    bill_len  Culmen Length (mm) 0.0000000
#> 2    bill_dep   Culmen Depth (mm) 0.0000000
#> 3 flipper_len Flipper Length (mm) 0.0000000
#> 4   body_mass       Body Mass (g) 0.0000000
#> 5        year       Sample Number 0.9647614
#> 
#> $distmat
#>             Sample Number Culmen Length (mm) Culmen Depth (mm)
#> bill_len        0.2067585          0.0000000         0.5740344
#> bill_dep        0.3141910          0.5740344         0.0000000
#> flipper_len     0.5972505          0.7869662         0.8408983
#> body_mass       0.6551389          0.6614987         0.6627992
#> year            0.9647614          0.9896811         0.9936421
#>             Flipper Length (mm) Body Mass (g) Delta 15 N (o/oo)
#> bill_len              0.7869662     0.6614987         0.6750286
#> bill_dep              0.8408983     0.6627992         0.6052995
#> flipper_len           0.0000000     0.6509503         0.8578261
#> body_mass             0.6509503     0.0000000         0.6631395
#> year                  0.9799742     0.5100500         0.9941949
#>             Delta 13 C (o/oo)  Date Egg
#> bill_len            0.8013205 0.9698909
#> bill_dep            0.8803476 0.9699754
#> flipper_len         0.8756223 0.9691518
#> body_mass           0.6648990 0.8396881
#> year                0.9941948 0.9670599
#> attr(,"dfa")
#> [1] "penguins"
#> attr(,"dfb")
#> [1] "penguins_raw"
#> 
#> $distscore
#> [1] 0.9647614
#> 
#> $extracols
#> [1] "Delta 15 N (o/oo)" "Delta 13 C (o/oo)" "Date Egg"         
#> 
```
