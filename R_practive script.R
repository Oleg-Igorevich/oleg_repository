
# MATRIX creation ---------------------------------------------------------

m1 <- matrix(1:8, nrow = 2, ncol = 4)
View(m1)

m2 <- c(1:8)
dim(m2) <- c(2, 4)
m2

v1 <- c(1:4)
v2 <- c(3:6)

m3 <- cbind(v1, v2)
m4 <- rbind(v1, v2)

# Working Directories -----------------------------------------------------

getwd()
setwd("C:/Users/O/Desktop/R")

# Git ---------------------------------------------------------------------

#   https://github.com/Oleg-Igorevich/oleg_repository.git

# the following commands should be run in the terminal:
#   git clone [paste link to online repository] <- creates a copy of the
#                                                  repository folder locally
#   cd                                          <- shows your current repository
#   cd [name of repository]                     <- sets repository to stated location
#   git add -A                                  <- essentially, says that all changes
#                                                  will be committed (-A stand for all)
#   git commit -m "type a message here"         <- saves commit locally 
#   git push                                    <- pushes commit to online copy
#                                                  of the repository
#