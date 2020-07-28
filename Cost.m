function z=Cost(k,R,xx,params)
 
m=.1;
M=.5;
L=.5;
I=.0021;
g=9.8;

x=params.x;
t=params.t;
xd=params.xd; 
td=params.td;

dt=0.01;

for i=0:xx*100
cost=0;
  
   
    
  q=[x;t;xd;td];
  u=-k*q;

    if(isinf(t))
     cost=200+i;
        break;
    else if t >=1.5708 
        cost= 100+i;
        break;
    end
    end
  
  
  
  A=[M+m m*L*cos(t);m*L*cos(t) I+m*L*L];
  J=[u+m*L*td*td*sin(t);m*g*L*sin(t)];

  qdd=A\J;
        
   
    
   x=x+xd*dt;    
   t=t+td*dt;   
   xd=xd+qdd(1)*dt;
   td=td+qdd(2)*dt;
   
   cost=cost+(x^2+t^2+xd^2+td^2); 
end



z=cost;