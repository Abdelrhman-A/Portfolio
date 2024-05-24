library(dplyr)
library(arules)
path <- readline("Enter the file path: ")
dataB <- read.csv(path)
#dataB
pie(
    x = table(dataB$paymentType),
    main = "Compare cash and credit totals")
    table(dataB$paymentType)
    
    ageB <- group_by(dataB,age)
    ageB <- summarise(ageB,totalspending=sum(total))
    #ageB <- arrange(ageB,desc(totalspending))
    #ageB

plot(
    x =ageB$age,
    y = ageB$totalspending,
    main = "Total spending vs. Age", 
    xlab = "Age",
    ylab = "Total"
  )

  cityspending <- group_by(dataB,city)
  cityspending <- summarise(cityspending,totalspending=sum(total))
  cityspending <- arrange(cityspending,desc(totalspending))
barplot(
    height = cityspending$totalspending,
    name = cityspending$city,
    col = "orange",
    main = "City total spending",   
    ylab = "Total spending",
    las  = 3
    )

boxplot(
    x = dataB$total,
    main = "Distribution of Total Spending",
    xlab = "Total Spending"
    )

par(mfrow = c(2,2))
pie(
      x = table(dataB$paymentType),
      main = "Compare cash and credit totals")
plot(
      x = ageB$age,
      y = ageB$totalspending,
      main = "Total spending vs. Age", 
      xlab = "Age",
      ylab = "Total")
  cityspending <- group_by(dataB,city)
  cityspending <- summarise(cityspending,totalspending=sum(total))
  cityspending <- arrange(cityspending,desc(totalspending))
barplot(
      height = cityspending$totalspending,
      name = cityspending$city,
      col = "orange",
      main = "City total spending",   
      ylab = "Total spending",
      las  = 3)
boxplot(
      x = dataB$total,
      main = "Distribution Total Spending",
      xlab = "Total Spending")


dataB_filter <- select(dataB,age,total)
n <- as.numeric(readline("ENTER NUMBER OF GROUPS (FROM 2 TO 4): "))

if(n==2 | n==3 | n==4){
  groups <- kmeans(dataB_filter, centers = n)
  
  dataB_filter2 <- select(dataB,customer,age,total)
  table <- cbind(dataB_filter2,groups$cluster)
  table1 <- data.frame(table)
  print(paste(table1))
  write.csv(table1)
  clustering <- readline("Enter the saving path for the clustring data:  ")
  write.csv(table1, clustering)
  print("Successful")
}else{
  print(paste("Wrong Number! because a Number must be (FROM 2 TO 4) Only"))
}
transacions <- select(dataB, items)
tablepath <- readline("Enter the table saving path: ")
write.table(transacions, tablepath , row.names = FALSE, col.names= FALSE , quote = FALSE )
tdata <-read.transactions(tablepath , sep=",")

Support <- as.numeric(readline("Enter the minimum support: "))
if (Support >=0.001 & Support < 1){
  Confidince <- as.numeric(readline("Enter the minimum confidince: "))
  
  if (Confidince >=0.001 & Confidince < 1 ){
    apriori_rules <- apriori(tdata,parameter = list(supp = Support, conf = Confidince,minlen=2))
    inspect(apriori_rules)
  }
}else{ 
  print("Wrong Number! because a Number must be (FROM 0.001 TO 1) Only")
}