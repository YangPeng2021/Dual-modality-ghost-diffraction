clear;close all;clc
%% image read
load './image_mat/butterfly.mat';
figure, imshow(data,[]),title('Original image')
Mea1 = textread('../experiments/static_g3_butterfly.txt');
M = 16384;
%% reconstruction
sp=zeros(1,M);
k=1;
num_pixel=50;
for ii=1:M

       sp1=Mea1(k);

        sp2=Mea1(k+1);
        sp(ii)=abs(sp1-sp2);
        k=k+2;
end
%%
sp=reshape(sp,[128,128]);
sp=imrotate(sp,270);
sp=fliplr(sp);
sp=sp/max(max(sp));
figure, imshow(sp,[])
%imwrite(sp,'./image_butterfly_g2_static_new.png')
%%
%MSE=mean(mean((data(:,30)-sp(:,30)).^2))
one_d=data(30,:);
one_s=sp(30,:);

MSE=mean(mean((one_d-one_s).^2))
PSNR=20*log10(1/sqrt(MSE))

MSE=mean(mean((data-sp).^2))
SSIM=ssim(data,sp)
PSNR=20*log10(1/sqrt(MSE))