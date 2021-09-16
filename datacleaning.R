#Getting and Cleaning data
#1week Quiz
#Quiz에 사용해야 할 함수들 버전이 4.1.1인데 지금 4.1.0이라서 업데이트 먼저..
install.packages("installr")
library(installr)
install.R()
library(rJava)
library(data.table)
library(xlsx)
library(XML)

#1. 온라인에서 데이터 불러오고 조건을 만족하는 데이터 갯수 세기
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "getdata.csv")
    #destfile은 설정해놓은 directory에 저장 할 파일 이름
mydata <- read.csv("getdata.csv")
  #부동산 가치가 1,000,000 이상인 데이터 갯수 구하기
length(which(mydata$VAL == 24))  #인터넷에 1,000,000이 24래서 24썼는데 왜인지는 데이터파일을 제대로 안봐서 모름
##Answer = 53

#2. 변수 FES가 위반한 "tidy data"의 원칙

#1)Each variable in a tidy data set has been transformed to be interpretable. 
#2)Tidy data has one observation per row. 
#3)Tidy data has one variable per column. 
#4)Each tidy data table contains information about only one type of observation. 
##Answer = 3)Tidy data has one variavle per column

#3. 온라인에서 엑셀파일 다운받고 dat에 rows 18-23, columns 7-15 데이터 할당 후 예제 함수 사용하기
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", 
              destfile = "NGAP.xlsx", mode = "wb")  #xlsx파일은 기본적으로 zip 형태로 다운되기 때문에 바로 사용할 수 있게 mode는 wb로 설정해줘야함
dat <- xlsx::read.xlsx(file = "NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

#4. 온라인에서 XML 파일 다운받고 zipcode 21231인 매장 갯수 세기
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              destfile = "restaurants.xml")
doc <- xmlTreeParse("restaurants.xml", useInternal = TRUE)
rootNode <- xmlRoot(doc)
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")

#5. csv다운로드 받고, fread() 함수 사용. pwgtp15 평균 계산하기
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", 
              destfile = "2006.csv")
DT <- fread("2006.csv", sep = ",") #fread는 read.table이랑 비슷한 함수
system.time(DT[,mean(pwgtp15),by=SEX]) #질문이 시스템 타임 가장 빠른 함수가 어떤건지 고르는것

