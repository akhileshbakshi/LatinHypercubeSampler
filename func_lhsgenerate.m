function [X] = func_lhsgenerate(n, p, includecorner, tolerance)

if includecorner == 1
    % create LHSample with atleast one data point in proximity of each vertex
    vertices = func_vertexcoordinates(p);       % generate vertices
    ncorner = 2^p;
    
    binsize = 1/n;
    ntol = floor(tolerance/binsize);            % number of points within tolerance
    points_index = zeros(ncorner,p);            % for each vertex, pick a point within tolerance
    
    vertexindex_global = zeros(2*ntol,p);
    for j=1:p; vertexindex_global(:,j) = [1:ntol n+1-ntol:n]'; end
    
    for i=1:ncorner
        cur_vertex = vertices(i,:);
        for j=1:p
            if(cur_vertex(j) == 0) TF = vertexindex_global(:,j)<= ntol & vertexindex_global(:,j)>0; possible_index = vertexindex_global(TF,j); end
            if(cur_vertex(j) == 1) TF = vertexindex_global(:,j)> ntol; possible_index = vertexindex_global(TF,j); end
            possible_index_pick = possible_index(randi(length(possible_index)));
            points_index(i,j) = possible_index_pick;
            vertexindex_global(:,j) = vertexindex_global(:,j)-possible_index_pick*(vertexindex_global(:,j)==possible_index_pick);
            clear possible_index TF;
        end
    end
end

if includecorner == 0; points_index = zeros(1,p); end

% generate lhs with n points in p dimensions excluding the indices supplied
X = zeros(n,p);
if includecorner == 1
    index1 = length(points_index);
    X(1:length(points_index),:) = points_index;
end
if includecorner == 0; index1 = 0; end

for j=1:p
    possible_index = setdiff((1:n)',points_index(:,j));
    possible_index_perm = randperm(length(possible_index))';
    X(index1+1:n,j) = possible_index(possible_index_perm);
end

% generate random numbers in nxp matrix
X = (X-rand(n,p))/n;

end
