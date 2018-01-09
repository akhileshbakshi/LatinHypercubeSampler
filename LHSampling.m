% Latin hypercube sampler for design of numerical experiments 
% MATLAB lhsdesign does NOT ensure that points are sampled at extremeties 
clear all; clc;

%% INPUT parameters --------------------------------------------------------
p = 2;                  % number of parameters
n = 20;                 % total number of points
includecorner = 1;      % condition ensures that atleast one point sampled 
                        % within tolerance of each extremity
                        % if includecorner == 1, must ensure 
                        % (a) n > 2^p - one point in each corner
                        % (b) n*tolerance >= 2^(p-1)
tolerance = 0.2;              
optimizer = 1;          % 0: random sample, 1: optimized sample 
                        % Specify following if optimizer = 1 
index = 3;              % index for distance calculation & optimization 
maxenhance = 20;        % maximum enhancements to decrease distance
maxiterations = 100;    % maximum iterations per enhancement  


%% code begins here --------------------------------------------------------
iteration = 1;           % counts max number of iterations to run LH sample
enhancectr = 1;

X = func_lhsgenerate(n, p, includecorner, tolerance);   
phip(enhancectr) = func_metricphi(X,index);

if optimizer == 1 
    while enhancectr<maxenhance && iteration<maxiterations
        iteration = iteration + 1;
        X_new = func_lhsgenerate(n, p, includecorner, tolerance);
        phip_new = func_metricphi(X_new,index);
        if phip_new < phip(enhancectr)          % => new lhs is more uniform
            enhancectr = enhancectr + 1;
            X = X_new;
            phip(enhancectr) = phip_new;
            iteration = 1;                      % reset iterations 
        end
    end
end 

%% Plotting 
fig2 = scatter(X(:,1), X(:,2), 120, 'bo', 'MarkerFaceColor', 'b');  grid on;
grid on; set(gca,'XTick',0:0.25:1); set(gca,'YTick',0:0.25:1);
set(gca,'XTick',0:0.25:1); set(gca,'YTick',0:0.25:1);
xlim([0,1]); ylim([0,1]);
