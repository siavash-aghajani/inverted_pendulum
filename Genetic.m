   
clear all;
close all;
clc



prompt = {'Enter R:','Enter stop time:','Enter x(0)','Enter tetha(0)','Enter xd(0)','Enter tethad(0)'};
dlg_title = 'conditon of genetic algorythm';
def={'2','5','1','pi/5','1','1'};
num_lines = 1;

options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
Answer = inputdlg(prompt,dlg_title,num_lines,def,options);

R=str2double(Answer(1));
xx=str2double(Answer(2));
params.x=str2double(Answer(3));
params.t=str2num(Answer{4});
params.xd=str2double(Answer(5));
params.td=str2num(Answer{6});



  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt = {'Enter n generation:','Enter n population:','Enter percent of crossover','Enter percent of mutation','Enter min x tetha xd tethad','Enter max x tetha xd tethad'};
dlg_title = 'conditon of genetic algorythm';
def={'100','100','.8','.1','[-100  -100 -100  -100]','[100 100 100  100]'};
num_lines = 1;

options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer = inputdlg(prompt,dlg_title,num_lines,def,options);



nGeneration =str2double(answer(1));
nPop=str2double(answer(2));
pc=str2double(answer(3));
pm=str2double(answer(4));
nc=round(pc*nPop/2);



xmin=str2num(answer{5});
xmax=str2num(answer{6});
nVar=4;

EmptyChromosome.x=[];
EmptyChromosome.Cost=inf;
pop=repmat(EmptyChromosome,nPop,1);
BestCost=[];

% Generate Initial Population
for i=1:nPop
    pop(i).x=rand(1,nVar).*(xmax-xmin)+xmin;
    pop(i).Cost=Cost(pop(i).x,R,xx,params);
end
disp('Initial Population finished');
% Main Loop
for i=1:nGeneration
    popc=repmat(EmptyChromosome,nc*2,1);
    for j=1:nc
        parent1=Select(pop);
        parent2=Select(pop);
        [child1,child2]=Crossover(parent1,parent2,R,xx,params);
        if ( rand<=pm)
            child1=Mutation(child1,xmin,xmax,nVar,R,xx,params);
        end
        if ( rand<=pm)
            child2=Mutation(child2,xmin,xmax,nVar,R,xx,params);
        end
       
        popc(2*j-1)=child1;
        popc(2*j)=child2;
    end
    [~,ind]=sort([pop(:).Cost]);
    BestCost(i)=pop(ind(1)).Cost;
    BestSolution=pop(ind(1)).x;
    pause(.1)
    disp(sprintf('Generation %d: Best Cost=%f',i,BestCost(i)))
    
    pop=[popc; pop(ind(1:(nPop-nc*2)))];
end
disp('BestSolution')
disp(BestSolution)
plotava(BestSolution,R,xx,params)
