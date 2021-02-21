g = cell(1,ModelNum);
dg = cell(1, ModelNum)
for i = 1 : ModelNum
    %t = s{i};
    g{i} = rgb2gray(s{i});
    dg{i}  = im2double(g{i});
end
background = 1.0;
[m n] = size(g{1});
idmatrix = background*ones(m,n);
thre = 0.090001
for i = 1:ModelNum
    i
    %g{i}= abs(g{i}-idmatrix);    
%     for j = 1 : m
%         for k = 1 : n
%             if abs(dg{i}(j,k)-background)<thre
%                 dg{i}(j,k) = 0;
%             end
%         end
%     end
    dg{i} = dg{i}<(background-thre) 
end

[m,n] = size(dg{1});
basedomain = zeros(m,n);
for i = 1 : ModelNum
    basedomain = dg{i}+basedomain;
end
xmin = m;
xmax = 0;   
ymin = n;
ymax = 0;

for i = 1 : m
    for j = 1 : n
        if basedomain(i,j)>thre
            if i < xmin
                xmin = i;
            end
            if i > xmax
                xmax = i;
            end
            if j < ymin
                ymin = j;
            end
            if j > ymax
                ymax = j;
            end
        end
    end
end 