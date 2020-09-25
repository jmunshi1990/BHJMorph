function [ COORDINATES_P3HT ] = READ_GRO_P3HT_backbone( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [filename, pathname] = uigetfile({'*.xyz'},'File Selector');
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
    fid = fopen(filename);
    tline = fgetl(fid);
    %display(tline)
    line_NUM=1;
    COUNTER = 1;
    val='P3HT';
    
%         while ischar(tline)
%             if(line_NUM > 2 && line_NUM < TOTAL_LINES )
%                 display(tline(3:6))
%                 if(strcmpi(tline(3:6), val))
%                     P3HT_NUM=P3HT_NUM+1;
%                 end
%             end
%         end
        
    
        while ischar(tline)
            if(line_NUM > 2 && line_NUM < TOTAL_LINES )
                if(strcmpi(tline(3:6), val))
                     COORDINATES_P3HT(COUNTER,1)= COUNTER;
                     COORDINATES_P3HT(COUNTER,2) = str2double(tline(15:24));
%                      display(COORDINATES_P3HT(COUNTER,2))
                     COORDINATES_P3HT(COUNTER,3) = str2double(tline(31:40));
                     COORDINATES_P3HT(COUNTER,4) = str2double(tline(48:56));
                     COUNTER = COUNTER + 1;   
                end
            end
            tline = fgetl(fid);
            line_NUM = line_NUM +1;
        end
    fclose(fid);  
    msgbox('File read into COORDINATES');
end
