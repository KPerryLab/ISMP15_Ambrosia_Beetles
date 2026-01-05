#Specific ULT for Adult Crass

#Uploading/subsetting
logreg_spec<-read.csv(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/Upper Lethal Limit Trials/Spreadsheets_for_analysis/SpecificXc_csv.csv", header=TRUE, sep=",")
str(logreg_spec)
summary(logreg_spec)

library(tidyverse)
library(car)

plot(Survival_0min~jitter(Temp,2), data=logreg_spec, ylab="Survival (Dead/Alive)", xlab="Temperature")

# fit model
fit3 <- glm(Survival_0min~Temp,data=logreg_spec,family=binomial(link=logit))
summary(fit3)

# assess fit
plot(Survival_0min~jitter(Temp,2), data=logreg_spec, ylab="Survival (Dead/Alive)", xlab="Temperature")
new_data2 <- as.data.frame(seq(40,44,1))
colnames(new_data2) <- "Temp"
lines(new_data2$Temp,predict(fit3,newdata=new_data2,type="response"))

#Make Pretty + Save plot as clear PDF
pdf(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/ISMP15_Ambrosia_Beetles/Graph_temp_assay_crass_adult_maple.pdf", width=6.5, height=4.25)

ggplot(logreg_spec, aes(x=Temp, y=Survival_0min))+
  geom_jitter(height=0)+
  xlab("Temperature (C)")+
  ylab("Survival (Dead/Alive)")+
  geom_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)+
  geom_hline(data=data.frame(c(0.50)), aes(yintercept=c(0.50)), color="darkgray", linetype="dashed")+theme_classic()

dev.off()
#################################################################################
#Full UTL for Adult Crass

library(tidyverse)
library(car)
#Uploading/subsetting
logreg_full<-read.csv(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/Upper Lethal Limit Trials/Spreadsheet_for_analysis/Fulldataprelim.csv", header=TRUE, sep=",")
str(logreg_full)
subset_logregfull<-subset(logreg_full, Species=="X. crassiusculus")
summary(subset_logregfull)
str(subset_logregfull)

#Plot.
plot(Survival_0min~jitter(Temp,2), data=subset_logregfull, ylab="Survival (Dead/Alive)", xlab="Temperature")

#Fit Model - P-values are essentially "1", thinks it has perfect separation?
# Also get this warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
fit1 <- glm(Survival_0min~Temp,data=subset_logregfull,family=binomial(link=logit))
summary(fit1)
#ANOVA for testing - gives signficant P-value
Anova(fit1)

#Assess fit 
plot(Survival_0min~jitter(Temp,2), data=subset_logregfull, ylab="Survival (Dead/Alive)", xlab="Temperature")
new_data <- as.data.frame(seq(40,60,4)) 
colnames(new_data) <- "Temp"
lines(new_data$Temp,predict(fit1,newdata=new_data,type="response"))

#Testing for perfect separation (It is perfectly separated)
test <- subset_logregfull[,c("Survival_0min", "Temp")]
fake <- cbind.data.frame(Survival_0min = c(1,1,1,1), Temp = c(44,44.5,45,46))
test <- rbind.data.frame(test,fake)
fit2 <- glm(Survival_0min~Temp, data=test, family=binomial(link=logit))
summary(fit2)

#Make Pretty
ggplot(subset_logregfull, aes(x=Temp, y=Survival_0min))+
  geom_jitter(height=0)+
  xlab("Temperature")+
  ylab("Survival (Dead/Alive)")+
  geom_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)+
  geom_hline(data=data.frame(c(0.50)), aes(yintercept=c(0.50)), color="darkgray", linetype="dashed")
