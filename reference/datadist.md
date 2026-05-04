# Difference Measure for Data Sets

Produces a numerical variable distance matrix and a categorical variable
distance matrix.

## Usage

``` r
datadist(dfa, dfb)
```

## Arguments

- dfa:

  data.frame

- dfb:

  data.frame

## Value

\`numdist\` is returned using the \`wassersteinXY()\` function to find a
distance matrix for every numerical variable combination between data
frame A and data frame B. \`chardist\` is found likewise.

## Examples

``` r
# example code
dataA <- data.frame(a = c(1,5,3,2),
                    b = c(4,1,6,8),
                    c = c(3,6,1,7),
                    d = c("apple","orange","banana","mango"))
dataB <- data.frame(a = c(1,9,2,6),
                    b = c(4,2,6,9),
                    c = c(3,6,1,7),
                    d = c(3,7,9,2),
                    e = c("pear","grape","lemon","lime"))
```
