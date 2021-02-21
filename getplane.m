function [plane,v,f,w1,w2,h1,h2]=getplane(plane,model,idx)

    if size(plane,2)==1
        plane=plane';
    end
    plane=plane/norm(plane(1,1:3));
    f=[1,2,3;
         3,2,4];
    axisangle=model.axisangle;
    R=axang2rotm(double(axisangle));
    rot_plane=R'*plane(1:3)';
    rot_plane=rot_plane';
    [~,idx_]=max(abs(plane(1,1:3)));
    if idx_==3
        q=[0,0,-plane(4)/plane(3)];
    elseif idx_==2
        q=[0,-plane(4)/plane(2),0];
    elseif idx_==1
        q=[-plane(4)/plane(1),0,0];
    end
    rot_q=R'*q';
    rot_plane=[rot_plane,-rot_plane(1:3)*rot_q];
    points=R'*model.vertices';
    points=points';
    if nargin==2
        [~,idx]=max(abs(rot_plane(1,1:3)));
    end
    if idx==3
    elseif idx==2
        points=points(:,[1,3,2]);
        rot_plane=rot_plane(1,[1,3,2,4]);
    elseif idx==1
        points=points(:,[3,2,1]);
        rot_plane=rot_plane(1,[3,2,1,4]);
    end
        w1=max(points(:,1))+0.1;
        w2=min(points(:,1))-0.1;
        h1=max(points(:,2))+0.1;
        h2=min(points(:,2))-0.1;
        a=[w1,h1;w1,h2;w2,h1;w2,h2];
        a1 = [a,ones(4,1)];
        x=[rot_plane(1:2),rot_plane(4)];
        v=[a,-a1*x'/rot_plane(3)];
        if idx==3
            v=v;
        elseif idx==2
            v=v(:,[1,3,2]);
        elseif idx==1
            v=v(:,[3,2,1]);
        end
        plane=cross(v(1,:)-v(2,:),v(2,:)-v(3,:));
        plane=plane./norm(plane);
        d=-sum(plane.*v(4,:),2);
        plane(:,4)=d;
end