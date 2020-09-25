%%%%%%%%%%%%%%%%%%IPCE calculation of BHJ morphology using Spatial Discretization%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Author: Joydeep Munshi%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%Group for Interfacial And Nanoengineering (GIAN)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


COORDINATES_P3HT = READ_GRO( 'run_stepdec.gro');
COORDINATES_PCBM = READ_GRO_PCBM( 'run_stepdec.gro');


%%%%%%%%%%%%%%%%%%%%%%%%% pixel morphing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen('run_stepdec.gro');
while ~feof(fid)
    tline = fgetl(fid);
end
lx=str2double(tline(3:8));
%disp(lx)

ly=str2double(tline(13:18));
%disp(ly)

lz=str2double(tline(23:28));
%disp(lz)
N_P3HT=0;
N_PCBM=0;

% Meshgrids%%%%%%%%%%%%%%%%%

deltaX=0.5;
deltaY=0.5;
deltaZ=0.5;
nodeX= round(lx/deltaX);
nodeY= round(ly/deltaY);
nodeZ= round(lz/deltaZ);
Vbox=(nodeX*deltaX)*(nodeY*deltaY)*(nodeZ*deltaZ);
Sp_Dt= zeros(nodeX,nodeY,nodeZ);
c_xp= 0;
c_yp= 0;
c_zp= 0;

for Nx= 1:nodeX
    c_x= deltaX*Nx;
    
    for Ny= 1:nodeY
        c_y= deltaY*Ny;
        for Nz= 1:nodeZ
            l_P3HT= length(COORDINATES_P3HT);
            l_PCBM= length(COORDINATES_PCBM);
        
            c_z= deltaZ*Nz;
        
            for lp= 1:l_P3HT
                if(COORDINATES_P3HT(lp,4) <= c_z && COORDINATES_P3HT(lp,4) > c_zp)
                    if(COORDINATES_P3HT(lp,2) <= c_x && COORDINATES_P3HT(lp,2) > c_xp)
                        if(COORDINATES_P3HT(lp,3) <= c_y && COORDINATES_P3HT(lp,3) > c_yp)
                            N_P3HT= N_P3HT+1;
                        end
                    end
                end
            end
            
            % fprintf('NODE NO: %d %d %d \n',Nx,Ny,Nz); 
            %fprintf('\n');
        
         %   fprintf('No of P3HT is %d', N_P3HT); 
          %  fprintf('\n');
        
        
            for lp= 1:l_PCBM
                if(COORDINATES_PCBM(lp,4) <= c_z && COORDINATES_PCBM(lp,4) > c_zp)
                   if(COORDINATES_PCBM(lp,2) <= c_x && COORDINATES_PCBM(lp,2) > c_xp)
                        if(COORDINATES_PCBM(lp,3) <= c_y && COORDINATES_PCBM(lp,3) > c_yp)
                            N_PCBM= N_PCBM+1;
                        end
                    end
                end
            end
            
           
           % fprintf('No of PCBM is %d \n', N_PCBM); 
           % fprintf('\n');
%             pause(1);
           % clc;
        
            if(N_P3HT==0 && N_PCBM ~= 0)
                Sp_Dt(Nx,Ny,Nz)=1;
            elseif(N_P3HT~=0 && N_PCBM ==0)
                Sp_Dt(Nx,Ny,Nz)=0;
            elseif(N_P3HT>N_PCBM)
                Sp_Dt(Nx,Ny,Nz)=0;
            else
                Sp_Dt(Nx,Ny,Nz)=1;
                %                 Sp_Dt(Nx,Ny)= (N_P3HT-N_PCBM)/(N_P3HT+N_PCBM);
            end
            N_PCBM=0;
            N_P3HT=0;
            c_zp=c_z;
            c_z=0;
        
        end
        
    
        c_yp=c_y;
        c_y=0;
    end
    c_xp=c_x;
    c_x=0;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% calculation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:nodeX
    c1(i)=1;
    r1(i)=i;
    c2(i)=nodeZ;
    r2(i)=i;
end

epsH= 90;
epsE= 340;
epsEx=5.4;
area=nodeX*nodeZ*(0.5^2);

%%%%%%%%%INterfacial area - Psep%%%%%

a1 = diff(logical(Sp_Dt),1,1);
a2 = diff(logical(Sp_Dt),1,2);
a3 = diff(logical(Sp_Dt),1,3);

count = sum(a1(:)== 1)+sum(a1(:)== -1) + sum(a2(:)== 1)+sum(a2(:)== -1)+sum(a3(:)== 1)+sum(a3(:)== -1);

int_area= count*0.25;
gamma= (int_area/Vbox)* 0.5;

%Diffusion prboability Pdiff
Diff1=bwdist(logical(Sp_Dt));
Diff2=bwdist(not(logical(Sp_Dt)));
Diff = 0.5 * (Diff1+Diff2);
Pdiff=exp(-(Diff./epsEx));

% percolation probability (Pcol)

for i= 1:nodeY
    p=squeeze(Sp_Dt(i,:,:));
    BW=logical(p);
    D=bwdistgeodesic(BW,c1,r1);
    conn_pcbm= sum(sum(isinf(D)));
   % display(conn_pcbm)
    tot_pcbm= sum(sum(p(:,:)==1));
   % display(tot_pcbm)
    pcbm_perc_frac(i)=(1-(conn_pcbm/tot_pcbm));
   % display(D)
    
    D(:,:)=zeros;
    
    BWC=not(logical(p));
    D=bwdistgeodesic(BWC,c2,r2);
    conn_p3ht= sum(sum(isinf(D)));
    tot_p3ht= sum(sum(p(:,:)==0));
    p3ht_perc_frac(i)=(1-(conn_p3ht/tot_p3ht));
    
    D(:,:)=zeros;
    p(:,:)=zeros;

end

pcbm_perc= sum(pcbm_perc_frac)/length(pcbm_perc_frac);
p3ht_perc= sum(p3ht_perc_frac)/length(p3ht_perc_frac);
Pcol=p3ht_perc*pcbm_perc;

% percolation distance Sa and Sc and diffusion d
%Percolation

for i= 1:nodeY
    p=squeeze(Sp_Dt(i,:,:));
    BW=logical(p);
    D=bwdistgeodesic(BW,c1,r1);
    [height,width]=size(D);
    Sc=zeros(height,width);
    Sa=zeros(height,width);
    d=zeros(height,width);
    for j= 1:height
        for k=1:width
            if(isnan(D(j,k)))
                Sc(j,k)=Sc(j,k);
                Sa(j,k)=Sa(j,k);
            else
                Sc(j,k)=D(j,k)*0.5;
                Sa(j,k)=Sa(j,k);
            end
% %             if(Diff(j,k)~=0)
% %                 d(j,k)=Diff(j,k)*0.5;
% %             end
        end
    end
    
    
    
    D(:,:)=zeros;
    %Diff(:,:)=zeros;
    
    BWC=not(logical(p));
    D=bwdistgeodesic(BWC,c2,r2);
    [height,width]=size(D);
    for j= 1:height
        for k=1:width
            if(isnan(D(j,k)))
                Sa(j,k)=Sa(j,k);
                Sc(j,k)=Sc(j,k);
            else
                Sa(j,k)=D(j,k)*0.5;
                Sc(j,k)=Sc(j,k);
            end
            
%             if(DiffC(j,k)~=0)
%                 d(j,k)=DiffC(j,k)*0.5;
%             end
        end
    end
    
    
    Ptrans= Pcol*(exp(-(Sa./epsH)).*exp(-(Sc./epsE)));
    P(i)=mean(mean(Ptrans));
    
    
    D(:,:)=zeros;
    p(:,:)=zeros;
    %Diff(:,:)=zeros;
    %DiffC(:,:)=zeros;

end

Ptr=(sum(P)/length(P)) * (mean(mean(mean(Pdiff)))) *gamma;


%fprintf("exciton diffusion to collection probability: %d", Ptr);

fileID= fopen('diffToColProb.txt','w');
fprintf(fileID, '%d', Ptr);
clear;
exit;

%probability of absorption


%IPCE calculation


