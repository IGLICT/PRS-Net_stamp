function h=ploterrorheatmap(plane,model,w1,w2,h1,h2,id,ndim)
    if ~exist('ndim','var')
        ndim = 3;
    end
    if isfield(model,'axisangle') 
        axisangle=model.axisangle;
        R=axang2rotm(axisangle);
    end
    plane=plane/norm(plane(1,1:3));
    rot_plane=R'*plane(1,1:3)';
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
    if ndim==3
    elseif ndim==2
        rot_plane=rot_plane(1,[1,3,2,4]);
    elseif ndim==1
        rot_plane=rot_plane(1,[3,2,1,4]);
    end
    y = h2:0.001:h1;
    x = w2:0.001:w1;
    [Xp,Yp] = ndgrid(x, y(end:-1:1));
    
    point = [Xp(:), Yp(:),zeros(size(Xp,1)*size(Xp,2),1),ones(size(Xp,1)*size(Xp,2),1)];
    if ndim == 1
        point = point(:,[3,2,1,4]);
    elseif ndim == 2
        point = point(:,[1,3,2,4]);
    end
    
    distance=abs(point*rot_plane');
    distance=reshape(distance,size(Xp,1),size(Xp,2));
    distance=distance';

    [d1,idx1] = min(distance(1,:));
    [d2,idx2] = min(distance(:,1));
    [d3,idx3] = min(distance(end,:));
    [d4,idx4] = min(distance(:,end));
    ndd=[idx1,idx2,idx3,idx4];
    [~,idd] = sort([d1,d2,d3,d4]);
%     min1=ndd(idd(1));
%     min2=ndd(idd(2));
    if isempty(setdiff([idd(1),idd(2)],[2,4]))
        if idd(1)==2
            p2=[w2,-(ndd(idd(1))-1)*0.001+h1];
            p3=[w1,-(ndd(idd(2))-1)*0.001+h1];
        else
            p2=[w2,-(ndd(idd(2))-1)*0.001+h1];
            p3=[w1,-(ndd(idd(1))-1)*0.001+h1];
        end
        v=[w2,h1;p2;p3;w1,h1;w2,h2;w1,h2];
        f=[1,2,3,4;2,5,6,3];
    elseif isempty(setdiff([idd(1),idd(2)],[1,2]))
        if idd(1)==1
            p2=[(ndd(idd(1))-1)*0.001+w2,h1];
            p3=[w2,-(ndd(idd(2))-1)*0.001+h1];
        else
            p2=[(ndd(idd(2))-1)*0.001+w2,h1];
            p3=[w2,-(ndd(idd(1))-1)*0.001+h1];
        end
        v=[w2,h1;p2;p3;w1,h1;w2,h2;w1,h2];
        f=[1,2,3;3,2,5;5,2,4;5,4,6];
    elseif isempty(setdiff([idd(1),idd(2)],[1,4]))
        if idd(1)==1
            p2=[(ndd(idd(1))-1)*0.001+w2,h1];
            p3=[w1,-(ndd(idd(2))-1)*0.001+h1];
        else
            p2=[(ndd(idd(2))-1)*0.001+w2,h1];
            p3=[w1,-(ndd(idd(1))-1)*0.001+h1];
        end
        v=[w2,h1;p2;p3;w1,h1;w2,h2;w1,h2];
        f=[1,2,3;2,4,3;1,3,6;1,6,5];        
    elseif isempty(setdiff([idd(1),idd(2)],[1,3]))
        if idd(1)==1
            p2=[(ndd(idd(1))-1)*0.001+w2,h1];
            p3=[(ndd(idd(2))-1)*0.001+w2,h2];
        else
            p2=[(ndd(idd(2))-1)*0.001+w2,h1];
            p3=[(ndd(idd(1))-1)*0.001+w2,h2];
        end
        v=[w2,h1;p2;p3;w1,h1;w2,h2;w1,h2];
        f=[1,2,3,5;2,4,6,3];        
    elseif isempty(setdiff([idd(1),idd(2)],[2,3]))
        if idd(1)==2
            p2=[w2,-(ndd(idd(1))-1)*0.001+h1];
            p3=[(ndd(idd(2))-1)*0.001+w2,h2];
        else
            p2=[w2,-(ndd(idd(2))-1)*0.001+h1];
            p3=[(ndd(idd(1))-1)*0.001+w2,h2];
        end
        v=[w2,h1;p2;p3;w1,h1;w2,h2;w1,h2];
        f=[1,3,2;1,6,3;2,3,5;1,4,6];        
    elseif isempty(setdiff([idd(1),idd(2)],[3,4]))
        if idd(1)==3
            p2=[(ndd(idd(1))-1)*0.001+w2,h2];
            p3=[w1,-(ndd(idd(2))-1)*0.001+h1];
        else
            p2=[(ndd(idd(2))-1)*0.001+w2,h2];
            p3=[w1,-(ndd(idd(1))-1)*0.001+h1];
        end
        v=[w2,h1;p2;p3;w1,h1;w2,h2;w1,h2];
        f=[1,4,5;5,4,3;5,3,2;2,3,6];        
    end
    p=[v,zeros(size(v,1),1),ones(size(v,1),1)];
    c=abs(p*rot_plane');
    color=imread('./plottingscale.png');
    color = reshape(color(:,1,:),size(color,1),3);

    h=figure(id);
    set(h,'visible','off');
    colormap(double(color)/255);
    set(gca,'Clim',[0 0.05]);
    set(gca,'looseInset',[0 0 0 0]);
    %set(gcf, 'PaperPositionMode','auto');
    axis off;
    axis equal;
    %cb=colorbar;
    %set(cb, 'Position',)
    %cb.Ticks=linspace(0,0.05,5)';
    patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor','interp','EdgeColor','None');
    view([180,-90]);
end