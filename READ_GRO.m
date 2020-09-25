function [ COORDINATES_P3HT ] = READ_GRO( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %[filename, pathname] = uigetfile({'*.gro'},'File Selector');
    fid = fopen(filename);
    tline = fgetl(fid);
    line_NUM=1;
%     P3HT_NUM=0;
        while ischar(tline)
            tline = fgetl(fid);
            line_NUM = line_NUM +1;
        end
    TOTAL_LINES = line_NUM-1;
    fclose(fid); 
    
    COORDINATES_P3HT = zeros(line_NUM-4,4);
    COUNTER=1;
    
    
%         while ischar(tline)
%             if(line_NUM > 2 && line_NUM < TOTAL_LINES )
%                 display(tline(3:6))
%                 if(strcmpi(tline(3:6), val))
%                     P3HT_NUM=P3HT_NUM+1;
%                 end
%             end
%         end
        
        for i=8:10:98
            s=int2str(i);
            fid = fopen(filename);
            tline = fgetl(fid);
            %display(tline)
            line_NUM=1;
            c=1;
            val='P3';
            val1= strcat(val,s);
            while ischar(tline)
                if(line_NUM > 2 && line_NUM < TOTAL_LINES )
                    if(strcmpi(tline(6:9), val1))
                        %COORDINATES_P3HT(COUNTER,1)= counter;
                        COORDINATES_P3HT(COUNTER,1)= str2double(tline(8:9));
                        COORDINATES_P3HT(COUNTER,2)= c;
                        COORDINATES_P3HT(COUNTER,3) = str2double(tline(22:27));
%                       display(COORDINATES_P3HT(COUNTER,2))
                        COORDINATES_P3HT(COUNTER,4) = str2double(tline(30:35));
                        COORDINATES_P3HT(COUNTER,5) = str2double(tline(38:43));
                        COUNTER = COUNTER + 1;   
                        c=c+1;
                    end
                end
                tline = fgetl(fid);
                line_NUM = line_NUM +1;
            end
            fclose(fid);  
            %msgbox('File read into COORDINATES');
        end
        
end
