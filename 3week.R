#3주차-루프함수와 디버깅
lapply()
sapply()
apply()
tapply()
mapply()

?lapply(list, function)
lapply() #list 형태의 데이터 사용

x <- list(a = 1:5, b = rnorm(10))
x
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
x
lapply(x, mean)
sapply(x, mean)

#이런 데이터에서 mean 함수를 단독으로 사용 못하는 이유
class(x)
mean(x)

x <- 1:4
x
lapply(x, runif, min = 0, max = 10)


#Anonymous function(익명함수)
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
lapply(x, function(elt) elt[,1])
sapply(x, function(elt) elt[,1])


?apply(array, margin, ...)

x <- matrix(rnorm(200), 20, 10)
x
apply(x, 2, mean)
apply(x, 1, sum)

colMeans(x)
rowSums(x)

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
a
apply(a, c(1, 2), mean)
rowMeans(a, dims = 2)

list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4,1))  #rep 반복되는 수를 만드는 함수
mapply(rep, 1:4, 4:1)


?tapply(vector, index, function)

data(iris)
table(iris$Species)
head(iris$Sepal.Length)

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species, mean, simplify = FALSE)


?split

x <- c(rnorm(10), runif(10), rnorm(10, 1))
x
f <- gl(4, 9)
split(x, f)

lapply(split(x, f), mean)
sapply(split(x, f), mean)

sp <- split(iris, iris$Species)
sp
lapply(sp, function(x) colMeans(x[, c("Sepal.Length", "Sepal.Width")]))
sapply(sp, function(x) colMeans(x[, c("Sepal.Length", "Sepal.Width")]))

#Debugging
log(3)
log(-3)

printmessage <- function(x) {
  if (x > 0) 
    print("x is greater than zero") else print("x is less than or equal to zero")
  invisible(x)
}
printmessage(1)
printmessage(NA)


mean(k)
traceback()


sum_to_ten <- function() {
  sum <- 0
  for(i in 1:10){
    sum <- sum + i
    if(i >= 5) {
      browser()
    }
  }
}
sum_to_ten()


#trace : 함수에 임의로 브레이크 포인트 넣기
trace(func, tracer = browser, at = 3)

#recover : 에러 바로잡기
options(error = recover)
read.csv("nosuchfile")











l##############################################################################
test <- list(s20 = c(78, 89, 91, 98, 96, 85 ),
             s21 = c(85, 86, 97, 99, 90),
             s22 = c(98, 96, 89, 90, 93, 85, 92),
             s23 = c(98, 96, 91, 88, 93, 99))
test      #list 구조의 데이터
#각 년도 별 수강생 수
lapply(test, length)
sapply(test, length)

lapply(test, mean)
sapply(test, mean)

sapply(test, range)  #range는 최대값, 최소값을 구하는 함수. 두개의 값이 나오기 때문에 matrix 형태로 나온다.


?sapply




?apply

x <- matrix(1:20, 4, 5)
x
#matrix에서 특정 값 반복해서 찾기
apply(X = x, MARGIN = 1, FUN = max)
apply(X = x, MARGIN = 2, FUN = min)


y <- array(1:24, c(4, 3, 2)) #3차원의 배열 데이터
y

apply(y, 1, paste, collapse = ",")
apply(y, 3, paste, collapse = ",")
apply(y, c(1, 2), paste, collapse = ",")


Titanic  #R 기본제공 데이터set
str(Titanic) #4개의 차원이 있는 데이터
apply(Titanic, 1, sum)
apply(Titanic, 4, sum)
apply(Titanic, "Age", sum)
apply(Titanic, c(1, 4), sum)

#data frame에 적용할 때
head(iris)
lapply(iris, class)
sapply(iris, class)



?mapply
mapply(rep, 1:4, 4:1)
rep(1, 4)
rep(2, 3)
rep(3, 2)
rep(4, 1)
#이 네개의 rep 함수를 묶어서 보여주는 것이 mapply
#데이터 set 두개를 받아서 값의 주어진 함수에 따라 쌍을 지어 결과 계산

mtcars_dt <- as.data.table(mtcars)
mtcars_dt <- mtcars_dt[,  .(mean_cols = mean(hp)), by = cyl]
round(abs(mtcars_dt[cyl == 4, mean_cols] - mtcars_dt[cyl == 8, mean_cols]))
library(data.table)
iris_dt <- as.data.table(iris)
iris_dt[Species == "virginica",round(mean(Sepal.Length)) ]
