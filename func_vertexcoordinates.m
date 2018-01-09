function [vertices] = func_vertexcoordinates(p)

n = 2^p;
vertices = zeros(n,p);

freq = zeros(p,1);
for j=1:p freq(j) = 2^(p-j); end

for j=1:p
    p1 = 0;
    ctr = 0;
    for i=1:n
        vertices(i,j) = p1;
        ctr = ctr+1;
        if ctr == freq(j); p1 = func_tictoc(p1); ctr = 0; end
    end
end

end

function [p1] = func_tictoc(p)
if p==1; p1=0; end
if p==0; p1=1; end
end
