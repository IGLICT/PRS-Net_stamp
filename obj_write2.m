function obj_write2(filename,colorpath,varargin)
    colorpath=strrep(colorpath,'\','\\\\');
    if ~isempty(varargin) && mod(length(varargin),3)==0
        fid=fopen(filename,'w');
        mfid=fopen([filename(1:end-4),'.mtl'],'w');
        offset=0;
        temp=split(filename,{'\','/'});
        fprintf(fid,['mtllib ',temp{end}(1:end-4),'.mtl\r\n']);
        for m=1:length(varargin)/3
            vertices=varargin{m*3-2};
            faces=varargin{m*3-1};
            label=varargin{m*3};
            fprintf(fid,['usemtl mtl',num2str(m),'\r\n']);
            fprintf(mfid,['newmtl mtl',num2str(m),'\r\n']);
            fprintf(mfid,'Ns 0\r\n');
            fprintf(mfid,'Ka %d %d %d\r\n',1,1,1);
            fprintf(mfid,'Ks %d %d %d\r\n',0,0,0);
            fprintf(mfid,'Ke 0 0 0\r\n');
            fprintf(mfid,'illum 2\r\n');
            if strcmp(label,'none')
                fprintf(mfid,'Kd %d %d %d\r\n',245/255,245/255,245/255);
            else
                fprintf(mfid,'d 0.85\r\n');
                fprintf(mfid,['map_Kd ',colorpath,'\r\n']);
            end
            [x,y]=size(vertices);
             for i=1:x
                fprintf(fid,'v ');
                for j=1:y-1
                    fprintf(fid,'%f ',vertices(i,j));
                end
                fprintf(fid,'%f\r\n',vertices(i,y));
             end
            fprintf(fid,'\n');
            fprintf(fid,'vt 0.0001 0.9999\r\n vt 0.0001 0.0001\r\n vt 0.9999 0.9999\r\n vt 0.9999 0.0001\r\n');
            fprintf(fid,'f %d/1 %d/2 %d/3 \r\n',faces(1,1)+offset,faces(1,2)+offset,faces(1,3)+offset);
            fprintf(fid,'f %d/3 %d/2 %d/4 \r\n',faces(2,1)+offset,faces(2,2)+offset,faces(2,3)+offset);
            offset = offset + size(vertices,1);
        end
        fclose(fid); 
        fclose(mfid);
    end
end  