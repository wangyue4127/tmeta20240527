% This code shows model fitting (Table 4) and outlier detection (Figure 7) for different methods on the original and modified cdp datasets, 
% as well as a forest plot Figure 6 for the dataset.

clc; clear all
dataname = 'cdp'; addpath('result');
model    = {'nMeta','tRE-Meta','MIX-Meta','SYM-Meta','SKM-Meta','tMeta'};  

%% the result of model fitting
load('cdp_org_dec.mat');
fprintf('Fitting results of different models on the original cdp dataset:\n')
title_str = {'muhat','sigmahat','nuhat','-logLik','BIC','t_time'};
fprintf('\n\t\t\t%s\t%s\t%s\t%s\t%6s\t%9s\n',title_str{:});
for i = 1:length(model)
    fprintf('%-8s%9.3f %9.3f %9.3f %8.3f %8.3f %8.3f \n', ...
        model{i},me{i}.mu,sqrt(me{i}.s2),me{i}.nu,me{i}.logL.*(-1),me{i}.BIC,me{i}.time+me{i}.dtime);
end

load('cdp_ext_dec.mat');
fprintf('Fitting results of different models on the modified cdp dataset:\n')
fprintf('\n\t\t\t%s\t%s\t%s\t%s\t%6s\t%9s\n',title_str{:});
for i = 1:length(model)
    fprintf('%-8s%9.3f %9.3f %9.3f %8.3f %8.3f %8.3f\n', ...
        model{i},me{i}.mu,sqrt(me{i}.s2),me{i}.nu,me{i}.logL.*(-1),me{i}.BIC,me{i}.time+me{i}.dtime);
end

%% plot
alpha = 0.05;  m = [1,1];
[Y,Hmu,Ci,err,ll_t,T,marS,Ndata,tme,tre,mix,skm,sym] = motheds_result(dataname);
% forest plot and the change in log-likelihood by tmeta
figure; fore(Y,Hmu,Ci,err,ll_t,marS,Ndata);

%  outlier detection
figure; plot_out(tme,tre,mix,skm,sym,m,alpha,Ndata,dataname);
