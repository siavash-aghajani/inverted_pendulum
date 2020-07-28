function plotava(k,R,xx,params)

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
    
    
  q=[x;t;xd;td];
    u=-k*q;
    
    qdd=([M+m m*L*cos(t);m*L*cos(t) I+m*L*L])\...
        ([u+m*L*td*td*sin(t);m*g*L*sin(t)]);
   
    
   x=x+xd*dt;    
   t=t+td*dt;   
   xd=xd+qdd(1)*dt;
   td=td+qdd(2)*dt;
  plot([x x+2*sin(t)],[0 2*cos(t)],'k','LineWidth',3);% avang
  hold on
  plot([x x],[-1 0],'b','LineWidth',50)%badane
  %plot([x+1 x-1],[-2 -2],'m*','LineWidth',10)%charkh
%  text(-1,3,'siavash Aqajani','Color','red','FontSize',14)
  axis([-5  5   -2   4 ]) 
   pause(.02) 
   hold off
  
end


