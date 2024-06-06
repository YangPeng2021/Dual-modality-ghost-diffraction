clear all;
clc;

n=16384;

data=textread('../experiments/static_g3_butterfly.txt');

%% reconstruction
sp_tc=zeros(1,n);
sp=zeros(1,n);
k=1;
for ii=1:n
        
        sp_tc(ii)=abs(data(k)-data(k+1));
        
        k=k+2;
end

%sp_tc=sp_tc/max(max(sp_tc));
%sp_tc=(sp_tc-min(min(sp_tc)))/(max(max(sp_tc))-min(min(sp_tc)));
measurement=sp_tc;
save('./recovered_mat/measurement_transmission_g3_butterfly_static.mat', 'measurement');

%% DGI reconstruction

mean_B = 0;
mean_I = 0;
mean_R = 0;
O = 0;
k=1;
for ii=1:n
    %randk(ii)
    I1 = im2double(imread(['..\transmission\pattern_10000.0_butterfly_final_diffP_shuffle\' num2str(k,'%.5d') '.png']));
    I2 = im2double(imread(['..\transmission\pattern_10000.0_butterfly_final_diffP_shuffle\' num2str(k+1,'%.5d') '.png']));
    
    I = I1-I2;
    
    mean_R = (mean_R*(ii-1)+sum(sum(I)))/ii;    % <R>
    mean_B = (mean_B*(ii-1)+sp_tc(ii))/ii;     %  <B>
    BB = sp_tc(ii)-mean_B/mean_R*sum(sum(I));  %  <B>/<R>*R
    mean_I=(mean_I*(ii-1)+I)/ii;                % <I>
    II=I-mean_I;                                % I-<I>
    O=(O*(ii-1)+BB*II)/ii;                      % <(B-<B>/<R>*R)(I-<I>)>
    k=k+2;
end

figure,imshow(O,[]),title('Differential ghost imaging')
O=(O-min(min(O)))/(max(max(O))-min(min(O)));
imwrite(O,'./g3_butterfly _static_16384_new.png');

