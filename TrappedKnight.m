%BW
%Finding the trace that the knight makes
clear
clc

dim = 201;
Box = zeros(dim,dim);

center = (dim-1)/2+1;
numrow = (dim-1)/2;
val = 2;
count = 1;

Box(center,center) = 1;
i = center;
j = center;

while val < dim*dim       
    
    for beta = 1:count
        i = i-1; 
        Box(i,j) = val;
        val = val +1;
        if val > dim*dim  
            break
        end
    end
    
    for beta = 1:count
        j = j+1;
        Box(i,j) = val;
        val = val + 1;
        if val > dim*dim  
            break
        end
    end
    count = count + 1;
    
    for beta = 1:count
        i = i+1; 
        Box(i,j) = val;
        val = val +1;
        if val > dim*dim  
            break
        end
    end
    
    for beta = 1:count
        j = j-1;
        Box(i,j) = val;
        val = val + 1;
        if val > dim*dim  
            break
        end
    end
    count = count + 1;
    
end

i(1) = center;
j(1) = center;
PrevVals = zeros(5,1);
for beta = 1:5000000 
   PrevVals(beta) = Box(i(beta),j(beta));
   [i(beta+1),j(beta+1),stop] = MoveKnight(Box,i(beta),j(beta),PrevVals); 
   if stop == 1;
       i(beta+1) = [];
       j(beta+1) = [];
        break
   end
end

%% Visuals

plot(i,j)

%% Function

function [i_new,j_new,stop] = MoveKnight(Box,i,j,PrevVals)
    
step_a = 2;
step_b = 1;
    %Positions
    stop = 0;
    i_new = 0;
    j_new = 0;

    v(1) = Box(i+step_b,j+step_a);
    v(2) = Box(i+step_b,j-step_a);
    v(3) = Box(i-step_b,j-step_a);
    v(4) = Box(i-step_b,j+step_a);
    
    v(5) = Box(i+step_a,j+step_b);
    v(6) = Box(i+step_a,j-step_b);
    v(7) = Box(i-step_a,j+step_b);
    v(8) = Box(i-step_a,j-step_b);
    
    for beta = 1:length(v)
        new_val = min(v);
        
        if ismember(new_val,PrevVals) == 0     %if novel 
            break
        else                                   %if not, go to next val
            ind = find(v == new_val);
            v(ind) = [];
        end

    end
    
    if ismember(new_val,PrevVals) == 0
        [i_new,j_new] = find(Box == new_val);
    end
    
    if i_new == 0
        stop = 1;
    end
    
end










