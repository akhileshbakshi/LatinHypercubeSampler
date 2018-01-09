function [phip] = func_metricphi(A,k)
% see page 111 in Fang et al 2006_Design and modeling of computer simulations
% A is nxp dimensional matrix

[n p] = size(A);
phip = 0;
i = 1;
while i<n
    Arow = A(1,:);
    A(1,:) = [];
    rowdistance = sum((A - Arow).^2,2).^0.5;    % vector with distance of Arow from each point (row) in A
    phip = phip + sum(rowdistance.^(-k));
    i = i + 1;
end
phip = phip^(1/k);
end