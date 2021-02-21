
function imgscript(ModelFolder,suffix)
%ModelNum = 71;
%ModelNum = 49;
%ModelFolder = 'E:\project\morphing\example\example10\rbf_morphing60'
%tarfolder =   'E:\project\morphing\example\example10\rbf_morphing60\crop'
%ModelFolder = 'E:\project\scapemodels';
%tarfolder = 'E:\project\scapemodels\crop'
%ModelNum = 202;
%ModelFolder = 'E:\SIGA2014\example\morphing\cylinder\case5\laplacealign';

%tarfolder = 'E:\project\scape\script2\png\rbf\crop'
% ModelFolder = 'F:\yangjiee\sig17\model_analysis\result_model_num_1\25_model\model';
global connected col alphaa num
alphaa=1;
connected=0;
col=1;
num=0;
tarfolder = [ModelFolder,'/crop'];
if ~exist(tarfolder,'file')
    mkdir(tarfolder);
end

DirLoadImage;
if connected==0
CropImage;
end
SaveImages;

clear
end