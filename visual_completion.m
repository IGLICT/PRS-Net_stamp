result = load('./results/last/test_latest/completion.mat');
partobj='./piano_part.obj';
[v_part,f_part]=readOBJ(partobj);
v_part(:,4)=1;
% For better visualization, we rotate the shape and the detected planes to axis-aligned.
axisangle=result.axisangle;
R=axang2rotm(double(axisangle));
vertices=R'*result.vertices';
plane = result.plane0;
[plane, params{1},params{2}, ~]=getplane(plane,result);
lam = v_part*plane';
points = v_part - 2*plane.*lam;
gt=[0,0,1,0];
lam = v_part*gt';
gt_points = v_part - 2*gt.*lam;
points=points(:,1:3);
gt_points=gt_points(:,1:3);
our_d = sqrt(sum((gt_points-points).^2, 2));
our_d = our_d/0.05;
vis(points,f_part,our_d,'leg.ply');

% visualization of the partial shape.
obj_write('./partial_piano.obj', vertices', result.faces, 'none');

% visualization of the detected plane.
obj_write('./partial_piano_plane.obj', params{:},'green');