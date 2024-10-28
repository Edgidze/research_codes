% Plot latency results 2024

function plot_results24()

load results24

results=results4;
dts=dts2; % days
ndays = 405; % number of days

% Wald tests
% Prepare inputs
latmatnm = zeros(ndays,16);
for k=1:ndays 
    % Latency
    latmatnm(k,1)=results{k,3}(1,1);
    latmatnm(k,2)=results{k,3}(2,1);
    latmatnm(k,3)=results{k,3}(3,1);
    latmatnm(k,4)=results{k,3}(4,1);

    latmatnm(k,5)=results{k,3}(5,1);
    latmatnm(k,6)=results{k,3}(6,1);
    latmatnm(k,7)=results{k,3}(7,1);
    latmatnm(k,8)=results{k,3}(8,1);

    latmatnm(k,9)=results{k,3}(9,1);
    latmatnm(k,10)=results{k,3}(10,1);
    latmatnm(k,11)=results{k,3}(11,1);
    latmatnm(k,12)=results{k,3}(12,1);

    latmatnm(k,13)=results{k,3}(13,1);
    latmatnm(k,14)=results{k,3}(14,1);
    latmatnm(k,15)=results{k,3}(15,1);
    latmatnm(k,16)=results{k,3}(16,1);
end

% Hypotheses - H1
theta1=mean(latmatnm);
cov1=cov(latmatnm);
dof = 4;
r      = zeros(dof,16);
r(1,1) = 1.0;
r(2,6) = 1.0;
r(3,11) = 1.0;
r(4,16) = 1.0;
q      = [ 0 ; 0; 0 ; 0 ];
wd1     = (r*theta1' - q)'*inv(r*cov1*r')*(r*theta1' - q);
p1 = 1-chi2cdf(wd1,dof);

% H2
dof = 2;
r      = zeros(dof,16);
r(1,1) = 1.0;
r(2,6) = 1.0;
q      = [ theta1(11) ; theta1(16) ];
wd2     = (r*theta1' - q)'*inv(r*cov1*r')*(r*theta1' - q);
p2 = 1-chi2cdf(wd2,dof);

% H3a
dof = 4;
r      = zeros(dof,16);
r(1,2) = 1.0;
r(2,5) = 1.0;
r(3,12) = 1.0;
r(4,15) = 1.0;
q      = [ 0 ; 0; 0 ; 0 ];
wd3     = (r*theta1' - q)'*inv(r*cov1*r')*(r*theta1' - q);
p3 = 1-chi2cdf(wd3,dof);

% H3b
dof = 2;
r      = zeros(dof,16);
r(1,3) = 1.0;
r(1,4) = 1.0;
r(1,7) = 1.0;
r(1,8) = 1.0;
r(2,9) = 1.0;
r(2,10) = 1.0;
r(2,13) = 1.0;
r(2,14) = 1.0;
q      = [ 0 ; 0];
wd3b     = (r*theta1' - q)'*inv(r*cov1*r')*(r*theta1' - q);
p3b = 1-chi2cdf(wd3b,dof);

% Bonferroni correction of all hypotheses 
[corrected_p, h]=bonf_holm([p1 p2 p3 p3b],0.05);
[h1, crit_p, adj_ci_cvrg, adj_p]=fdr_bh([p1 p2 p3 p3b]);

% Plot (co)-latency and delays for 2 exchanges
bmatnm = zeros(ndays,16);
amatnm = zeros(ndays,16);
bematnm = zeros(ndays,16);
stdmatnm = zeros(ndays,24); % 8*3 parameters
commatnm = zeros(ndays,8);

for k=1:ndays 
    % Delay
    bmatnm(k,1)=results{k,2}(1,3);
    bmatnm(k,2)=results{k,2}(2,3);
    bmatnm(k,3)=results{k,2}(3,3);
    bmatnm(k,4)=results{k,2}(4,3);
    bmatnm(k,5)=results{k,2}(5,3);
    bmatnm(k,6)=results{k,2}(6,3);
    bmatnm(k,7)=results{k,2}(7,3);
    bmatnm(k,8)=results{k,2}(8,3);
    bmatnm(k,9)=results{k,2}(9,3);
    bmatnm(k,10)=results{k,2}(10,3);
    bmatnm(k,11)=results{k,2}(11,3);
    bmatnm(k,12)=results{k,2}(12,3);
    bmatnm(k,13)=results{k,2}(13,3);
    bmatnm(k,14)=results{k,2}(14,3);
    bmatnm(k,15)=results{k,2}(15,3);
    bmatnm(k,16)=results{k,2}(16,3);

    % BETAs
    bematnm(k,1)=results{k,2}(1,2);
    bematnm(k,2)=results{k,2}(2,2);
    bematnm(k,3)=results{k,2}(3,2);
    bematnm(k,4)=results{k,2}(4,2);
    bematnm(k,5)=results{k,2}(5,2);
    bematnm(k,6)=results{k,2}(6,2);
    bematnm(k,7)=results{k,2}(7,2);
    bematnm(k,8)=results{k,2}(8,2);
    bematnm(k,9)=results{k,2}(9,2);
    bematnm(k,10)=results{k,2}(10,2);
    bematnm(k,11)=results{k,2}(11,2);
    bematnm(k,12)=results{k,2}(12,2);
    bematnm(k,13)=results{k,2}(13,2);
    bematnm(k,14)=results{k,2}(14,2);
    bematnm(k,15)=results{k,2}(15,2);
    bematnm(k,16)=results{k,2}(16,2);

    % ALPHAs
    amatnm(k,1)=results{k,2}(1,1);
    amatnm(k,2)=results{k,2}(2,1);
    amatnm(k,3)=results{k,2}(3,1);
    amatnm(k,4)=results{k,2}(4,1);
    amatnm(k,5)=results{k,2}(5,1);
    amatnm(k,6)=results{k,2}(6,1);
    amatnm(k,7)=results{k,2}(7,1);
    amatnm(k,8)=results{k,2}(8,1);
    amatnm(k,9)=results{k,2}(9,1);
    amatnm(k,10)=results{k,2}(10,1);
    amatnm(k,11)=results{k,2}(11,1);
    amatnm(k,12)=results{k,2}(12,1);
    amatnm(k,13)=results{k,2}(13,1);
    amatnm(k,14)=results{k,2}(14,1);
    amatnm(k,15)=results{k,2}(15,1);
    amatnm(k,16)=results{k,2}(16,1);

     % STDs
     f=1;
     for s=[1 6 11 16 2 5 12 15]
         stdmatnm(k,f:f+2)= (sqrt(diag(results{k,4}{1,s})))';
         f=f+3;
     end     

    % Covs 
    commatnm(k,1) = results{k,4}{1,1}(3,2); 
    commatnm(k,2) = results{k,4}{1,6}(3,2);
    commatnm(k,3) = results{k,4}{1,11}(3,2);
    commatnm(k,4) = results{k,4}{1,16}(3,2);
    commatnm(k,5) = results{k,4}{1,2}(3,2); 
    commatnm(k,6) = results{k,4}{1,5}(3,2);
    commatnm(k,7) = results{k,4}{1,12}(3,2);
    commatnm(k,8) = results{k,4}{1,15}(3,2);

end

% Insert values for clear plots
for k=1:24
    indk = (stdmatnm(:,k)>2.5);
    if sum(indk)>0
       stdmatnm(indk,k)=stdmatnm(4,k);
    end
end
for k=[2 12] 
    indk = (bematnm(:,k)>10);
    if sum(indk)>0
       bematnm(indk,k)=bematnm(4,k);
    end
end
for k=[2 12] 
    indk = (latmatnm(:,k)>9);
    if sum(indk)>0
       latmatnm(indk,k)=latmatnm(4,k);
    end
end

% Plot DELAY 
Label = {'(a) $\widehat{D_T^{(1,1)}}$',
         '(b) $\widehat{D_T^{(2,2)}}$',
         '(c) $\widehat{D_T^{(3,3)}}$',
         '(d) $\widehat{D_T^{(4,4)}}$',
         '(e) $\widehat{D_T^{(1,2)}}$',
         '(f) $\widehat{D_T^{(2,1)}}$',
         '(g) $\widehat{D_T^{(3,4)}}$',
         '(h) $\widehat{D_T^{(4,3)}}$'};
limits = [0 9; 0 9; 0 9; 0 9; 0 9; 0 9; 0 9; 0 9];
HDM1 = [bmatnm(:,1) bmatnm(:,6) bmatnm(:,11) bmatnm(:,16) bmatnm(:,2) bmatnm(:,5) bmatnm(:,12) bmatnm(:,15)];
STDM1 =[stdmatnm(:,3) stdmatnm(:,6) stdmatnm(:,9) stdmatnm(:,12) stdmatnm(:,15) stdmatnm(:,18) stdmatnm(:,21) stdmatnm(:,24)];
limstd=1.6;
t = datetime(datenum(dts,'yyyymmdd'),'ConvertFrom','datenum');

figure(1)
for i=1:8
subplot(4,2,i)
ts = timeseries([HDM1(:,i)],datestr(datenum(dts,'yyyymmdd'),'dd-mmm-yyyy'),'name',' ');
ts.TimeInfo.Units = 'days';
ts.TimeInfo.Format= 'mmm-yyyy';
shadedplot(t, [HDM1(:,i)-limstd*STDM1(:,i)]', [HDM1(:,i)+limstd*STDM1(:,i)]',[0.8 0.8 0.8], [0.8 0.8 0.8])
hold on
plot(ts,'-k');
ylim(limits(i,:))
title(Label(i),'interpreter','latex')
hold off
end

% Plot BETAs 
Label = {'(a) $\widehat{\beta_T^{(1,1)}}$',
         '(b) $\widehat{\beta_T^{(2,2)}}$',
         '(c) $\widehat{\beta_T^{(3,3)}}$',
         '(d) $\widehat{\beta_T^{(4,4)}}$',
         '(e) $\widehat{\beta_T^{(1,2)}}$',
         '(f) $\widehat{\beta_T^{(2,1)}}$',
         '(g) $\widehat{\beta_T^{(3,4)}}$',
         '(h) $\widehat{\beta_T^{(4,3)}}$'};
limits = [0 6; 0 4; 0 4; 0 6; 0 12; 0 4; 0 12; 0 2];
HDM2 = [bematnm(:,1) bematnm(:,6) bematnm(:,11) bematnm(:,16) bematnm(:,2) bematnm(:,5) bematnm(:,12) bematnm(:,15)];
STDM2 =[stdmatnm(:,2) stdmatnm(:,5) stdmatnm(:,8) stdmatnm(:,11) stdmatnm(:,14) stdmatnm(:,17) stdmatnm(:,20) stdmatnm(:,23)];
t = datetime(datenum(dts,'yyyymmdd'),'ConvertFrom','datenum');

figure(2)
for i=1:8
subplot(4,2,i)
ts = timeseries([HDM2(:,i)],datestr(datenum(dts,'yyyymmdd'),'dd-mmm-yyyy'),'name',' ');
ts.TimeInfo.Units = 'days';
ts.TimeInfo.Format= 'mmm-yyyy';
shadedplot(t, [HDM2(:,i)-limstd*STDM2(:,i)]', [HDM2(:,i)+limstd*STDM2(:,i)]',[0.8 0.8 0.8], [0.8 0.8 0.8])
hold on
plot(ts,'-k');
ylim(limits(i,:))
title(Label(i),'interpreter','latex')
hold off
end

% Plot ALPHAs 
Label = {'(a) $\widehat{\alpha_T^{(1,1)}}$',
         '(b) $\widehat{\alpha_T^{(2,2)}}$',
         '(c) $\widehat{\alpha_T^{(3,3)}}$',
         '(d) $\widehat{\alpha_T^{(4,4)}}$',
         '(e) $\widehat{\alpha_T^{(1,2)}}$',
         '(f) $\widehat{\alpha_T^{(2,1)}}$',
         '(g) $\widehat{\alpha_T^{(3,4)}}$',
         '(h) $\widehat{\alpha_T^{(4,3)}}$'};
limits = [0 0.5; 0 0.7; 0 0.5; 0 0.8; 0 0.06; 0 0.8; 0 0.1; 0 0.6];
HDM = [amatnm(:,1) amatnm(:,6) amatnm(:,11) amatnm(:,16) amatnm(:,2) amatnm(:,5) amatnm(:,12) amatnm(:,15)];
STDM =[stdmatnm(:,1) stdmatnm(:,4) stdmatnm(:,7) stdmatnm(:,10) stdmatnm(:,13) stdmatnm(:,16) stdmatnm(:,19) stdmatnm(:,22)];
t = datetime(datenum(dts,'yyyymmdd'),'ConvertFrom','datenum');

figure(3)
for i=1:8
subplot(4,2,i)
ts = timeseries([HDM(:,i)],datestr(datenum(dts,'yyyymmdd'),'dd-mmm-yyyy'),'name',' ');
ts.TimeInfo.Units = 'days';
ts.TimeInfo.Format= 'mmm-yyyy';
shadedplot(t, [HDM(:,i)-limstd*STDM(:,i)]', [HDM(:,i)+limstd*STDM(:,i)]',[0.8 0.8 0.8], [0.8 0.8 0.8])
hold on
plot(ts,'-k');
ylim(limits(i,:))
title(Label(i),'interpreter','latex')
hold off
end

% Plot latencies 
Label = {'(a) $\widehat{L_T^{(1,1)}}$',
         '(b) $\widehat{L_T^{(2,2)}}$',
         '(c) $\widehat{L_T^{(3,3)}}$',
         '(d) $\widehat{L_T^{(4,4)}}$',
         '(e) $\widehat{L_T^{(1,2)}}$',
         '(f) $\widehat{L_T^{(2,1)}}$',
         '(g) $\widehat{L_T^{(3,4)}}$',
         '(h) $\widehat{L_T^{(4,3)}}$'};
limits = [0 8; 0 8; 0 8; 0 8; 0 9; 0 8; 0 9; 0 8];
HDM = [latmatnm(:,1) latmatnm(:,6) latmatnm(:,11) latmatnm(:,16) latmatnm(:,2) latmatnm(:,5) latmatnm(:,12) latmatnm(:,15)];
p1 = HDM1-1; % Delay
p2= HDM2;
STDM = zeros(size(HDM));

for k=1:8
    varlatnm1 = p1(:,k).^2.*STDM2(:,k).^2+p2(:,k).^2.*STDM1(:,k).^2+2.*p1(:,k).*p2(:,k).*commatnm(:,k)+STDM1(:,k).^2.*STDM2(:,k).^2+commatnm(:,k).^2;
    std1 = (sqrt(varlatnm1));
    STDM(:,k)=std1;
end
t = datetime(datenum(dts,'yyyymmdd'),'ConvertFrom','datenum');

figure(4)
for i=1:8
subplot(4,2,i)
ts = timeseries([HDM(:,i)],datestr(datenum(dts,'yyyymmdd'),'dd-mmm-yyyy'),'name',' ');
ts.TimeInfo.Units = 'days';
ts.TimeInfo.Format= 'mmm-yyyy';
shadedplot(t, [HDM(:,i)-limstd*STDM(:,i)]', [HDM(:,i)+limstd*STDM(:,i)]',[0.8 0.8 0.8], [0.8 0.8 0.8])
hold on
plot(ts,'-k');
ylim(limits(i,:))
title(Label(i),'interpreter','latex')
hold off
end

end

%--------------------------- Functions -----------------------------------
function [ha hb hc] = shadedplot(x, y1, y2, varargin)

% SHADEDPLOT draws two lines on a plot and shades the area between those
% lines.
%
% SHADEDPLOT(x, y1, y2)
%   All of the arguments are vectors of the same length, and each y-vector is
%   horizontal (i.e. size(y1) = [1  N]). Vector x contains the x-axis values,
%   and y1:y2 contain the y-axis values.
%
%   Plot y1 and y2 vs x, then shade the area between those two
%   lines. Highlight the edges of that band with lines.
%
%   SHADEDPLOT(x, y1, y2, areacolor, linecolor)
%   The arguments areacolor and linecolor allow the user to set the color
%   of the shaded area and the boundary lines. These arguments must be
%   either text values (see the help for the PLOT function) or a
%   3-element vector with the color values in RGB (see the help for
%   COLORMAP).
%
%   [HA HB HC = SHADEDPLOT(x, y1, y2) returns three handles to the calling
%   function. HA is a vector of handles to areaseries objects (HA(2) is the
%   shaded area), HB is the handle to the first line (x vs y1), and HC is
%   the handle to the second line (x vs y2).
%
%   Example:
%
%     x1 = [1 2 3 4 5 6];
%     y1 = x1;
%     y2 = x1+1;
%     x3 = [1.5 2 2.5 3 3.5 4];
%     y3 = 2*x3;
%     y4 = 4*ones(size(x3));
%     ha = shadedplot(x1, y1, y2, [1 0.7 0.7], 'r'); %first area is red
%     hold on
%     hb = shadedplot(x3, y3, y4, [0.7 0.7 1]); %second area is blue
%     hold off

% plot the shaded area
y = [y1; (y2-y1)]'; 
ha = area(x, y);
set(ha(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ha, 'LineStyle', 'none')

% plot the line edges
hold on 
hb = plot(x, y1, 'LineWidth', 1);
hc = plot(x, y2, 'LineWidth', 1);
hold off

% set the line and area colors if they are specified
switch length(varargin)
    case 0
    case 1
        set(ha(2), 'FaceColor', varargin{1})
    case 2
        set(ha(2), 'FaceColor', varargin{1})
        set(hb, 'Color', varargin{2})
        set(hc, 'Color', varargin{2})
    otherwise
end

% put the grid on top of the colored area
set(gca, 'Layer', 'top')
grid on
end

% Bonferroni-Holm (1979) correction for multiple comparisons.  This is a
% sequentially rejective version of the simple Bonferroni correction for multiple
% comparisons and strongly controls the family-wise error rate at level alpha.
%
% It works as follows:
% 1) All p-values are sorted in order of smallest to largest. m is the
%    number p-values.
% 2) If the 1st p-value is greater than or equal to alpha/m, the procedure
%    is stopped and no p-values are significant.  Otherwise, go on.
% 3) The 1st p-value is declared significant and now the second p-value is
%    compared to alpha/(m-1). If the 2nd p-value is greater than or equal 
%    to alpha/(m-1), the procedure is stopped and no further p-values are 
%    significant.  Otherwise, go on. 
% 4) Et cetera.
%
% As stated by Holm (1979) "Except in trivial non-interesting cases the 
% sequentially rejective Bonferroni test has strictly larger probability of
% rejecting false hypotheses and thus it ought to replace the classical 
% Bonferroni test at all instants where the latter usually is applied."
%
%
% function [corrected_p, h]=bonf_holm(pvalues,alpha)
%
% Required Inputs:
%  pvalues - A vector or matrix of p-values. If pvalues is a matrix, it can
%            be of any dimensionality (e.g., 2D, 3D, etc...).
%
% Optional Input:
%  alpha   - The desired family-wise alpha level (i.e., the probability of
%            rejecting one of more null hypotheses when all null hypotheses are
%            really true). {default: 0.05}
%
% Output:
%  corrected_p  - Bonferroni-Holm adjusted p-values. Any adjusted p-values
%                 less than alpha are significant (i.e., that null hypothesis 
%                 is rejected).  The adjusted value of the smallest p-value
%                 is p*m.  The ith smallest adjusted p-value is the max of
%                 p(i)*(m-i+1) or adj_p(i-1).  Note, corrected p-values can
%                 be greater than 1.
%  h            - A binary vector or matrix of the same dimensionality as
%                 pvalues.  If the ith element of h is 1, then the ith p-value
%                 of pvalues is significant.  If the ith element of h is 0, then
%                 the ith p-value of pvalues is NOT significant.
%
% Example:
% >>p=[.56 .22 .001 .04 .01]; %five hypothetical p-values
% >>[cor_p, h]=bonf_holm(p,.05)
% cor_p =
%    0.5600    0.4400    0.0050    0.1200    0.0400
% h =
%     0     0     1     0     1
% 
% Conclusion: the third and fifth p-values are significant, but not the
% remaining three.
%
% Reference:
% Holm, S. (1979) A simple sequentially rejective multiple test procedure.
% Scandinavian Journal of Statistics. 6, 65-70.
%
%
% For a review on contemporary techniques for correcting for multiple
% comparisons that are often more powerful than Bonferroni-Holm see:
%
%   Groppe, D.M., Urbach, T.P., & Kutas, M. (2011) Mass univariate analysis 
% of event-related brain potentials/fields I: A critical tutorial review. 
% Psychophysiology, 48(12) pp. 1711-1725, DOI: 10.1111/j.1469-8986.2011.01273.x 
% http://www.cogsci.ucsd.edu/~dgroppe/PUBLICATIONS/mass_uni_preprint1.pdf
%
%
% Author:
% David M. Groppe
% Kutaslab
% Dept. of Cognitive Science
% University of California, San Diego
% March 24, 2010
function [corrected_p, h]=bonf_holm(pvalues,alpha)
if nargin<1,
    error('You need to provide a vector or matrix of p-values.');
else
    if ~isempty(find(pvalues<0,1)),
        error('Some p-values are less than 0.');
    elseif ~isempty(find(pvalues>1,1)),
        fprintf('WARNING: Some uncorrected p-values are greater than 1.\n');
    end
end
if nargin<2,
    alpha=.05;
elseif alpha<=0,
    error('Alpha must be greater than 0.');
elseif alpha>=1,
    error('Alpha must be less than 1.');
end
s=size(pvalues);
if isvector(pvalues),
    if size(pvalues,1)>1,
       pvalues=pvalues'; 
    end
    [sorted_p sort_ids]=sort(pvalues);    
else
    [sorted_p sort_ids]=sort(reshape(pvalues,1,prod(s)));
end
[dummy, unsort_ids]=sort(sort_ids); %indices to return sorted_p to pvalues order
m=length(sorted_p); %number of tests
mult_fac=m:-1:1;
cor_p_sorted=sorted_p.*mult_fac;
cor_p_sorted(2:m)=max([cor_p_sorted(1:m-1); cor_p_sorted(2:m)]); %Bonferroni-Holm adjusted p-value
corrected_p=cor_p_sorted(unsort_ids);
corrected_p=reshape(corrected_p,s);
h=corrected_p<alpha;

end

% fdr_bh() - Executes the Benjamini & Hochberg (1995) and the Benjamini &
%            Yekutieli (2001) procedure for controlling the false discovery 
%            rate (FDR) of a family of hypothesis tests. FDR is the expected
%            proportion of rejected hypotheses that are mistakenly rejected 
%            (i.e., the null hypothesis is actually true for those tests). 
%            FDR is a somewhat less conservative/more powerful method for 
%            correcting for multiple comparisons than procedures like Bonferroni
%            correction that provide strong control of the family-wise
%            error rate (i.e., the probability that one or more null
%            hypotheses are mistakenly rejected).
%
%            This function also returns the false coverage-statement rate 
%            (FCR)-adjusted selected confidence interval coverage (i.e.,
%            the coverage needed to construct multiple comparison corrected
%            confidence intervals that correspond to the FDR-adjusted p-values).
%
%
% Usage:
%  >> [h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pvals,q,method,report);
%
% Required Input:
%   pvals - A vector or matrix (two dimensions or more) containing the
%           p-value of each individual test in a family of tests.
%
% Optional Inputs:
%   q       - The desired false discovery rate. {default: 0.05}
%   method  - ['pdep' or 'dep'] If 'pdep,' the original Bejnamini & Hochberg
%             FDR procedure is used, which is guaranteed to be accurate if
%             the individual tests are independent or positively dependent
%             (e.g., Gaussian variables that are positively correlated or
%             independent).  If 'dep,' the FDR procedure
%             described in Benjamini & Yekutieli (2001) that is guaranteed
%             to be accurate for any test dependency structure (e.g.,
%             Gaussian variables with any covariance matrix) is used. 'dep'
%             is always appropriate to use but is less powerful than 'pdep.'
%             {default: 'pdep'}
%   report  - ['yes' or 'no'] If 'yes', a brief summary of FDR results are
%             output to the MATLAB command line {default: 'no'}
%
%
% Outputs:
%   h       - A binary vector or matrix of the same size as the input "pvals."
%             If the ith element of h is 1, then the test that produced the 
%             ith p-value in pvals is significant (i.e., the null hypothesis
%             of the test is rejected).
%   crit_p  - All uncorrected p-values less than or equal to crit_p are 
%             significant (i.e., their null hypotheses are rejected).  If 
%             no p-values are significant, crit_p=0.
%   adj_ci_cvrg - The FCR-adjusted BH- or BY-selected 
%             confidence interval coverage. For any p-values that 
%             are significant after FDR adjustment, this gives you the
%             proportion of coverage (e.g., 0.99) you should use when generating
%             confidence intervals for those parameters. In other words,
%             this allows you to correct your confidence intervals for
%             multiple comparisons. You can NOT obtain confidence intervals 
%             for non-significant p-values. The adjusted confidence intervals
%             guarantee that the expected FCR is less than or equal to q
%             if using the appropriate FDR control algorithm for the  
%             dependency structure of your data (Benjamini & Yekutieli, 2005).
%             FCR (i.e., false coverage-statement rate) is the proportion 
%             of confidence intervals you construct
%             that miss the true value of the parameter. adj_ci=NaN if no
%             p-values are significant after adjustment.
%   adj_p   - All adjusted p-values less than or equal to q are significant
%             (i.e., their null hypotheses are rejected). Note, adjusted 
%             p-values can be greater than 1.
%
%
% References:
%   Benjamini, Y. & Hochberg, Y. (1995) Controlling the false discovery
%     rate: A practical and powerful approach to multiple testing. Journal
%     of the Royal Statistical Society, Series B (Methodological). 57(1),
%     289-300.
%
%   Benjamini, Y. & Yekutieli, D. (2001) The control of the false discovery
%     rate in multiple testing under dependency. The Annals of Statistics.
%     29(4), 1165-1188.
%
%   Benjamini, Y., & Yekutieli, D. (2005). False discovery rate?adjusted 
%     multiple confidence intervals for selected parameters. Journal of the 
%     American Statistical Association, 100(469), 71?81. doi:10.1198/016214504000001907
%
%
% Example:
%  nullVars=randn(12,15);
%  [~, p_null]=ttest(nullVars); %15 tests where the null hypothesis
%  %is true
%  effectVars=randn(12,5)+1;
%  [~, p_effect]=ttest(effectVars); %5 tests where the null
%  %hypothesis is false
%  [h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh([p_null p_effect],.05,'pdep','yes');
%  data=[nullVars effectVars];
%  fcr_adj_cis=NaN*zeros(2,20); %initialize confidence interval bounds to NaN
%  if ~isnan(adj_ci_cvrg),
%     sigIds=find(h);
%     fcr_adj_cis(:,sigIds)=tCIs(data(:,sigIds),adj_ci_cvrg); % tCIs.m is available on the
%     %Mathworks File Exchagne
%  end
%
%
% For a review of false discovery rate control and other contemporary
% techniques for correcting for multiple comparisons see:
%
%   Groppe, D.M., Urbach, T.P., & Kutas, M. (2011) Mass univariate analysis 
% of event-related brain potentials/fields I: A critical tutorial review. 
% Psychophysiology, 48(12) pp. 1711-1725, DOI: 10.1111/j.1469-8986.2011.01273.x 
% http://www.cogsci.ucsd.edu/~dgroppe/PUBLICATIONS/mass_uni_preprint1.pdf
%
%
% For a review of FCR-adjusted confidence intervals (CIs) and other techniques 
% for adjusting CIs for multiple comparisons see:
%
%   Groppe, D.M. (in press) Combating the scientific decline effect with 
% confidence (intervals). Psychophysiology.
% http://biorxiv.org/content/biorxiv/early/2015/12/10/034074.full.pdf
%
%
% Author:
% David M. Groppe
% Kutaslab
% Dept. of Cognitive Science
% University of California, San Diego
% March 24, 2010
%%%%%%%%%%%%%%%% REVISION LOG %%%%%%%%%%%%%%%%%
%
% 5/7/2010-Added FDR adjusted p-values
% 5/14/2013- D.H.J. Poot, Erasmus MC, improved run-time complexity
% 10/2015- Now returns FCR adjusted confidence intervals
function [h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pvals,q,method,report)
if nargin<1,
    error('You need to provide a vector or matrix of p-values.');
else
    if ~isempty(find(pvals<0,1)),
        error('Some p-values are less than 0.');
    elseif ~isempty(find(pvals>1,1)),
        error('Some p-values are greater than 1.');
    end
end
if nargin<2,
    q=.05;
end
if nargin<3,
    method='pdep';
end
if nargin<4,
    report='no';
end
s=size(pvals);
if (length(s)>2) || s(1)>1,
    [p_sorted, sort_ids]=sort(reshape(pvals,1,prod(s)));
else
    %p-values are already a row vector
    [p_sorted, sort_ids]=sort(pvals);
end
[dummy, unsort_ids]=sort(sort_ids); %indexes to return p_sorted to pvals order
m=length(p_sorted); %number of tests
if strcmpi(method,'pdep'),
    %BH procedure for independence or positive dependence
    thresh=(1:m)*q/m;
    wtd_p=m*p_sorted./(1:m);
    
elseif strcmpi(method,'dep')
    %BH procedure for any dependency structure
    denom=m*sum(1./(1:m));
    thresh=(1:m)*q/denom;
    wtd_p=denom*p_sorted./[1:m];
    %Note, it can produce adjusted p-values greater than 1!
    %compute adjusted p-values
else
    error('Argument ''method'' needs to be ''pdep'' or ''dep''.');
end
if nargout>3,
    %compute adjusted p-values; This can be a bit computationally intensive
    adj_p=zeros(1,m)*NaN;
    [wtd_p_sorted, wtd_p_sindex] = sort( wtd_p );
    nextfill = 1;
    for k = 1 : m
        if wtd_p_sindex(k)>=nextfill
            adj_p(nextfill:wtd_p_sindex(k)) = wtd_p_sorted(k);
            nextfill = wtd_p_sindex(k)+1;
            if nextfill>m
                break;
            end;
        end;
    end;
    adj_p=reshape(adj_p(unsort_ids),s);
end
rej=p_sorted<=thresh;
max_id=find(rej,1,'last'); %find greatest significant pvalue
if isempty(max_id),
    crit_p=0;
    h=pvals*0;
    adj_ci_cvrg=NaN;
else
    crit_p=p_sorted(max_id);
    h=pvals<=crit_p;
    adj_ci_cvrg=1-thresh(max_id);
end
if strcmpi(report,'yes'),
    n_sig=sum(p_sorted<=crit_p);
    if n_sig==1,
        fprintf('Out of %d tests, %d is significant using a false discovery rate of %f.\n',m,n_sig,q);
    else
        fprintf('Out of %d tests, %d are significant using a false discovery rate of %f.\n',m,n_sig,q);
    end
    if strcmpi(method,'pdep'),
        fprintf('FDR/FCR procedure used is guaranteed valid for independent or positively dependent tests.\n');
    else
        fprintf('FDR/FCR procedure used is guaranteed valid for independent or dependent tests.\n');
    end
end

end


