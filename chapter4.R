#public data 이용해서 분석하는거(RNA expression)
#visual studio code : R studio보다 엄청 편한건 아닌데 text editor의 장점은 R, python, JAVA 등 다양한 언어 같이 사용할 수 있음
#GEO data : gene expression .. publish된 데이터 모아둔 ㄱ서
library(GEOquery) #GEO 데이터 불러오는데 특화된 패키지
#GDC data :mutation 관련 데이터. TCGA는 연구자가 올리는거 GDC는 raw데이터를 받아서 일괄적으로 처리한 데이터
library(affy) #확장자가 다를때 변환이 쉽게해주는 패키지, 분리된 파일을 합칠때도 사용
library(hgu133plus2.db) #probe가 무슨 유전자인지 매칭할때 필요한 데이터베이스 찾는 패키지
library(tidyverse)
library(stringr)
library(lima) #expression 차이를 비교할때 쓰는 패키지. 멀티플 테스트

## Data ##
#platform이 다른 데이터끼리 비교하면 값이 튀어서 normalization을 잘 해야함
#정설로 알려져있는 정보를 기준으로 probe가 여러개일 때 통일시켜주는 방법이 있음
#expression data 는 fold change 값을 본다
#lima package로 테이블까지 정리가 되고, plot은 따로! volcano plot(enhancedvolcano)
#-Log10P 가 y축 위로 올라갈수록 p-value가 낮은것(유의한것)
#X 축은 Log2 fold change cut-off를 정해줘야함
#volcano plot 공부하기
#데이터에서 어떤 아이디어를 가지면 좋을까 고민하면서 작업해보면 좋음


getGEOSuppFiles(data, makeDirecroty = T, baseDir = "경로")
untar(paste)

#CHAPTER4

#1week
#무엇을 비교할건지, 체계적인구조, 인과적, 다변수 데이터를 표시, 단어나 숫자 이미지를 모두 통합하되 tool이 아닌 본인이 주도해야함, 적절한 척도로 설명, 컨텐츠를 잘 활용하라.
#그래프
##dev.off() 이 함수로 모든 그래프 그린 후에 다 꺼줘야 한다.
#디바이스 off 함수
#내가 원하는 그래프마다 패키지가 여러개가 나와있으니까 예쁜 패키지 찾아서 사용하는것도 중요!

#plotting 연습 많이 하기 
#2주차는 ggplot을 더 중점적으로 


#2week
##Lattice plotting system

library(datasets)
library(lattice)
plot(airquality$Ozone, airquality$Wind) #Base R의 plot
xyplot(Ozone ~ Wind, data = airquality)

str(airquality)
xyplot(Ozone ~ Wind | Month, data = airquality)

airqualitys <- transform(airquality, Month = factor(Month))
head(airqualitys, 5)

xyplot(Ozone ~ Wind | Month, data = airquality)
xyplot(Ozone ~ Wind | Month, data = airqualitys, layout = c(5, 1))


p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)

set.seed(10)
f <- rep(0:1, each = 50)
f
f <- factor(f, labels = c("Group1", "Group2"))
f


library(ggplot2)
install.packages("ggplot2")
str(mpg)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

qplot(hwy, data = mpg, fill = drv)

#Facets
qplot(displ, hwy, data = mpg, facets = . ~ drv)
qplot(hwy, data = mpg, facets = drv ~., binwidth = 2)

#log
qplot(displ, data = mpg, fill = drv)
qplot(log(displ), data = mpg, fill = drv)
qplot(log(displ), data = mpg, geom = "density")

#ggplot2
str(mpg)

qplot(displ, hwy, data = mpg, facets = . ~ drv, geom = c("point", "smooth"), method = "lm")

g <- ggplot(mpg, aes(displ, hwy))
summary(g)
print(g)

p <- g + geom_point()
print(p)

g + geom_point() + geom_smooth(method = "lm")
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ drv)

#point 색상, 크기, 투명도 설정
g + geom_point(aes(color = drv), size = 3, alpha = 1) + geom_smooth(method = "lm") + facet_grid(. ~ drv)

g1 <- ggplot(mpg, aes(displ, hwy))
g1 + geom_point(color = "steelblue", size = 4, alpha = 1/2)

#labeling
g1 + geom_point(aes(color = drv), size = 4, alpha = 1/2) + 
  labs(title = "Coursera MPG data", x = "Displacement", y = "Highway Fuel Economy (miles/gallon)")

#추세선 넣기
g1 + geom_point(aes(color = drv), size = 4, alpha = 1/2) + 
  labs(title = "Coursera MPG data", x = "Displacement", y = "Highway Fuel Economy (miles/gallon)") + 
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
                                                    #se가 TRUE면 표준오차(회색배경) 표시
#Theme 바꾸기(글꼴, 배경)
g1 + geom_point(aes(color = drv), size = 4, alpha = 1/2) + 
  labs(title = "Coursera MPG data", x = "Displacement", y = "Highway Fuel Economy (miles/gallon)") + 
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE) + 
  theme_bw(base_family = "Times") + 
  theme(plot.title = element_text(hjust = 0.5))

dev.off()

#axis 설정하기
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50, 2] <- 100 #axis를 벗어나는 데이터
plot(testdat$x, testdat$y, type = "l", ylim = c(-3, 3)) 

g <- ggplot(testdat, aes(x = x, y= y))
g + geom_line()
g + geom_line() + ylim(-3, 3) 
g + geom_line() + coord_cartesian(ylim = c(-3, 3))


#final code
g1 + geom_point(aes(color = drv), size = 2, alpha = 1/2) + 
  labs(title = "Coursera MPG data", x = "Displacement", y = "Highway Fuel Economy (miles/gallon)") + 
  geom_smooth(size = 1, linetype = 2, method = "lm", se = FALSE) + 
  theme_bw(base_family = "Times") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(. ~ class) 



##ggplot2




#분석에는 좋은 컴퓨터가 필요한데 무작정 다 살 수 없으니까 클라우드 컴퓨팅으 사용하는데 아마존에서 가장 잘 제공됨 그래서 굉장히 복잡함 빅데이터 분석할때 사용 
