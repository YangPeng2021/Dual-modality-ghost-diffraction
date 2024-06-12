clear all;
clc;

n=16384;

data=textread('../experiments/dynamic_g3_butterfly.txt');

%% reconstruction
sp_tc=zeros(1,n);
sp=zeros(1,n);
k=1;
%num_pixel=512;
for ii=1:n
        
        sp_tc(ii)=abs(data(k+1)/data(k)-data(k+3)/data(k+2));
        
        k=k+4;
end

sp_tc=sp_tc/max(max(sp_tc));
sp_tc=(sp_tc-min(min(sp_tc)))/(max(max(sp_tc))-min(min(sp_tc)));
measurement=sp_tc;
% % 
% %save('D:/pengyang/pytorch/QUANTUM_GI/experimental_mat/1500_128_3lines_10ml.mat', 'Mea_B_data');
save('./recovered_mat/measurement_transmission_g3_butterfly_10000_dynamic_15ml.mat', 'measurement');
% x=linspace(1,n,n);
% figure;
% %scatter(x,sp);
% scatter(x,sp_tc);
% xlabel('The number of realization','FontName','Times New Roman','FontSize',20)
% ylabel('Collected intensities','FontName','Times New Roman','FontSize',20)
% title('Experimental measurements after dynamic media','FontName','Times New Roman','FontSize',20)
% % 
% figure;
% histogram(sp_tc,'Normalization','pdf')
% ylabel('Probability P','FontName','Times New Roman','FontSize',20)
% title('Probability after dynamic media','FontName','Times New Roman','FontSize',10)

%% DGI reconstruction

mean_B = 0;
mean_I = 0;
mean_R = 0;
O = 0;
k=1;
for ii=1:n
    %randk(ii)
    I1 = im2double(imread(['..\pattern_10000.0_butterfly_final_diffP_shuffle\' num2str(k,'%.5d') '.png']));
    I2 = im2double(imread(['..\pattern_10000.0_butterfly_final_diffP_shuffle\' num2str(k+1,'%.5d') '.png']));
    
    I = I1-I2;
    
    mean_R = (mean_R*(ii-1)+sum(sum(I)))/ii;    % <R>
    mean_B = (mean_B*(ii-1)+sp_tc(ii))/ii;     %  <B>
    BB = sp_tc(ii)-mean_B/mean_R*sum(sum(I));  %  <B>/<R>*R
    mean_I=(mean_I*(ii-1)+I)/ii;                % <I>
    II=I-mean_I;                                % I-<I>
    O=(O*(ii-1)+BB*II)/ii;                      % <(B-<B>/<R>*R)(I-<I>)>
    k=k+2;
end
% I=I/max(max(I));
% I=I(:);
% MSE=mean(mean((data-I).^2))
% PSNR=20*log10(1/sqrt(MSE))

figure,imshow(O,[]),title('Differential ghost imaging')

O=(O-min(min(O)))/(max(max(O))-min(min(O)));
O=O/max(max(O));
imwrite(O,'./transmission_g3_butterfly_10000_dynamic_15ml.png');
