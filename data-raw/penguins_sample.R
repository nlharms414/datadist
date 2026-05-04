## code to prepare `penguins_sample` dataset goes here
set.seed(369)

penguins_sample <- penguins[sample(nrow(penguins), size = 200), ]

usethis::use_data(penguins_sample, overwrite = TRUE)
