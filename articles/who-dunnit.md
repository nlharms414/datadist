# Whodunit?

This vignette features a “whodunit” style problem to demonstrate the
`datadist` package use.

## Palmer Penguins mix up

Uh oh! The original Palmer Penguins (`penguins`) dataset has been badly
misshapen. Variable names are missing, categories for categorical
variables have been replaced with letters, numerical variables have been
scaled, and columns have been reordered. It is our job to use functions
from the `datadist` package to determine what what done to the original
`penguins` dataset that resulted in such a catastrophe.

First, we’ll want to load the package. (If you haven’t already done so,
install the package.)

``` r

library(datadist)
```

### Using `chardist`, `dscore`, and `chardist_XY`

Let’s first figure out what happened with the categorical variables in
the dataset. First, we can use `chardist` to generate a distance matrix
for every pairwise combination of categorical variables between the two
datasets.

``` r

peng_dist <- chardist(penguins,penguins_whodunit)
#> Warning in dscore(charmat): Rows and columns not equal. Best matches found.
#> Warning in dscore(charmat): Rows and columns not equal. Best matches found.
#> Warning in dscore(charmat): Rows and columns not equal. Best matches found.
#> Warning in dscore(charmat): Rows and columns not equal. Best matches found.
peng_dist
#>               Var4      Var5       Var8
#> species 0.00000000 0.1970998 0.09275284
#> island  0.09275284 0.1507234 0.00000000
#> sex     0.19709978 0.0000000 0.15072336
#> attr(,"dfa")
#> [1] "penguins"
#> attr(,"dfb")
#> [1] "penguins_whodunit"
```

This result is already pretty telling, but let’s use `dscore` to look at
variable mappings just to confirm things. The `dist` column will give us
a distance score between the two variables from each dataset that are
the best match.

``` r

dscore(peng_dist)$mappings
#>   penguins penguins_whodunit dist
#> 1  species              Var4    0
#> 2      sex              Var5    0
#> 3   island              Var8    0
# dscore() actually returns a list of items
# use $ + tab to see what else it returns!
```

Great! Now we know which variables are which. But, recall that all of
the categorical variables in the dataset had been recoded with letters.
Luckily, `chardist_XY` can help us solve that problem. We can use it on
the variable pairs above to tell us which categories from the original
dataset are represented by each letter. `chardist_XY` is designed to
work on single variable comparisons, and the results returned are a
combination of `chardist` and `dscore`.

``` r

chardist_XY(penguins$species,penguins_whodunit$Var4)$distmat$mappings
#> use the stringdist package to find a string distance between the values
#>         dfA dfB dist
#> 1    Adelie   A    0
#> 2 Chinstrap   B    0
#> 3    Gentoo   C    0
chardist_XY(penguins$sex,penguins_whodunit$Var5)$distmat$mappings
#> use the stringdist package to find a string distance between the values
#>      dfA dfB dist
#> 1 female   A    0
#> 2   male   B    0
chardist_XY(penguins$island,penguins_whodunit$Var8)$distmat$mappings
#> use the stringdist package to find a string distance between the values
#>         dfA dfB dist
#> 1    Biscoe   A    0
#> 2     Dream   B    0
#> 3 Torgersen   C    0
```

So, how do we interpret the results in their entirety? Well, the use of
`chardist` and `dscore` told us that `Var4` in `penguins_whodunit` is
actually `species` from the original `penguins` dataset, for example
(and so on and so forth for the other mappings). Then, if we take a
closer look at the actual factors in `Var4` and `species`, we can find
that “A” was actually “Adelie”, “B” was actually “Chinstrap”, and “C”
was actually “Gentoo”. We can look more closely at the other variable
mappings the same way. Now that we’ve got the categorical variables
covered, let’s move on to the numerical ones.

### Using `numdist` and `dscore`

With the numerical variables, the goal here is to simply match the
variables. Let’s run `numdist` on the two datasets and see what happens.

``` r

numdist(penguins,penguins_whodunit)
#>                  Var1      Var2      Var3      Var6      Var7
#> bill_len    0.7090898 0.7102118 0.7206787 0.7123538 0.7103733
#> bill_dep    0.7225962 0.7262087 0.7521879 0.7316486 0.7261662
#> flipper_len 0.8593091 0.8597681 0.8632711 0.8602696 0.8596321
#> body_mass   0.6637597 0.6637087 0.6646212 0.6637087 0.6637087
#> year        0.9941945 0.9941945 0.9951156 0.9941945 0.9941945
#> attr(,"dfa")
#> [1] "penguins"
#> attr(,"dfb")
#> [1] "penguins_whodunit"
```

Huh. That’s weird- none of the distance values indicate that that any of
the numerical variables in `penguins_whodunit` are good matches for the
variables in the original `penguins` dataset. What’s going on here?

Looking at the numerical variables in the `penguins_whodunit` dataset,
we can tell they have all been normalized. So, when we use `numdist` to
look at a distance matrix of all the numerical variables, we want to set
the `scale` option to `TRUE`. Why? `numdist` relies on `wasserstein_XY`,
a function that computes the Wasserstein distance between two variables.
Since the computation of the Wasserstein distance relies partly on the
distance between the actual data values themselves, we should scale the
variables in both datasets before computing the Wasserstein distance to
get them both on the same scale. Then, the distance calculation between
the two variables will be more accurate.

``` r

numdist(penguins,penguins_whodunit, scale = T)
#>                     Var1         Var2         Var3         Var6         Var7
#> bill_len    8.499932e-06 2.935877e-02 0.0628204277 3.087175e-02 0.0172548620
#> bill_dep    1.725486e-02 4.788862e-02 0.0748725406 4.516014e-02 0.0000254998
#> flipper_len 2.935877e-02 8.499932e-06 0.0809960497 1.598837e-02 0.0478886169
#> body_mass   3.087175e-02 1.598837e-02 0.0799289129 8.499932e-06 0.0451601387
#> year        6.282043e-02 8.099605e-02 0.0009295565 7.992891e-02 0.0748980404
#> attr(,"dfa")
#> [1] "penguins"
#> attr(,"dfb")
#> [1] "penguins_whodunit"
```

Ah, that looks much better. Though, with all the decimals it’s not super
easy to tell which variables match to which just by looking at it. This
is where applying `dscore` to look at the mappings will come in handy.

``` r

dscore(numdist(penguins,penguins_whodunit, scale = T))$mappings
#>      penguins penguins_whodunit         dist
#> 1    bill_len              Var1 8.499932e-06
#> 2 flipper_len              Var2 8.499932e-06
#> 3   body_mass              Var6 8.499932e-06
#> 4    bill_dep              Var7 2.549980e-05
#> 5        year              Var3 9.295565e-04
```

`dscore` determined that the mappings seen above result in the lowest
over all distance score for the numerical variables. Thus, we can
interpret the results similarly to what we did with the categorical
variables. Here, `Var1` in the `penguins_whodunit` dataset was
originally the `bill_len` variable in the original dataset, and likewise
we can interpret all the other variable mappings.

It’s noted here that none of the scores between the best matched
variables are *exactly* zero, though they are close. This again has to
do with the scaling; the variables in `penguins_whodunit` were scaled to
begin with, and because we used the `scale=T` argument when we ran
`numdist`, those variables were scaled *again*. So, while scaling the
variable a second time doesn’t change the values by much and allows for
proper comparison, it is just enough change to result in the non-zero
scores we see above.

### So, whodunit??

That concludes our sleuthing! By using a combination of `datadist`
functions, we have now gathered the information needed to figure out
which variables were which, and subsequently, we have the information we
need to convert `penguins_whodunit` back to the original `penguins`
dataset. And hopefully along the way, you’ve learned a little more about
the `datadist` functions and how to use them.
