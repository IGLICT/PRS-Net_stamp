%tarfolder23 = 'E:\project\test\img';
global col connected alphaa num
m=col;
% m=3;
if ~exist('xmin','var')
    xmin=1;
    ymin=1;
    [xmax,ymax,~]=size(s{1});
end
mat_vert=s{1}(xmin:xmax,ymin:ymax,:);
tarfilename_horz=[tarfolder,'/','hebin_horz.png'];
tarfilename_vert=[tarfolder,'/','hebin_vert.png'];
res=mod(ModelNum,m);
if res==0
    k=0;
    kk=ModelNum/m;
else
    k=m-res;
    kk=int32((ModelNum+k)/m);
    
end
[~,order]=sort_nat({pngs.name});
pngs=pngs(order);
for i=1:k
    pngs(end+1).name='blank.png';
    s{end+1}=255*ones(size(s{1}));
end
% toumingdu
alpha=ones(xmax-xmin+1,ymax-ymin+1);
 

for i = 1 : kk
    mat_horz{i}=s{(i-1)*(m)+1}(xmin:xmax,ymin:ymax,:);
    
    [~,newpng1,p]=fileparts(pngs((i-1)*(m)+1).name);
    tarfilename1 = [tarfolder,'/',newpng1,'.png'];
    if alphaa
        aa=s{(i-1)*(m)+1}(xmin:xmax,ymin:ymax,:);
        alpha=ones(xmax-xmin+1,ymax-ymin+1);
        alpha(sum(aa,3)==255*3)=0;
    end
    if num==1
    img=insertText(s{(i-1)*(m)+1}(xmin:xmax,ymin:ymax,:), [(-xmin+xmax)/2 -50],num2str((i-1)*(m)+1),'FontSize', 200,'BoxOpacity',0);
    else
        img=s{(i-1)*(m)+1}(xmin:xmax,ymin:ymax,:);
    end
    imwrite(img ,tarfilename1,'Alpha',alpha);
    for j=2:m
        [~,newpng,p]=fileparts(pngs((i-1)*(m)+j).name);
        tarfilename = [tarfolder,'/',newpng,'.png'];
        
        mat_horz{i}=cat(2,mat_horz{i},s{(i-1)*(m)+j}(xmin:xmax,ymin:ymax,:));
        %     mat_vert=cat(1,mat_vert,s{i*(kk-1)+j}(xmin:xmax,ymin:ymax,:));
        if alphaa
            aa=s{(i-1)*(m)+j}(xmin:xmax,ymin:ymax,:);
            alpha=ones(xmax-xmin+1,ymax-ymin+1);
            alpha(sum(aa,3)==255*3)=0;
        end
        if num==1
        img=insertText(s{(i-1)*(m)+j}(xmin:xmax,ymin:ymax,:), [(-xmin+xmax)/2 -50],num2str((i-1)*(m)+j),'FontSize', 200,'BoxOpacity',0);
        else
        img=s{(i-1)*(m)+1}(xmin:xmax,ymin:ymax,:);
        end
        imwrite(img ,tarfilename,'Alpha',alpha);
    end
end
if connected
    if res==0
        mat=mat_horz{1};
        for i=2:kk
            mat=cat(1,mat,mat_horz{i});
        end
    else
        if res==1
            mat_horz{kk+1}=s{m*(kk)+1}(xmin:xmax,ymin:ymax,:);
        else
            mat_horz{kk+1}=s{m*(kk)+1}(xmin:xmax,ymin:ymax,:);
            for i=2:res
                mat_horz{kk+1}=cat(2,mat_horz{kk+1},s{kk*(m)+i}(xmin:xmax,ymin:ymax,:));
            end
        end
        for i=1:k
            mat_horz{kk+1}=cat(2,mat_horz{kk+1},uint8(255*ones(size(mat_vert))));
        end
        mat=mat_horz{1};
        for i=2:kk+1
            mat=cat(1,mat,mat_horz{i});
        end
    end
    I=size(mat);
    alpha=ones(I(1),I(2));
    if alphaa
        alpha(sum(mat,3)==255*3)=0;
    end
    imwrite(mat ,tarfilename_horz,'Alpha',alpha);
    I=size(mat_vert);
    alpha=ones(I(1),I(2));
    if alphaa
        alpha(sum(mat_vert,3)==255*3)=0;
    end
    imwrite(mat_vert ,tarfilename_vert,'Alpha',alpha);
end
