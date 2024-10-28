
% Programe to estimate 4 by 4 Hawkes model with latency for CANADA and US
% (trades+m/q events)

function estimate_latency_2024_4d()

  clear all  
  load cleandata2025b

  lag=50; % 50 milliseconds (msec)
  x=(1:lag);
  T = 21600000; % number of msec in a trading day
  ndays = 405; % Number of days
  d = unique(CA1(:,1)); % list of days
  results=cell(ndays,4); % allocate memory for results

  % Define GAMMA kernel
  options = optimset('Display','off');
  modelFun3 = @(p,x) p(1).*((x.^(p(3)-1).*exp(-x./p(2)))./((p(2)^p(3))*gamma(p(3))));
  startingVals3 = [0.8 1.2 4]; % 
  lb3 = [0.01 1 1]; % 
  ub3 = [4 250 95]; % 
  
  % Estimate kernels for each day
  for k=1:ndays

     % US and Canada - select one day
     ind2=(CA1(:,1)==d(k) );
     CAdt=CA1(ind2,2);
     ind2=(CAq(:,1)==d(k) );
     CAdq=CAq(ind2,2);
     ind2=(US1(:,1)==d(k) );
     USdt=US1(ind2,2);
     ind2=(USq(:,1)==d(k) );
     USdq=USq(ind2,2);
     
     % Get 4 by 4 kernel
     ker_all=sim4m(CAdt,CAdq,USdt,USdq,lag,T);
     % Exclude zero lag
     ker_all(1,:)=0;
     results{k,1} = ker_all;

     % Obtain parameter estimates and latencies (lat3)
     p3=zeros(16,3);
     lat3=zeros(16,1);
     Cov3 = cell(1,16);
     for s=1:16         
         % Model with GAMMA kernels
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
 
function ker_b=sim4m(data1,data2,data3,data4,lag,T)

% Compute expectations
dbin1 = zeros(T,1);
dbin1(data1)=1;
dat1 = dbin1;

dbin2 = zeros(T,1);
dbin2(data2)=1;
dat2 = dbin2;

dbin3 = zeros(T,1);
dbin3(data3)=1;
dat3 = dbin3;

dbin4 = zeros(T,1);
dbin4(data4)=1;
dat4 = dbin4;

dat = [dat1 dat2 dat3 dat4];

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
    
    irfs=zeros(p,16); % dim 4 by 4
    k=1;
    for i=2:4:4*p+1
        irfs(k,:)=reshape(bar(i:i+3,:),1,16);
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
%  
%=========================================================================
function z = trimr(x,rb,re)

    n = length(x);
    if (rb+re) >= n; 
        error('Attempting to trim too much');
    end
       
    z = x(rb+1:n-re,:);
    
end
  

