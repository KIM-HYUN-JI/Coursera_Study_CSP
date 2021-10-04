#Chapter 3.Getting and Cleaning Data

#1week <- file 불러오기(온라인, 여러형식)/ data.table Package / Tidy data principles
##우리가 아는 데이터(xls, hwp, doc)뿐 아니라 더 확장된 개념을 알아야 한다.##

#Raw data -> processing script -> tidy data -> data analysis -> data communication
##직접 보는게 제일 좋지만 빅데이터니까 최대한 쓸수있는 데이터가 되도록 깨끗하게 정리하는 것

#Raw data : 완전 오리지널 형식. 분석하기 어려운 형식
#Processed data : 분석하기 위해 준비 된 데이터.
##public data를 볼때. Raw는 잘 공개 안하긴함. processed가 깔끔하지만 저자가 뭘 쳐냈는지 잘 모르니까 제한적임
##public data를 분석할 땐 최대한 Raw data와 가까운 형태로 가져오는 것이 좋다.

#Tidy data : 각 변수가 하나의 컬럼에. 각각의 측정값이 다른 변수로 정리.
      ##Tidy data로 갈 수록 information은 loss가 일어남. 
##code book : 내꺼라고 정리 안하면 안됨! 나중에 public할때 공개해야 하니까 미리 정리 필요
      ##예를들어, Age 컬럼에서 Age의 기준이 진단 당시 인지, 수술한 때인지 code book에 description 해놔야함
              ## Month 컬럼에서 개월 단위인지, 주 단위인지도 통일해서 정리해놔야함

#douwnload.file(url ="", destfile = "dir에 저장할 파일이름.형식" )
  ##직접 사이트 가서 클릭해도 되지만 이렇게 해야 log가 남으니까 나중에 추적이 가능

#xlsl, XML=xmlTreeParse(url="", )/xmlSApply(x, xml값) <- 어디에 뭐가 있는지 알 때 사용

#JSON=jsonlite / fromJSON("url") /pubmed의 list형태로 저장되는 데이터가 대표적인 JSON 형식
##논문 citation 받을 때 endnote 말고 txt로 다운받으면 엄청 자유로운 형식 있음. 그게 JSON형식!

#data.table(x, y, z)
  ##public data는 용량이 워낙 크니까 사이트에 가보면 R에서 어떻게 다운받아라 하고 알려주기도 함
  ##우리는 read.csv을 주로 쓰지만 public에선 read.table 쓰는 경우가 있음
  ##요즘은 dyplr로 더 간단하게 table 만들 수 있음





#2week <- common data storage systems   ##최대한 짧게 정리하고 2-3주 내용 합쳐서 발표
  #1) MySQL
  #2) HDF5
  #3) The Web
  #4) APIs
  #5) Other Sources


#3week <- organizing, merging, managing the data./ dplyr Tools

#1)Subsetting and sorting : 복잡한(지저분한)데이터 필요한 값만 정리하기
#2)Summarizing data : 데이터를 요약해서 살펴보기
sp <- read.csv("songpagu.csv")
#데이터 구조 보기
head(sp, n = 3)  #n을 설정하지 않으면 6개가 나옴
tail(sp, n = 3)
summary(sp)
str(sp)
quantile(sp$지정일자, na.rm = TRUE)
quantile(sp$지정일자, probs = c(0.5, 0.75, 0.9), na.rm = TRUE)

table(sp$업태명, useNA = "ifany")
table(sp$지정일자, sp$업태명)

#NA 결측치 찾기
sum(is.na(sp$업소명))
any(is.na(sp$업소명))
all(sp$허가.신고.번호 > 0)

colSums(is.na(sp))
all(colSums(is.na(sp)) == 0)

# %in%  : 포함 연산자. 데이터에서 특정 character 찾을 때 
table(sp$업태명 %in% c("일식"))
table(sp$업태명 %in% c("일식", "중식"))
sp[sp$업태명 %in% c("분식", "산업체"), ]


object.size(sp)  #bytes 단위로 출력
print(object.size(sp), units = "Mb")


#테이블로 요약하기
#Cross tabs : xtabs()
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

#Flat tables : ftable()  
data("warpbreaks")
ftable(warpbreaks)
warpbreaks$replicate <- rep(1:9, len = 54)

xt = xtabs(breaks ~., data = warpbreaks)
xt
ftable(xt)


#dplyr 패키지 사용하기
library(dplyr)





#4week <- 
