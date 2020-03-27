#### HOMEWORK CHAPTER 7

#### PROBLEM 5 ####

#### PROBLEM 6 ####

#### PROBLEM 11 ####
# 16 Bombers
# 2 Options: Low - air defense missile exposure
#            High - surface to air missile exposure
# 3 Stages: 1) Detect Target    2) Acquire Target (Lock on)    3) Hit Target
# Firing Rate: Guns 20 shells/min Missile installation 3/min

## Part A ##
# L = time flying low (minutes)
# H = time flying high (minutes)
# Goal: maximize the number of bombers that survive (I'm going to flip this and try to minimize the 
# probability that a bomber is detected, acquired, and hit)
# Pall = probability a bomber is detected, acquired as a target, and hit
Pall.low = 0.036
Pall.high = 0.498
# The probability that a bomber is detected, acquired as a target and hit while flying low is 0.036.
# The probability that a bomber is detected, acquired as a target and hit while flying high is 0.498.
# In order to maximize the number of bombers that survive, the optimal flight path is the least
# casualty producing. This would mean the bombers should fly low.

## Part B ##
# D = chance of bomber to destroy the target
D = 0.70
# Goal: determine the chances of success (Target destroyed for this mission)
# S = the chance of success
# Thought process: the only time D is applicable is before the bomber meets Pall.low or Pall.high (i.e.
# before it itself is hit), the chance of success is the probability the bomber is NOT detected/acquired/hit
# times D
not.Pall.low = 1 - Pall.low
not.Pall.high = 1 - Pall.high
S.low = not.Pall.low * D
S.high = not.Pall.high * D
# S.low = 0.6748
# S.high = 0.3514
# Since we determined the optimal path for this mission is to fly low, the probability that the bomber
# successfully makes it to the target without being detected/acquired/hit and then destroys the target
# is 0.6748. 

## Part C ##
# Goal: determine the minimum number of bombers necessary to guarantee a 95% chance of success
# Thought: If each bombers success is individual of the others then we could determine the number 
# necessary by solving 0.6748 * B = .95, where B is the number of bombers
.95/.6748 # = 1.4
# Since we can't have .4 of a bomber, the minimum number necessary is 2.

## Part D ##
# D = 0.7 that an individual bomber can destroy the target
# ((not.Pall.low) * D) * B = 0.95  -- look at the sensitivity when changing D
((not.Pall.low) * D) * B = 0.95
B=1.4
D=.6
((not.Pall.low) * D) * B # = 0.80976
D=.65
((not.Pall.low) * D) * B # = 0.87724
D=.675
((not.Pall.low) * D) * B # = 0.91098
D=.69
((not.Pall.low) * D) * B # = 0.931224
D=.71
((not.Pall.low) * D) * B # = 0.958216
D=.75
((not.Pall.low) * D) * B # = 1.0122
D=.80
((not.Pall.low) * D) * B # = 1.07968

# While the values do change when hovering around a 70% destroy chance, they don't move too much
# and all around still have high success rates for the mision.

## Part E ##
# Bad weather decreases Pdetect and D. They are reduced in the same proportion. 
# Pdetect is cut in half, now is 0.45. This makes the Pall.low.new = 0.018
## Probability bomber is taken down = 0.018
1-0.018 # = 0.982
# D is cut in half, now 0.35
0.982*.35 = 0.3437
## Probability target is successfully destroyed = 0.3437
# The bomber defeating the target has the advantage.