result = load('./results/last/test_latest/rubost.mat');
% For better visualization, we rotate the shape and the detected planes to axis-aligned.
axisangle=result.axisangle;
R=axang2rotm(double(axisangle));
vertices=R'*result.vertices';
plane = result.plane2;
gt = [0,0,1,0];
[~,~,~,w1,w2,h1,h2]=getplane(gt,result,3);
params={};
[~,params{1},params{2},~]=getplane(plane,result);
figure=ploterrorheatmap(plane,result,w1,w2,h1,h2,1,3);
mkdir('./temp');
print(figure,'-dpng','./temp/error_piano.png');
close(figure);
imgscript('./temp/','png');
movefile('./temp/crop/error_piano.png','error_piano.png');
delete('./temp/error_piano.png');
obj_write('./robust_piano.obj', vertices', result.faces, 'none');
obj_write2('./error.obj','error_piano.png',params{:},'error');