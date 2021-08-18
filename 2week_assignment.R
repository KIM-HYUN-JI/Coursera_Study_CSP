data <- read.csv("001.csv")
view(data)
data2 <- read.csv("002.csv")
View(data2)

str(data) #데이터에 전체적인 설명을 볼 수 있음

#데이터에 요소 내용을 변경하고 싶을 때
#ex.성별이 1과2로 작성되어있을 때 남자, 여자로 바꾸려면
data$sex <- factor(data$sex,
                   levels = c(1, 2),
                   lavels = c("남자", "여자"))

attach(data)
detach(data) #변수이름을 data$ID 가 아닌 ID만 쳐도 알 수 있음

#function(사용자 정의함수) 함수로 데이터 처리하기

datamean <- function(x) { #x는 사용할 인수, 코드는 {} 괄호 안에 작성 
  mean <- c()
  for(monitor in id) {
  }
}

#2주차 assignment 풀어보기
#part1-데이터에서 평균구하기
data <- read.csv("001.csv", header = T)
view(data) #오염물질 평균을 구해야함

#필요한 함수들
?list.files #파일 또는 디렉터리 이름의 문자형 벡터를 생성
?numeric #"숫자" 유형의 개체를 생성하거나 강제 변환
?read.csv #csv파일을 읽는 것
?c #변수들을 하나로 묶어주는 것
?mean #평균을 구하는 함수

##############################################################
pollutantmean <- function(directory,pollutant, id = 1:332) {
    mylist <- list.files(path = directory, pattern = ".csv")
    x <- numeric()
    for(i in id) {
          mydata <- read.csv(mylist[i])
          x <- c(x, mydata[[pollutant]])
    }
    mean(x, na.rm = T)
} 
##############################################################
#여기에 작성한 for문을 R파일로 저장하고, (파일이름 pollutantmean)
> source("pollutantmean.R") #R파일 불러와서 함수실행
> pollutantmean("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", "sulfate", 1:10)
[1] 4.064128
> pollutantmean("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", "nitrate", 70:72)
[1] 1.706047
> pollutantmean("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", "nitrate", 23)
[1] 1.280833

#console에서 이렇게 결과 얻을 수 있음


#part2-332개의 파일에서 모니터 id 당 측정 완료된 데이터의 값 찾기
complete <- function(directory, id = 1:332) {
  mylist <- list.files(path = directory, pattern = ".csv")
  nobs <- numeric()
  for(i in id) {
    mydata <- read.csv(mylist[i])
    nobs <- c(nobs, sum(complete.cases(mydata)))
  }
  data.frame(id, nobs)
}
######################################################################
> source("complete.R")
> complete("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", 1)
id nobs
1  1  117
> 
  > complete("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", c(2, 4, 8, 10, 12))
id nobs
1  2 1041
2  4  474
3  8  192
4 10  148
5 12   96
> complete("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", 30:25)
id nobs
1 30  932
2 29  711
3 28  475
4 27  338
5 26  586
6 25  463
> complete("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", 3)
id nobs
1  3  243



#part3 - 측정완료된 케이스와 모니터의 상관관계를 구해야함 cor 함수 사용
corr <- function(directory, threshold = 0) {
  mylist <- list.files(path = directory, pattern = ".csv")
  df <- complete(directory)
  ids <- df[df["nobs"] > threshold, ]$id
  corrr <- numeric()
  for(i in ids) {
    mydata <- read.csv(mylist[i])
    dff <- mydata[complete.cases(mydata), ]
    corrr <- c(corrr, cor(dff$sulfate, dff$nitrate))
  }
  return(corrr)
}
##############################################################################
> source("corr.R")
> cr <- corr("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", 150)
> head(cr)
[1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814
> 
> summary(cr)
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.21057 -0.04999  0.09463  0.12525  0.26844  0.76313 
> cr <- corr("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", 400)
> head(cr)
[1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860
> summary(cr)
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.17623 -0.03109  0.10021  0.13969  0.26849  0.76313 
> cr <- corr("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata", 5000)
> summary(cr)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
                                                
> length(cr)
[1] 0
> cr <- corr("F:/hjikim/스터디/Coursera_Rprogramming/rprog_data_specdata/specdata")
> summary(cr)
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-1.00000 -0.05282  0.10718  0.13684  0.27831  1.00000 
> length(cr)
[1] 323