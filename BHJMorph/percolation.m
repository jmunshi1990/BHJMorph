function [p3ht_ratio,pcbm_ratio] = percolation(Pi,nodeX,nodeY,nodeZ)

Sp_Dt=Pi;
p_count=0;

%P3HT percolation calculation
for Nx=1:nodeX
    Sp_x= squeeze(Sp_Dt(Nx,:,:));
    for Nz=1:nodeZ
        Ny_s=1;
        Ny_n=5;
        for Ny=1:(nodeY/5)
            per_slicey(Ny,Nz)= sum(Sp_x(Ny_s:Ny_n,Nz));
            Ny_s=Ny_s+5;
            Ny_n=Ny_n+5;
        end
    end
    for Ny=1:(nodeY/5)
        if(sum(per_slicey(Ny,:)==0)==0)
            p_count=p_count+1;
        end
    end
    p_fracy(Nx)=p_count/6;
    p_count=0;
end

p_count=0;

% for Ny=1:nodeY
%     Sp_y= squeeze(Sp_Dt(:,Ny,:));
%     for Nz=1:nodeZ
%         Nx_s=1;
%         Nx_n=5;
%         for Nx=1:(nodeX/5)
%             per_slicex(Nx,Nz)= sum(Sp_y(Nx_s:Nx_n,Nz));
%             Nx_s=Nx_s+5;
%             Nx_n=Nx_n+5;
%         end
%     end
%     for Nx=1:(nodeX/5)
%         if(sum(per_slicex(Nx,:)==0)==0)
%             p_count=p_count+1;
%         end
%     end
%     p_fracx(Ny)=p_count/6;
%     p_count=0;
% end

% p3ht_ratio=0.5*(sum(p_fracx)/length(p_fracx)+sum(p_fracy)/length(p_fracy));
p3ht_ratio=sum(p_fracy)/length(p_fracy);
p_fracy(:)=0;
per_slicey(:,:)=0;
Sp_x(:,:)=0;


%PCBM percolation calculation
for Nx=1:nodeX
    Sp_x= squeeze(Sp_Dt(Nx,:,:));
    for Nz=1:nodeZ
        Ny_s=1;
        Ny_n=5;
        for Ny=1:(nodeY/5)
            per_slicey(Ny,Nz)= sum(Sp_x(Ny_s:Ny_n,Nz)==0)+sum(Sp_x(Ny_s:Ny_n,Nz)==0.5);
            Ny_s=Ny_s+5;
            Ny_n=Ny_n+5;
        end
    end
    for Ny=1:(nodeY/5)
        if(sum(per_slicey(Ny,:)==0)==0)
            p_count=p_count+1;
        end
    end
    p_fracy(Nx)=p_count/6;
    p_count=0;
end

pcbm_ratio=sum(p_fracy)/length(p_fracy);

end

