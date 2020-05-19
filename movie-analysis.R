getwd()
setwd("C:\\Users\\lenovco\\Onedrive\\Desktop\\R Datasets")
getwd()
movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillion",
                    "Year")
head(movies)
str(movies)
summary(movies)
factor(movies$Year)
factor(movies$Genre)

movies$Year <- factor(movies$Year)
summary(movies)
movies$Genre <- factor(movies$Genre)
summary(movies)

#-----------------------Aesthetics
library(ggplot2)

a1 <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating))
#Adding Geometry
a2 <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()
#Adding Color
a3 <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, color=Genre)) + 
  geom_point()
#Adding size
a4 <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, color=Genre, 
                          size=BudgetMillion)) + 
  geom_point()
a4
#>>>> This is number 1 (we will improve it)

p<-ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, color=Genre, 
                             size=BudgetMillion))
#point
p +geom_point()
#lines
p+ geom_line()
#multiple layers
p+ geom_line()+ geom_point()

#---------------------Overriding aesthetics
q <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, color = Genre, size=BudgetMillion))
# add geom layer
q+geom_point()

#overriding aesthetics
#example 1
q + geom_point(aes(size = CriticRating))
#example 2
q+ geom_point(aes(color = BudgetMillion))
# q remains same 
q + geom_point()
# example 3
q+ geom_point(aes( x= BudgetMillion)) + xlab("Budget in million $") #>>>>> Second chart
# example 4 
q+ geom_line()+ geom_point()
# reduce line size 
p+ geom_line(size=1)+ geom_point()
#--------------------------------------------------- mapping vs setting 
r<- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()
# add color
#1 Mapping (what we have done so far)
r+geom_point(aes(color=Genre))
#2 Setting 
r+ geom_point(color="Darkgreen")
#ERROR
#r+geom_point(aes(color="Darkgreen"))
#If you want to map the color to a variable then use #1 or if you want to set the 
#color to a particular value for the whole chart then use the method #2


#Change size section 

#1 Mapping
r + geom_point(aes(size=BudgetMillion))
#2 setting
r + geom_point(size=10)
#3 ERR 
r + geom_point(aes(size=10))

#---------------------------------------Histograms and Density Charts
s <- ggplot(data = movies, aes(x=BudgetMillion))
s + geom_histogram(binwidth=10)

#add color
s + geom_histogram(binwidth=10,aes(fill=Genre))
#add border
s + geom_histogram(binwidth=10,aes(fill=Genre), colour="Black")
#>>>>>>>>>>>>3 (we will improve it)

#sometimes you may neeed density charts
s+ geom_density(aes(fill=Genre))
s+ geom_density(aes(fill=Genre), position = "stack")

#-----------------Starting Layer tips
t <- ggplot(data = movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, fill="White", color="Blue")

#another way
t <- ggplot(data=movies)
t+ geom_histogram(binwidth = 10, aes(x=AudienceRating), fill="White", color="Blue")
#>>>>>4
t+ geom_histogram(binwidth = 10, aes(x=CriticRating), fill="White", color="Blue")
#Set the aesthetics in the starting if you are not going to change the axis variables
#that often. If you are going to change the axis variables often, then just
#set the ggplot with the data and then create the aesthetics later
# do not rely on overriding 
#>>>>>>5
#if you want to use different datasets then just initialize the object with 
#ggplot() then set the dataset every time using layers


#--------------------Statistical transformations
?geom_smooth

u<- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre))
u +  geom_point() + geom_smooth(fill=NA)

#Boxplots 
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,color=Genre))
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2)+ geom_point()
#tip/hack :
u + geom_boxplot(size=1.2) + geom_jitter() #jitter doesn't  have accuracy, 
#jitter just throws the points around just to aid the eyes 

u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5) #much better to present 
#>>>>>>>>>>6

u <- ggplot(data=movies, aes(x=Genre, y=CriticRating,color=Genre))
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#--------------------- Using Facets 
v <- ggplot(data = movies, aes(x=BudgetMillion))
v + geom_histogram(binwidth=10, aes(fill=Genre), color="Black")
#facets 
v + geom_histogram(binwidth=10, aes(fill=Genre), color="Black") +
  facet_grid(Genre ~., scales = "free")
#scatterplots 
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre))
w + geom_point(size = 3)

#facets 
w1 <- w + geom_point(size=3) + facet_grid(.~Year)
w2 <- w + geom_point(size=3) + facet_grid(Genre~Year)
w3 <- w + geom_point(size=3) + geom_smooth() + facet_grid(Genre~Year)
w4 <- w + geom_point(aes(size=BudgetMillion)) + geom_smooth() + facet_grid(Genre~Year)
#1>>>>>>> (still we will improve)

#--------------- Co ordinates 
#today: 
#limits 
#zoom 

m <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, size=BudgetMillion,
                               color=Genre))
m + geom_point()

m + geom_point() + xlim(50,100) + ylim(50,100)
#wont work well 
n <- ggplot(data = movies,aes(x=BudgetMillion))
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") + ylim(0,50)
# instead zoom 
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") + 
  coord_cartesian(ylim = c(0,50))

# improve no 1
w + geom_point(aes(size=BudgetMillion)) + geom_smooth() + facet_grid(Genre~Year) + 
  coord_cartesian(ylim = c(0,100))
#-------------------------------Theme 
o <- ggplot(data= movies, aes(x=BudgetMillion))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")
h
#add axes labels : 

#label formatting 
h + xlab("Money Axis") + ylab ("Number of Movies")+
  theme(axis.title.x = element_text(color="Darkgreen", size=30), 
        axis.title.y= element_text(color="Red", size=30))
#tick mark formatting 
h + xlab("Money Axis") + ylab ("Number of Movies")+
  theme(axis.title.x = element_text(color="Darkgreen", size=30), 
        axis.title.y= element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))
#legend formatting 
h + xlab("Money Axis") + ylab ("Number of Movies")+
  theme(axis.title.x = element_text(color="Darkgreen", size=30), 
        axis.title.y= element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1))
#title formatting 
h + xlab("Money (in millions)") + ylab ("Number of Movies")+
  ggtitle("Movie Budget Distribution") + 
  theme(axis.title.x = element_text(color="Darkgreen", size=20), 
        axis.title.y= element_text(color="Red", size=20),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1), 
        plot.title = element_text(color="Darkblue", size=30))
#Homework section 
hwmovies <- read.csv("Section6HomeworkData.csv")
head(hwmovies)
colnames(hwmovies) <- 
  c("DayOfWeek", "Director", "Genre", "Title", "ReleaseDate","Studio","AdgustedGross$Mill",
    "BudgetinMill","Gross$Mill","IMDbRaing","MovieLensRating",
    "OverseasGross$Mill","OverseasPercentage","Profit$Mill","ProfitPercentage",
    "Runtime","US$Mill", "GrossPercentageUS")
filter1 <- (hwmovies$Genre== "action") | (hwmovies$Genre == "adventure") | (hwmovies$Genre == "comedy") | (hwmovies$Genre == "drama")
filter2 <- (hwmovies$Studio == "Buena Vista Studios") | (hwmovies$Studio == "Fox") | (hwmovies$Studio == "Paramount Pictures") | (hwmovies$Studio == "Sony") | (hwmovies$Studio == "Universal") | (hwmovies$Studio == "WB")

hwmovies2 <- hwmovies[filter1 & filter2,]
plot2 <- ggplot(data = hwmovies2, aes(x=Genre, y=GrossPercentageUS))
plot2 + geom_jitter(aes(size=BudgetinMill, color=Studio))+geom_boxplot(alpha=0.7,outlier.colour = NA)


