% Plot simulated results 2024
function plotsim_results24()

% Simulation plots
  load resultssim24

  % Plot all kers with confidence intervals and the following theoretical
  % and estimated parameters
  simpars1=[0.152 9 1 ; 0.16 11 1.5 ; 0.14 11.0 1.2 ; 0.255 6 2; 0.145 10 1.1; ...
            0.149 6 2 ; 0.153 12 2  ; 0.24 11 1.5   ; 0.15 10 2.1; 0.251 9 1.7; ...
            0.144 8 1.8; 0.25 9 1.2 ; 0.1465 10 1.6 ; 0.2455 11 1.8; 0.1515 10 1.6; ...
            0.255 9 2  ; 0.145 8 1.2; 0.1356 7 1.3  ; 0.245 9 1.5 ; 0.155 8 2 ;...
            0.245 10.1 1.5; 0.154 6.5 2 ; 0.145 7 1.5 ; 0.257 6.6 2.1; 0.148 8 1.8];

  estpars1=[0.145 7.9 1.08 ; 0.14 10.8 1.52 ; 0.125 10.44 1.23 ; 0.24 5.7 2.06; 0.132 9.5 1.112; ...
            0.144 5.1 2.26 ; 0.13 10.7 2.28  ; 0.22 10.32 1.56   ; 0.13 8.13 2.62; 0.23 8.55 1.74; ...
            0.135 6.72 2.09; 0.237 8.42 1.233 ; 0.13 8.7 1.83 ; 0.225 10.12 1.95; 0.133 8.6 1.83; ...
            0.23 8.7 2.05  ; 0.132 7.32 1.26; 0.125 6.24 1.38  ; 0.245 9 1.5 ; 0.14 6.96 2.27 ;...
            0.232 9.42 1.58; 0.136 5.85 2.16 ; 0.134 6.18 1.63 ; 0.242 6 2.25; 0.134 6.9 2.04];
  
  % Define GAMMA kernel
  modelFun1 = @(p,x) p(1).*((x.^(p(2)-1).*exp(-x./p(3)))./((p(3)^p(2))*gamma(p(2))));
  latmatnm=zeros(25,500);
  latmatnm10=zeros(25,500);
  latmatnm50=zeros(25,500);

  p1mat=zeros(25,500);
  p1mat10=zeros(25,500);
  p1mat50=zeros(25,500);

  p2mat=zeros(25,500);
  p2mat10=zeros(25,500);
  p2mat50=zeros(25,500);

  v1mat=zeros(25,500);
  v1mat10=zeros(25,500);
  v1mat50=zeros(25,500);

  v2mat=zeros(25,500);
  v2mat10=zeros(25,500);
  v2mat50=zeros(25,500);

  cmat=zeros(25,500);
  cmat10=zeros(25,500);
  cmat50=zeros(25,500);

  stdmat1 = zeros(1250,500);
  varmat1=zeros(25,500);

  for k=1:500 % Number of replications
    for j=1:25
        latmatnm(j,k)=results{k,3}(j,1);
        latmatnm10(j,k)=results10{k,3}(j,1);
        latmatnm50(j,k)=results50{k,3}(j,1);

        p1mat(j,k)=results{k,2}(j,2);
        p1mat10(j,k)=results10{k,2}(j,2);
        p1mat50(j,k)=results50{k,2}(j,2);

        p2mat(j,k)=results{k,2}(j,3);
        p2mat10(j,k)=results10{k,2}(j,3);
        p2mat50(j,k)=results50{k,2}(j,3);

        v1mat(j,k)=results{k,4}{1,j}(2,2);
        v1mat10(j,k)=results10{k,4}{1,j}(2,2);
        v1mat50(j,k)=results50{k,4}{1,j}(2,2);

        v2mat(j,k)=results{k,4}{1,j}(3,3);
        v2mat10(j,k)=results10{k,4}{1,j}(3,3);
        v2mat50(j,k)=results50{k,4}{1,j}(3,3);

        cmat(j,k)=results{k,4}{1,j}(3,2);
        cmat10(j,k)=results10{k,4}{1,j}(3,2);
        cmat50(j,k)=results50{k,4}{1,j}(3,2);
    end
    
    s=1;
    for j=1:25
        stdmat1(s:s+49,k)=results{k,1}(:,j);
        s=s+50;
    end

    % For checking variance
    varmat1(:,k) = results{k,3}(:);
  end
  er1=std(stdmat1')'; 

  Label = {'(a) $\widehat{h}^{(1,1)}$',
         '(b) $\widehat{h}^{(1,2)}$',
         '(c) $\widehat{h}^{(1,3)}$',
         '(d) $\widehat{h}^{(1,4)}$',
         '(e) $\widehat{h}^{(1,5)}$',
         '(f) $\widehat{h}^{(2,1)}$',
         '(g) $\widehat{h}^{(2,2)}$',
         '(h) $\widehat{h}^{(2,3)}$',
         '(i) $\widehat{h}^{(2,4)}$',
         '(j) $\widehat{h}^{(2,5)}$',
         '(k) $\widehat{h}^{(3,1)}$',
         '(l) $\widehat{h}^{(3,2)}$',
         '(m) $\widehat{h}^{(3,3)}$',
         '(n) $\widehat{h}^{(3,4)}$',
         '(o) $\widehat{h}^{(3,5)}$',
         '(p) $\widehat{h}^{(4,1)}$',
         '(q) $\widehat{h}^{(4,2)}$',
         '(r) $\widehat{h}^{(4,3)}$',
         '(s) $\widehat{h}^{(4,4)}$',
         '(t) $\widehat{h}^{(4,5)}$',
         '(u) $\widehat{h}^{(5,1)}$',
         '(v) $\widehat{h}^{(5,2)}$',
         '(w) $\widehat{h}^{(5,3)}$',
         '(x) $\widehat{h}^{(5,4)}$',
         '(y) $\widehat{h}^{(5,5)}$'};

st=15;
T=49; % Number of intervals for a kernel
t = [1:T];
    figure(1);
    clf;
    for k=1:25
    subplot(5,5,k)
    hold on
    p=plot(t',modelFun1(estpars1(k,:),t)','-k',t',modelFun1(simpars1(k,:),t)'+2.*er1(2:50),'--k',t',modelFun1(simpars1(k,:),t)'-2.*er1(2:50),'--k');
    p(1).LineWidth = 2;
    set(gca,'FontSize',st); 
    title(Label(k), 'interpreter','latex','FontSize', st );    
    ax = gca;
    ax.YRuler.Exponent = 0;
    ytickformat('%.3f')
    xlim([0 49])
    box off
    hold off
    end
    
  %% FIGURE with latencies
   Label1 = {'(a) $\widehat{L_T^{(1,1)}}$',
         '(b) $\widehat{L_T^{(1,2)}}$',
         '(c) $\widehat{L_T^{(1,3)}}$',
         '(d) $\widehat{L_T^{(1,4)}}$',
         '(e) $\widehat{L_T^{(1,5)}}$',
         '(f) $\widehat{L_T^{(2,1)}}$',
         '(g) $\widehat{L_T^{(2,2)}}$',
         '(h) $\widehat{L_T^{(2,3)}}$',
         '(i) $\widehat{L_T^{(2,4)}}$',
         '(j) $\widehat{L_T^{(2,5)}}$',
         '(k) $\widehat{L_T^{(3,1)}}$',
         '(l) $\widehat{L_T^{(3,2)}}$',
         '(m) $\widehat{L_T^{(3,3)}}$',
         '(n) $\widehat{L_T^{(3,4)}}$',
         '(o) $\widehat{L_T^{(3,5)}}$',
         '(p) $\widehat{L_T^{(4,1)}}$',
         '(q) $\widehat{L_T^{(4,2)}}$',
         '(r) $\widehat{L_T^{(4,3)}}$',
         '(s) $\widehat{L_T^{(4,4)}}$',
         '(t) $\widehat{L_T^{(4,5)}}$',
         '(u) $\widehat{L_T^{(5,1)}}$',
         '(v) $\widehat{L_T^{(5,2)}}$',
         '(w) $\widehat{L_T^{(5,3)}}$',
         '(x) $\widehat{L_T^{(5,4)}}$',
         '(y) $\widehat{L_T^{(5,5)}}$'};

   a=[4 10 ; 12 18 ; 10 14 ; 8 11.5 ; 8 12 ;
       6 13 ; 17 25 ; 13 17 ; 14 24 ; 12 15;
       8 16 ; 8.5 10.5 ; 11 20 ; 16 20 ; 11 17;
       14 18; 6 10 ; 6 10 ; 10 13; 10 18;
       12 15; 8 14 ; 7 11 ; 10 14 ; 10 15]; % Limits for a graph

  tmpl=zeros(25,500);
  figure(2)
  clf;
  for j=1:25
      subplot(5,5,j)
      hold on
      pts = linspace(a(j,1),a(j,2),100);
      tmp = (latmatnm(j,:)>a(j,1) & latmatnm(j,:)<a(j,2));
      tmp = latmatnm(j,tmp);
      tmpl(j,1:length(tmp))=tmp;
      [f,xi] = ksdensity(tmp,pts);
      p=plot(xi,f,'-k'); 
      p(1).LineWidth = 2;
      set(gca,'FontSize',st); 
      title(Label1(j),'interpreter','latex','FontSize', st);       
      ax = gca;
      ax.YRuler.Exponent = 0;
      ytickformat('%.3f')
      xlim(a(j,:))
      box off
      hold off
  end

  % Table 1 with a bias
  nfac = 3; % milliseconds
  std1 = mean( sqrt(varmat1'))';
  tpar=repmat( (simpars1(:,2)-1).*simpars1(:,3),1,500).*(tmpl~=0);
  biasall = tmpl - tpar;
  bias =mean(biasall')';
  inste=nfac*std(biasall')';
  table=[bias inste std1]

  % Histogram with errors
  data1 = biasall';   
  Label2 = {'(a) $Error^{(1,1)}$',
         '(b) $Error^{(1,2)}$',
         '(c) $Error^{(1,3)}$',
         '(d) $Error^{(1,4)}$',
         '(e) $Error^{(1,5)}$',
         '(f) $Error^{(2,1)}$',
         '(g) $Error^{(2,2)}$',
         '(h) $Error^{(2,3)}$',
         '(i) $Error^{(2,4)}$',
         '(j) $Error^{(2,5)}$',
         '(k) $Error^{(3,1)}$',
         '(l) $Error^{(3,2)}$',
         '(m) $Error^{(3,3)}$',
         '(n) $Error^{(3,4)}$',
         '(o) $Error^{(3,5)}$',
         '(p) $Error^{(4,1)}$',
         '(q) $Error^{(4,2)}$',
         '(r) $Error^{(4,3)}$',
         '(s) $Error^{(4,4)}$',
         '(t) $Error^{(4,5)}$',
         '(u) $Error^{(5,1)}$',
         '(v) $Error^{(5,2)}$',
         '(w) $Error^{(5,3)}$',
         '(x) $Error^{(5,4)}$',
         '(y) $Error^{(5,5)}$'};
  
  figure(3)
  for k=1:25
      subplot(5,5,k)
      hold on
      data = normalize(data1(data1(:,k)~=0,k));
     [f,xi] = ksdensity(data); %
     p=plot(xi,f,'-k'); 
     p(1).LineWidth = 2;
     set(gca,'FontSize',st); 
     title(Label2(k),'interpreter','latex','FontSize', st);
     axis tight
     box off
     hold off
  end

  % Size and Power of tests 
  sell = [1:5]; % select only first 5 latency values
  cv=1.65;
  lat = latmatnm(sell,:);
  lat10 = latmatnm10(sell,:);
  lat50 = latmatnm50(sell,:);

  sw = repmat(std(lat')',1,500);
  sw10 = repmat(std(lat10')',1,500);
  sw50 = repmat(std(lat50')',1,500);

  sr=mean(sw')';
  sr50=mean(sw50')';
  sr10=mean(sw10')';

  ub1=mean(lat10')'+cv*sr10;
  lb1=mean(lat10')'-cv*sr10;
  size10=sum((lat10>ub1)')/500;
  pow10=1-sum((lat10<lb1)')/500;

  lb2=mean(lat50')'-cv*sr50;
  ub2=mean(lat50')'+cv*sr50;
  size50=sum((lat50>ub2)')/500;
  pow50=1-sum((lat50<lb2)')/500;

  lb3=mean(lat')'-cv*sr;
  ub3=mean(lat')'+cv*sr;
  size=sum((lat>ub3)')/500;
  pow=1-sum((lat<lb3)')/500;

  [size10 ; size50 ; size ; pow ; pow50 ; pow10 ]

end

