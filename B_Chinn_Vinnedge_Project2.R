library(tidyverse)

# Data Wrangling
data = read.csv("C:/Users/Samantha Chinn/OneDrive - West Point/MA391 - Math Modeling/Project 2/project2_data.csv")
data %>% rename(training.time = Range.Train.Time..hours.,
                navigate.time = Time.for.a.Crew..To.Navigate.Course.min.,
                prob.success = Pass.Probability..Prob.of.Success.of.a.Crew.going.through.course.) -> data
data %>% mutate(training.mins = training.time*60,
                total.time = training.mins+navigate.time) -> data
# Some givens:
#          max time = 12 hours / day
#          balance training and operational time
#          4 operational tanks (always have 1 crew)
#          triangular distribution (see handout)

# Assumptions:
#          training time accounts for both positions (gunner/driver)
#          all crews receive the same amount of training time (additional repetitions do not get more training time)

########## Problem 1 #####################################################################
navigate.model = lm(navigate.time ~ training.time, data = data);summary(navigate.model)
pass.model = lm(prob.success ~ training.time, data = data);summary(pass.model)

# We messed around with some numbers (720 minutes in a training day):
# 2.3 training hours = 716.22 total minutes
# 2.5 training hours = 715.8 total minutes  ################
# 2.6 training hours = 719.04 total minutes
# 2.8 training hours = 722.07 total minutes
# 2.5 looks the best

# We want to train for 2.5 hours.
# Calculate navigate time off of 2.5 hours of training.
ggplot(data=data) + geom_point(aes(x=training.time,y=navigate.time))
nav.time = 9.95773 - 0.68789*(2.5)
print(nav.time) # 8.238005 minutes per group

# Calculate predicted probability of success off of 2.5 hours training time:
prob.1 = 0.6511726 + 0.0500404*(2.5)
print(prob.1) # 0.776

########## Problem 2 ####################################################################
# Probability distribution based off of our nav.time
library(EnvStats)
set.seed(10) 
random.dist = rtri(10000, nav.time-2, nav.time+2, nav.time) 
random.distro = data.frame(random.dist)
# Histogram of 10,000 random variates
ggplot(data = random.distro) + geom_histogram(aes(x=random.dist)) + 
  labs(x="Random Variates",title="Triangular Distribution")

########## Problem 3 #################################################################
# With average time 8.24 minutes, probability is 0.776
# For loop, runif() for 0 to 1. Count if it is between 0 and 0.776.
# Initialize 0 crews qualified at start of day
qualified = 0
# Initialize 0 iterations have gone through at start of day
iterations = 0
# Probability of failure/additional repetition
p=1-prob.1
# Initialize data frame to record data
record = data.frame(iterations=0,probability=0,qualified=qualified)
# While the number of qualified crews is less than 7 continue to randomize a 
# probability that they qualify assuming they have the same amount of train time
while (qualified<57){
  probability = runif(1)
  if (probability<p){qualified=qualified}else{qualified=qualified+1}
  iterations=iterations+1
  record = rbind(record,data.frame(iterations=iterations,
                                   probability=probability,
                                   qualified=qualified))
  }
print(record)

# Took 69 iterations.

# Problem 4 ##############################################################
summary(navigate.model)
# Training time is 2.5 hours
# Average navigating time is 8.24 minutes
# 69 repetitions are predicted to qualify 95% of soldiers
# Time to reach 95% qualified
nav.time*69 # 568.4223 minutes

# Checking the Schedule
# Available minutes in the day
(12*60) # 720
# Minutes remaining after training
720-(60*2.5) # 570
# Minutes remaining after training everyone
570-568.4223 # 1.5777

# Verify with a simulation
# Initialize 0 crews qualified at start of day
qualified = 0
# Initialize 0 iterations have gone through at start of day
iterations = 0
# Probability of failure/additional repetition
p=1-prob.1
# Time Left
time.left = (12-2.5)*60
# Initialize data frame to record data
record = data.frame(iterations=0,probability=0,qualified=qualified,time.left=time.left)
# While the number of qualified crews is less than 7 continue to randomize a 
# probability that they qualify assuming they have the same amount of train time
while (qualified<57){
  probability = runif(1)
  if (probability<p){qualified=qualified}else{qualified=qualified+1}
  iterations=iterations+1
  time.left = time.left - nav.time
  record = rbind(record,data.frame(iterations=iterations,
                                   probability=probability,
                                   qualified=qualified,
                                   time.left=time.left))
}
print(record)

# Problem 5 #############################################################################
# Create matrix based on average times, break and fix
a=matrix(c(-1,1.5,1,-1.5,1,1),nrow=3,byrow = T)
print(a)
b=matrix(c(1,1,1))
print(b)
solve(t(a)%*%a,t(a)%*%b)
