# Difference measure for numerical columns between two data sets.

Produces a numerical variable distance matrix between two data sets.
Dates will be coerced into a numerical format via \`as.numeric\`.

## Usage

``` r
numdist(dfa, dfb, scale = FALSE)
```

## Arguments

- dfa:

  data set A

- dfb:

  data set B

- scale:

  binary option to set the scale option in \`wassersteinXY()\` to TRUE,
  so variables are scaled before computing distance. Default is FALSE.

## Value

A distance matrix created using \`wassersteinXY()\` on every pairwise
combination of numerical variables between data set A and data set B.

## Examples

``` r
# example code
dataA <- data.frame(a = c(1,5,3,2),
                    b = c(4,1,6,8),
                    c = c(3,6,1,7),
                    d = c("orange","apple","mango","apple"),
                    e = c("one","three","two","one"))
dataB <- data.frame(f = c(4,1,6,8),
                    g = c(1,5,3,2),
                    h = c(3,6,1,7),
                    i = c("one","three","two","one"),
                    j = c(5,6,0,9),
                    k = c("orange","apple","mango","apple"))

numdist(dataA, dataB)
#>        f      g      h      j
#> a 0.2500 0.0000 0.1875 0.2500
#> b 0.0000 0.2500 0.0625 0.0625
#> c 0.0625 0.1875 0.0000 0.1250
#> attr(,"dfa")
#> [1] "dataA"
#> attr(,"dfb")
#> [1] "dataB"

numdist(penguins,penguins_raw, scale=TRUE)
#>             Sample Number Culmen Length (mm) Culmen Depth (mm)
#> bill_len       0.02197707         0.00000000        0.01725486
#> bill_dep       0.04012541         0.01725486        0.00000000
#> flipper_len    0.01928412         0.02935877        0.04788862
#> body_mass      0.01381259         0.03087175        0.04516014
#> year           0.08358403         0.06282043        0.07487254
#>             Flipper Length (mm) Body Mass (g) Delta 15 N (o/oo)
#> bill_len             0.02935877    0.03087175        0.01932127
#> bill_dep             0.04788862    0.04516014        0.03349700
#> flipper_len          0.00000000    0.01598837        0.02030155
#> body_mass            0.01598837    0.00000000        0.01570478
#> year                 0.08099605    0.07992891        0.07950233
#>             Delta 13 C (o/oo)    Date Egg
#> bill_len           0.02553562 0.059217148
#> bill_dep           0.04202667 0.071526532
#> flipper_len        0.01946549 0.076343523
#> body_mass          0.01585918 0.075996409
#> year               0.08229886 0.009160357
#> attr(,"dfa")
#> [1] "penguins"
#> attr(,"dfb")
#> [1] "penguins_raw"
```
