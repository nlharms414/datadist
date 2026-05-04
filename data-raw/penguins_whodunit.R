## code to prepare `penguins_whodunit` dataset goes here

scaled <- as.data.frame(scale(penguins[,c(3,5,8,6,4)]))

letter <- as.data.frame(lapply(penguins[,c(1,7,2)], function(x){
  if (!is.factor(x)) {
    x <- factor(x)
  }
  levels(x) <- LETTERS[seq_along(levels(x))]
  x
}))

penguins_whodunit <- as.data.frame(cbind(scaled[,c(1:3)],letter[,c(1:2)],
                                         scaled[,c(4:5)],letter[,3,drop=F]))
names(penguins_whodunit) <- c(paste0("Var",1:8))
# 1=bill len, 2=flipper, 3=year, 4=species, 5=sex, 6=body mass, 7=bill dep, 8=island

usethis::use_data(penguins_whodunit, overwrite = TRUE)
