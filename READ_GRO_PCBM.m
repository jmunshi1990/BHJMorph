function [ COORDINATES_PCBM ] = READ_GRO_PCBM( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [filename, pathname] = uigetfile({'*.gro'},'File Selector');
    fid = fopen(filename);
    tline = fgetl(fid);
    line_NUM=1;
        while ischar(tline)
            tline = fgetl(fid);
            line_NUM = line_NUM +1;
        end
    TOTAL_LINES = line_NUM-1;
    fclose(fid);  
    COORDINATES_PCBM = zeros(line_NUM-4,4);
    fid = fopen(filename);
    tline = fgetl(fid);
    line_NUM=1;
    COUNTER = 1;
    val='PCBM';
        while ischar(tline)
            if(line_NUM > 2 && line_NUM < TOTAL_LINES )
                if(strcmpi(tline(6:9), val))
                       COORDINATES_PCBM(COUNTER,1)= COUNTER;
                     COORDINATES_PCBM(COUNTER,2) = str2double(tline(22:27));
%                      display(COORDINATES_P3HT(COUNTER,2))
                     COORDINATES_PCBM(COUNTER,3) = str2double(tline(30:35));
                     COORDINATES_PCBM(COUNTER,4) = str2double(tline(38:43));
                     COUNTER = COUNTER + 1;   
                end
            end
            tline = fgetl(fid);
            line_NUM = line_NUM +1;
        end
    fclose(fid);  
    msgbox('File read into COORDINATES');
end