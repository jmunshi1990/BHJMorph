function [gamma] = interface_area(Pi,nodeX,nodeY,nodeZ)

% nodeX= 30;
% nodeY= 30;
% nodeZ= 13;
Vbox=(nodeX*0.5)*(nodeY*0.5)*(nodeZ*0.5);
Sp_Dt= Pi;
% c_xp= 0;
% c_yp= 0;
% c_zp= 0;
int_areaxy=zeros(nodeZ);
int_areayz=zeros(nodeX);

%slice through z-plane

for Nz=1:nodeZ
    Sp_z= squeeze(Sp_Dt(:,:,Nz));
    int_x= diff(Sp_z);
    int_y= diff(Sp_z,1,2);
    count= sum(int_x(:)== 1)+sum(int_x(:)== -1)+sum(int_y(:)== 1)+sum(int_y(:)== -1);
    int_areaxy(Nz) = (count)*0.25;
end

int_x(:)=0;
int_y(:)=0;
count=0;

%slice through x-plane

for Nx=1:nodeX
    Sp_x= squeeze(Sp_Dt(Nx,:,:));
    int_y= diff(Sp_x);
    int_z= diff(Sp_x,1,2);
    count= sum(int_z(:)== 1)+sum(int_z(:)== -1)+sum(int_y(:)== 1)+sum(int_y(:)== -1);
    int_areayz(Nx) = (count)*0.25;
end

a=sum(int_areaxy);
b=sum(int_areaxy);

int_area= a(1)+b(1);
gamma= int_area/Vbox;
    

