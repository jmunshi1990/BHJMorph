function [Sp_Dt  ] = pixel_morph( COORDINATES_P3HT,COORDINATES_PCBM,lx,ly,lz )

% lx= 150;
% ly=150;
% lz=64.6624;
N_P3HT=0;
N_PCBM=0;

% Meshgrids%%%%%%%%%%%%%%%%%

deltaX=0.5;
deltaY=0.5;
deltaZ=0.5;
nodeX= round(lx/deltaX);
nodeY= round(ly/deltaY);
nodeZ= round(lz/deltaZ);
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
                if(COORDINATES_P3HT(lp,1) == 58 && COORDINATES_P3HT(lp,5) <= c_z && COORDINATES_P3HT(lp,5) > c_zp)
                    if(COORDINATES_P3HT(lp,3) <= c_x && COORDINATES_P3HT(lp,3) > c_xp)
                        if(COORDINATES_P3HT(lp,4) <= c_y && COORDINATES_P3HT(lp,4) > c_yp)
                            N_P3HT= N_P3HT+1;
                        end
                    end
                end
            end
            
             fprintf('NODE NO: %d %d %d \n',Nx,Ny,Nz); 
            fprintf('\n');
        
            fprintf('No of P3HT is %d', N_P3HT); 
            fprintf('\n');
        
        
            for lp= 1:l_PCBM
                if(COORDINATES_PCBM(lp,4) <= c_z && COORDINATES_PCBM(lp,4) > c_zp)
                    if(COORDINATES_PCBM(lp,2) <= c_x && COORDINATES_PCBM(lp,2) > c_xp)
                        if(COORDINATES_PCBM(lp,3) <= c_y && COORDINATES_PCBM(lp,3) > c_yp)
                            N_PCBM= N_PCBM+1;
                        end
                    end
                end
            end
            
           
            fprintf('No of PCBM is %d \n', N_PCBM); 
            fprintf('\n');
%             pause(1);
            clc;
        
            if(N_P3HT==0 && N_PCBM==0)
                Sp_Dt(Nx,Ny,Nz)=0;
            else
                if(N_P3HT>N_PCBM)
                    Sp_Dt(Nx,Ny,Nz)=1;
                else
                    Sp_Dt(Nx,Ny,Nz)=-1;
                end
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
end


