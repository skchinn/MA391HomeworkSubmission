#### MA391 PROJECT HW ####
######## WEEK 2 ##########
##########################
### SELECTED PROBLEM 1 ###
##########################
library(ma391chinn)
library(pracma)
### PART A ####
lambda=3
w=0.25
f=function(x){c((-w*lambda*0.05*x[2]-lambda*(0.005)*x[1]*x[2])*((x[1]>0)*(x[2]>0)),
                (-w*0.05*x[1]-0.005*x[2])*((x[1]>0)*(x[2]>0)))}
pts=path(f,c(5,2),deltat=1)
plot(pts[,1],pts[,2],xlim=c(0,5),ylim=c(0,2))
### PART B ###
dds=function(w, lambda){
  f=function(x){c((-w*lambda*0.05*x[2]-lambda*(0.005)*x[1]*x[2])*((x[1]>0)*(x[2]>0)),
                  (-w*0.05*x[1]-0.005*x[2])*((x[1]>0)*(x[2]>0)))}
  x=c(5,2)
  pts=path(f,x,deltat=1)
  N=length(pts[,1])
  if (pts[N,1]>pts[N,2]){
    winner="R"
    hours=min(which(pts[,2]<0))-1
    forces=as.numeric(round(pts[N,1],1))
  }
  else{
    winner="B"
    hours=min(which(pts[,1]<0))-1
    forces=as.numeric(round(pts[N,2],1))
  }
  return(list(winner=winner,hours=hours,forces=forces))
}
w=c(0.1,0.2,0.25,0.5,0.75,0.9)
ans.winner=0
ans.hours=0
ans.forces=0
l=length(w)
i=6
while (i >=0){
  res=dds(w[i],3)
  ans.winner[i]=res$winner
  ans.hours[i]=res$hours
  ans.forces[i]=res$forces
  i=i-1
}
result=data.frame(weather=w,winner=ans.winner,hours=ans.hours,forces=ans.forces)
print(result)
### PART C ###
#Analysis on paper#
### PART D ###
w=c(0.1,0.2,0.5,0.75,0.9)
lam=c(1.5,2.0,3.0,4.0,5.0)
ans.winner=0
ans.hours=0
ans.forces=0
ans.cond1=0;ans.cond2=0
N=length(w)
for (i in N){
  for(j in l:length(lam)){
    res=dds(w[i],lam[j])
    idx=N*(i-1)+j
    ans.cond1[idx]=w[i]
    ans.cond2[idx]=lam[j]
    ans.winner[idx]=res$winner
    ans.hours[idx]=res$hours
    ans.forces[idx]=res$forces
  } 
}

result=data.frame(weather=ans.cond1,eff=ans.cond2,winner=ans.winner, hours=ans.hours, forces=ans.forces)
print(result[which(result$eff==5),])
print (result)

##########################
### SELECTED PROBLEM 2 ###
##########################
### PART A ###
lambda=2
f=function(x){c((-w*lambda*0.05*x[2]-lambda*(0.005)*x[1]*x[2])*((x[1]>0)*(x[2]>0)),
                (-w*0.05*x[1]-0.005*x[2])*((x[1]>0)*(x[2]>0)))}
## Sit 1: Commander does not hold 2/5 divisions ##
x=c(5,2)
forces=path(f,x,deltat=1)
sit1 = tail(forces)
sit1
## Sit 2: Commander holds 2/5 divisions until 2nd day ##
x=c(3,2)
forces=path(f,x,deltat=1,N=25)
x=tail(forces,1)+c(2,0)
forces=path(fx,deltat=1)
sit2 = tail(forces)
sit2
## Sit 3: Commander holds 2/5 divisions until 3rd day ##
x=c(3,2)
forces=path(f,x,deltat=1,N=25)
x=tail(forces,1)+c(2,0)
forces=path(fx,deltat=1)
sit3 = tail(forces)
sit3
sit1
sit2
sit3
### PART B ###
#Analysis on paper#
### PART C ###
relu=function(x){
  for (i in l:length(x)){
    if (x[i]<0){x[i]=0}
    
  }
  return(x)
}
t=c(1.2,-2.8,3,-10)
relu(t)

# Analysis on paper#
### PART D ###
simulate = function(lambda){
  f=function(x){c((-w*lambda*0.05*x[2]-lambda*(0.005)*x[1]*x[2])*((x[1]>0)*(x[2]>0)),
                  (-w*0.05*x[1]-0.005*x[2])*((x[1]>0)*(x[2]>0)))
    
    if (res[1]+x[1]<0){res[1]=-x[1]}
    if (res[2]+x[2]<0){res[2]=-x[2]}
    return(res)
  }
  
  x=c(5,2)
  force0=path(f,x,deltat=1,N=12)
  print(force1)
  x=tail(force1,1)+c(2,0)
  force1=path(f,x,deltat=1)
  hold1=tail(force1)[1]
  
  return(list(hold0=hold0,hold1-hold1,hold2=hold2))
  
}

lam=c(1.0,1.5,2.0,3.0,5.0,6.0)
ans.f0=0
ans.f1=0
ans.f2=0

for (i in length(lam)){
  res=simulate(lam[i])
  ans.f0[i]=res$hold0
  ans.f1[i]=res$hold1
  ans.f2[i]=res$hold2
}

result=data.frame(lambda=lam,f0=ans.f0,f1=ans.f1,f2=ans.f2)
print(result)

##########################
### SELECTED PROBLEM 3 ###
##########################
### PART A ###
x=c(5*.3,2*.65)
lambda=3
f=function(x){
  res=c((-w*lambda*0.05*x[2]-lambda*(0.005)*x[1]*x[2])*((x[1]>0)*(x[2]>0)),
        (-w*0.05*x[1]-0.005*x[2])*((x[1]>0)*(x[2]>0)))
  
  if (res[1]+x[1]<0){res[1]=-x[1]}
  if (res[2]+x[2]<0){res[2]=-x[2]}
  return(res)
}

battle=path(f,x,deltat=1)
print(battle)
### PART B ###
x=c(5,2)
sixHours=path(f,x,deltat=1,N=6)
print(sixHours)
x=tail(sixHours,1)
x[1]=.3*x[1];x[2]=.65*x[2]
battle2=path(f,x,deltat=1)
print(battle2)
### PART C ###
#Analysis on paper#
### PART D ###
nukesim=function(lambda,N,nuke){
  f=function(x){
    res=c((-w*lambda*0.05*x[2]-lambda*(0.005)*x[1]*x[2])*((x[1]>0)*(x[2]>0)),
          (-w*0.05*x[1]-0.005*x[2])*((x[1]>0)*(x[2]>0)))
    
    if (res[1]+x[1]<0){res[1]=-x[1]}
    if (res[2]+x[2]<0){res[2]=-x[2]}
    return(res)
    
  }
  x=c(5,2)
  b1=path(f,x,deltat=1,N=N)
  if (nuke){x=tail(b1,1)x[1]=0.3*x[1];x[2]=0.65*x[2]}
  b2=path(f,x,deltat=1)
  forces=tail(b2,1)
  if (forces[1]>forces[2]{winner="Red"}else{winner="Blue"})
    forces=round(forces,1)
  return (list(R=forces[1],B=forces[2],winner=winner))
  
}

N=seq(0,6,1)
lam=c(1.0,1.5,2.0,3.0,4.0,5.0,6.0)
ans.adv=0
ans.hour=0
ans.win=0
ans.red=0
ans.blue=0
for(i in l:length(lam)){
  for (j in l:length(N)){
    res=nukesim(lam[i],N[j],T)
    idx=(i-1)*length(N)+j
    ans.adv[idx]=lam[i]
    ans.hour[idx]=N[j]
    ans.win[idx]=res$winner
    ans.red[idx]=res$forcesans.blue[idx]=res$B
  }
}

for (i in l:length(lam)){
  idx=idx+1
  res=nukesim(lam[i],0,F)
  ans.adv[idx]=lam[i]
  ans.hour[idx]=NA
  ans.win[idx]=res$winner
  ans.red[idx]=res$forcesans.blue[idx]=res$B
  
}
result=data.frame(adv=ans.adv,hour=ans.hour,winner=ans.win,red=ans.red,blue=ans.blue)
print(result)
