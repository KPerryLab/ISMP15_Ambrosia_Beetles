library(dplyr)			
insect<-c("Xc","Am")			
temp<-c("40","40","44","44","48","48","52","52","56","56","60","60")
temp2<-c("40","40","41","41","42","42","43","43","44","44")
thermo<-c("0A","1A","2A","3A","4A","5A","6A","7A","0B","1B","2B","3B")
thermo2<-c("0A","1A","2A","3A","4A","5A","0B","1B","2B","3B")
slot<-c("X1","X2","X3","X4","Y1","Y2","Y3","Y4","Z1","Z2","Z3","Z4")
slot2<-c("X1","X2","X3","X4","Y2","Y3","Z1","Z2","Z3","Z4")
df<-data.frame(temp, insect)			
set.seed(123)			

random_assign<-df %>% group_by(temp) %>% slice(sample(c(1,2),2))			
data.frame(thermo=sample(thermo),
           temp=rep(temp, length=length(thermo)))
data.frame(slot=sample(slot),
           thermo=rep(thermo, length=length(thermo)))

data.frame(thermo=sample(thermo2),
           temp=rep(temp2, length=length(thermo2)))
data.frame(slot=sample(slot2),
           thermo=rep(thermo2, length=length(thermo2)))
