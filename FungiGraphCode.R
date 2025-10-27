
bolts<-read.table(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/Fungi/Fungibolts.csv", header=TRUE, sep=",")
fungi.temp<-read.table(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/Fungi/FungalAnalysis.csv", header=TRUE, sep=",")

pdf(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/ISMP15_Ambrosia_Beetles/FungalBoltsGraphESA.pdf", width=7, height=5)

ggplot(data=bolts, mapping=aes(x=Temp, y=Recorded, col=F.NF))+
  geom_point()+
  geom_smooth(se=FALSE)+
  labs(x="Oven Temperature (°C)",
       y="Temp. Inside Bolt (°C)")+
  scale_color_manual(values=c("#00B6EB", "#F8766D"), name="Group", labels=c("Fungi","No Fungi"))+
  theme_minimal()+
  theme(axis.text=element_text(size=12))+theme(axis.title=element_text(size=13))
dev.off()


pdf(file="C:/Users/jessi/OneDrive - The Ohio State University/Ambrosia 2024-2025/ISMP15_Ambrosia_Beetles/FungalPlateGraphESA.pdf", width=7, height=5)

ggplot(fungi.temp, aes(x=Species, y=Temp.ave, fill=Area))+ 
  geom_boxplot()+
  geom_point(position = position_jitterdodge(), shape=21)+
  labs(x="Species",
       y="Average Temperature (°C)",
       fill="Area of Plate")+
  theme_minimal()+
  theme(axis.text=element_text(size=12))+theme(axis.title=element_text(size=13))
dev.off()

