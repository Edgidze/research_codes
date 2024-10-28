
% Programe to estimate 5 by 5 Hawkes model with simulated latency 

function estimate_latency_sim_2024_5d()

  clear all  
  load simdata2025 % load simpulated data

  lag=50; % number of intervals in the kernel
  x=(1:lag);
  ndays = 500; % number of replications
  results=cell(ndays,4); % Allocate memory for results

  % Define GAMMA kernel
  options = optimset('Display','off');
  modelFun3 = @(p,x) p(1).*((x.^(p(3)-1).*exp(-x./p(2)))./((p(2)^p(3))*gamma(p(3))));
  startingVals3 = [0.8 1.2 4]; 
  lb3 = [0.01 1 1]; 
  ub3 = [4 250 95];
  
  % Estimate kernels for each replication
  for k=1:ndays

     % Select replication data 
     dat1 = N150(:,k); % N1 N110 N150
     dat2 = N250(:,k); % N2 N210 N250
     dat3 = N350(:,k); % N3 N310 N350
     dat4 = N450(:,k); % N4 N410 N450
     dat5 = N550(:,k); % N5 N510 N550
     
     % Get 5 by 5 kernel
     ker_all=sim5m(dat1,dat2,dat3,dat4,dat5,lag);
     % Exclude zero lag
     ker_all(1,:)=0;
     results{k,1} = ker_all;

     % Estimate parameters - latencies are in lat3
     p3=zeros(25,3);
     lat3=zeros(25,1);
     Cov3 = cell(1,25);
     for s=1:25         
         % Model with GAMMA kernel
         [p3(s,:),~,res,~,~,~,J] = lsqcurvefit(modelFun3,startingVals3,x,ker_all(:,s)',lb3,ub3,options);        
         MSE = mean(res.^2);
         Cov3{1,s} = full(inv(J'*J)*MSE);
         lat3(s)=p3(s,2)*(p3(s,3)-1);
     end
     
     results{k,2}=p3;
     results{k,3}=lat3;
     results{k,4}=Cov3;    
     k        
  end              
end
 
function ker_b=sim5m(data1,data2,data3,data4,data5,lag)

% Compute expectations
dat = [data1 data2 data3 data4 data5];

 % Inputs
    p = lag;               % Number of lags 
    y=[dat];
    d = size(y,2);
 
    % Estimate the model with p lags    
    step = size(y,2)*p;
    ymat=zeros(size(y,1)-p,step+1);
    ymat(:,1)=1;
    k=2;
    for i=1:p
        ymat(:,k:k+d-1)=trimr(y,p-i,i);
        k=k+d;
    end
          
    % Estimate
    bar    = ymat\trimr(y,p,0); 
    
    irfs=zeros(p,25); % dim 5 by 5
    k=1;
    for i=2:5:5*p+1
        irfs(k,:)=reshape(bar(i:i+4,:),1,25);
        k=k+1;
    end

    ker_b = irfs;
end

%=========================================================================
% Returns a matrix (or vector) stripped of the specified rows
%
%   Inputs: 
%             x  = input matrix (or vector) (n x k)
%             rb = first n1 rows to strip
%             re = last  n2 rows to strip
%
%  Mimics the Gauss routine. 
%=========================================================================
function z = trimr(x,rb,re)
    n = length(x);
    if (rb+re) >= n; 
        error('Attempting to trim too much');
    end       
    z = x(rb+1:n-re,:);    
end

