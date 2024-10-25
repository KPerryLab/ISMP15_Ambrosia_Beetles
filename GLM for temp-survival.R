#Uploading/subsetting
logreg_full<-read.csv(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/Upper Lethal Limit Trials/Fulldataprelim.csv", header=TRUE, sep=",")
str(logreg_full)
logreg_full$Survival_0min<-as.factor (logreg_full$Survival_0min)
levels(logreg_full$Survival_0min)
summary(logreg_full)
subset_logregfull<-subset(logreg_full, Species=="X. crassiusculus")
summary(subset_logregfull)

#Model: Very big differences in p-values between summary and anova.
library(car)
model2<-glm(Survival_0min~Temp, data=subset_logregfull, family=binomial(link='logit'))
summary(model2)
Anova(model2)

#Graph
ggplot(subset_logregfull, aes(x=Temp, y=Survival_0min)) +
  geom_point() +
  geom_smooth(method = "glm", 
              method.args = list(family = (link='logit')), 
              se = FALSE) 
