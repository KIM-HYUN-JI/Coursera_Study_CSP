#Chapter 3
##3week QUIZ

1. download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "Q3-1.csv")
Q1 <- read.csv("Q3-1.csv")
#10에이커(땅크기) 이상 가구 중 10,000달러 판매한 가구를 식별하도록 백터 생성
#codebook > ACR(Lot size) 3은 House on ten or more acres
          #AGS(판매금액) 6은 $10000+
 agricultureLogical <- Q1$ACR == 3 & Q1$AGS == 6
 #which를 써서 3개의 값 확인(질문)
 head(which(agricultureLogical), 3)
 
 
2. library(jpeg)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "Q3-2.jpg")
Q2 <- readJPEG("Q3-2.jpg")
#데이터의 30번째, 80번째 분위수 찾기
quantile(Q2, probs = c(0.3, 0.8))


3. library(data.table) #용량 큰 데이터 불러올때 data.table 패키지의 fread()사용하기
#두개의 데이터에서 국가번호를 기준으로 일치하는 갯수와 GDP 13번째 국가
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                    destfile = "Q3-3.csv")
Q3 <- read.csv("Q3-3.csv")
names(Q3)

Q3GDP <- data.table::fread("Q3-3.csv", skip = 4, sep = ",", nrows = 190,
                           select = c(1, 2, 4, 5), 
                           col.names = c("CountryCode", "Rank", "Economy", "Total"))

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
                      destfile = "Q3-3ed.csv")
Q3ED <- read.csv("Q3-3ed.csv")
names(Q3ED)


Q3ED2 <- data.table::fread("Q3-3ed.csv")
Q3_merge <- merge(Q3GDP, Q3ED2, by = "CountryCode")
Q3_merge <- Q3_merge %>% arrange(desc(Rank))
Q3_merge
nrow(Q3_merge)
select(Q3_merge, Rank, Economy)[13, ]


4. #고소득 OECD, nonOECD의 평균 GDP 순위
names(Q3_merge)
Q3_merge["Income Group" == "High income: OECD", lapply(.SD, mean)
         , by = "Income Group"]


Q33<- Q3_merge %>%
        select("Rank", "Income Group") %>% 
        filter("Income Group" == "High income: OECD") %>%
        print 


gdp <- fread("Q3-3.csv", skip = 4, sep = ",", nrows = 190,
      select = c(1, 2, 4, 5), 
      col.names = c("CountryCode", "Rank", "Economy", "Total"))
ed <- fread("Q3-3ed.csv")

Q3_merge <- merge(gdp, ed, by = "CountryCode")
Q3_merge <- Q3_merge %>% arrange(desc(Rank))


5. library(dplyr)
Q3_merge$RankGroups <- cut(Q3_merge$Rank, breaks = 5)
vs <- table(Q3_merge$RankGroups, Q3_merge$`Income Group`)
vs
