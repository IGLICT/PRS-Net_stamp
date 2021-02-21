function obj_write(filename,varargin)  
    if ~isempty(varargin) && mod(length(varargin),3)==0
        fid=fopen(filename,'w');
        mfid=fopen([filename(1:end-4),'.mtl'],'w');
        offset=0;
        for m=1:length(varargin)/3
            vertices=varargin{m*3-2};
            faces=varargin{m*3-1};
            label=varargin{m*3};
            fprintf(mfid,['newmtl mtl',num2str(m),'\r\n']);
            fprintf(mfid,'Ns 0\r\n');
            fprintf(mfid,'Ka %d %d %d\r\n',1,1,1);
            if strcmp(label,'red')
                fprintf(mfid,'Kd %d %d %d\r\n',102/255,0/255,0/255);
                fprintf(mfid,'d 0.8\r\n');
            elseif strcmp(label,'green')
                fprintf(mfid,'Kd %d %d %d\r\n',0/255,104/255,55/255);
                fprintf(mfid,'d 0.8\r\n');
            elseif strcmp(label,'blue')
                fprintf(mfid,'Kd %d %d %d\r\n',0,26/255,1);
                fprintf(mfid,'d 0.8\r\n');
            elseif strcmp(label,'none')
                fprintf(mfid,'Kd %d %d %d\r\n',245/255,245/255,245/255);
            end
            fprintf(mfid,'Ks %d %d %d\r\n',0,0,0);
            fprintf(mfid,'Ke 0 0 0\r\n');
            fprintf(mfid,'illum 2\r\n');

            [x,y]=size(vertices);

             for i=1:x
                fprintf(fid,'v ');
                for j=1:y-1
                    fprintf(fid,'%f ',vertices(i,j));
                end
                fprintf(fid,'%f\r\n',vertices(i,y));

             end

            fprintf(fid,'\n');
            [x,y]=size(faces);

             for i=1:x
                fprintf(fid,'f ');
                for j=1:y-1
                    fprintf(fid,'%d ',faces(i,j)+offset);
                end
                fprintf(fid,'%d\r\n',faces(i,y)+offset);
             end
            offset = offset + size(vertices,1);
               
        end
        fclose(fid); 
        fclose(mfid);
    end
end  