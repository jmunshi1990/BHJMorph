function [p3ht_domain,pcbm_domain] = dom_size(Pi,nodeZ)
% nodeX= 30;
% nodeY= 30;
% nodeZ= 13;
Sp_Dt= Pi;
%Tot_Area= 0.25;
% c_xp= 0;
% c_yp= 0;
% c_zp= 0;
p3ht_area=zeros(nodeZ);
pcbm_area=zeros(nodeZ);

%P3HT domain size calculation
fprintf('calculating P3HT domain size \n')
for Nz=1:nodeZ
    Sp_layer= squeeze(Sp_Dt(:,:,Nz));
    count= sum(Sp_layer(:)==1);
    p3ht_area(Nz)=count*(0.5^2);
end

p3ht_area_av= sum(p3ht_area)/length(p3ht_area);
p3ht_domain= sqrt(2*p3ht_area_av);

fprintf('Average P3HT domain size: %d \n', p3ht_domain);
fprintf('done \n \n')
fprintf('calculating PCBM domain size \n')

for Nz=1:nodeZ
    Sp_layer= squeeze(Sp_Dt(:,:,Nz));
    count= sum(Sp_layer(:)==0);
    pcbm_area(Nz)=count*(0.5^2);
end

pcbm_area_av= sum(pcbm_area)/length(pcbm_area);
pcbm_domain= sqrt(2*pcbm_area_av);

fprintf('Average PCBM domain size: %d \n', pcbm_domain);
fprintf('done \n \n')

end

