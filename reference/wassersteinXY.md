# Calculate the Wasserstein distance between two random variables

The Wasserstein distance between two numeric variables X and Y is
defined as the distance between their distribution functions \$F_X\$ and
\$F_Y\$ measured in the p-norm.

## Usage

``` r
wassersteinXY(X, Y, scale = FALSE, p = 1, knots = max(c(length(X), length(Y))))
```

## Arguments

- X:

  a real-valued random variable

- Y:

  a real-valued random variable

- scale:

  binary value indicating whether variables are to be normalized

- p:

  non-negative value identifying the norm. \$p\$ = 1 is Manhattan norm,
  \$p=2\$ is Euclidean distance.

- knots:

  non negative integer value specifying the number of evaluations within
  the ranges of X and Y.

## Value

single positive value. Larger values indicate less similarity.

## Examples

``` r

x <- runif(1000)
y <- runif(500)
wassersteinXY(x, y, knots=50)
#> [1] 0.02308
wassersteinXY(x, y, scale=TRUE, knots=50)
#> [1] 0.0103
# compare to results from transport::wasserstein1d(x, y)
```
