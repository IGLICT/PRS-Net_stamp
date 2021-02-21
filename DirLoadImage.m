%ModelNum = 7;
%ModelFolder = 'E:\project\morphing\example\example1\dense_rbf_morphing';
%ModelFolder = 'E:\project\scape\script2\png';
%suffix = '.png';
pngs = dir(fullfile([ModelFolder,'/*.',suffix]));dircell=struct2cell(pngs)';
filenames=dircell(:,1);
ModelNum = length(pngs);
newpng_=zeros(ModelNum,1);
[~,order]=sort_nat({pngs.name});
pngs=pngs(order);
% for i=1:ModelNum
%     [m,newpng,p]=fileparts(char(filenames(i)));
%     newpng_(i,:)=sscanf(char(filenames(i)),'%d');
% %     newpng_(i,:)=int32(newpng)-48*ones(1,size(newpng,2));
% end
% % newpng=struct2mat(cell2struct(newpng,'name',1));
% [~,i]=sort(newpng_);
% filenames=filenames(i);
% [m,newpng,p]=fileparts(char(filenames));
% ModelNum = length(pngs);
s=cell(1,ModelNum);
for i = 1 : ModelNum
    pngfile=[ModelFolder,'/',pngs(i).name];
    s{i}=imread(pngfile);
end


%generate LoadModel Scripe
% LoadScripteName = 'LoadModelScript.m';
% fid = fopen(LoadScripteName,'w');
% 
% for i = 1 : ModelNum
%     modelname = ['''',ModelFolder,'\',num2str(i),suffix,''''];
%     shapename = ['shape',num2str(i)];
%     facename = ['face',num2str(i)];
%     %fprintf(fid, 'modelname=%s\n',modelname);
%     %fprintf(fid, '[%s %s] = LoadObj(modelname);\n',shapename,facename);
%     sname=['s',num2str(i)];
%     s{i}=[];
%     fprintf(fid,'[s{%s}] = imread(%s);\n', num2str(i), modelname);
% end
% fclose(fid);
% dos('ipconfig');
% LoadModelScript;
