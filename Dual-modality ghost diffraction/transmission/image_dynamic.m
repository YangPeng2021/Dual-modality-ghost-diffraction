clear;close all;clc
%% image read
load './image_mat/butterfly.mat';

figure, imshow(data,[]),title('Original image')
Mea1 = textread('../experiments/dynamic_g3_butterfly.txt');
M = 16384;
%% reconstruction
sp=zeros(1,M);
sp_ori_f=zeros(1,M);
k=1;
%num_pixel=512;
for ii=1:M
        T1=Mea1(k);
        sp1=Mea1(k+1)/T1;
    
        T2=Mea1(k+2);
        sp2=Mea1(k+3)/T2;
    
        sp(ii)=sp1-sp2;
        
        sp_ori_f(ii)=Mea1(k+1)-Mea1(k+3);
        k=k+4;
end
%%
sp_change=reshape(sp,[128,128]);
sp_change=imrotate(sp_change,270);
sp_change=fliplr(sp_change);
sp_change=(sp_change-min(min(sp_change)))/(max(max(sp_change))-min(min(sp_change)));
figure, imshow(sp_change,[])
%imwrite(sp_change,'./g2_dog_dynamic_15ml_trans_new.png');
%%
sp_ori=reshape(sp_ori_f,[128,128]);
sp_ori=imrotate(sp_ori,270);
sp_ori=fliplr(sp_ori);
sp_ori=sp_ori/max(max(sp_ori));
figure, imshow(sp_ori,[]),title('Retrieved image-no reference')
MSE_ori=mean(mean((data-sp_ori).^2))
PSNR_ori=20*log10(1/sqrt(MSE_ori))
%imwrite(sp_ori,'g2_dog_dynamic_noref.png')
%%
one_d=data(30,:);
one_s=sp_change(30,:);
one_o=sp_ori(30,:);

MSE=mean(mean((data-sp_change).^2))
PSNR=20*log10(1/sqrt(MSE))
SSIM=ssim(sp_change,data)
% 
MSE=mean(mean((one_d-one_s).^2))
PSNR=20*log10(1/sqrt(MSE))