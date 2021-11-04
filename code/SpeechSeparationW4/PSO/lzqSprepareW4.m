function [ft_max]=lzqSprepareW4(Z,V,S,S1,S2,Fs1,Fs2,filename1,filename2,upload)

runtime = 50; %���д���
for i = 1:size(S,1)
    SS(i,:)=S(i,:)/max(abs(S(i,:)));
end 
SXcorr(1,:) = xcorr(SS(1,:),SS(2,:));
SMixcorr(1,:) = round(max(SXcorr(1,:)));

for rt = 1:runtime

    rt

    [W2,Emax,fym,Fit,YY,sepresults,Y] = PsoW4(Z,V,rt,upload);  %��������Ⱥ�㷨
    ERT(1,rt) = Emax; %每次达到�?大�?�的收敛迭代次数 
    fitness_max(1,rt) = fym;   
    Data{rt} = W2;
    
    sepresults1(rt).decompMix = sepresults.decompMix;
    sepresults1(1).figReultID(rt,:) = sepresults.figReultID;
    sepresults1(1).Mixcorr(rt,:) = sepresults.Mixcorr;
    
    for i = 1:size(Y,1)
        Y12(i,:)=Y(i,:)/max(abs(Y(i,:)));
    end 
    
    YXcorr(rt,:) = xcorr(Y12(1,:),Y12(2,:));
    YMixcorr(rt,:) = round(max(YXcorr(rt,:)));
    
% ------------------SI_SDR------------------ 
% sisdr1 = R_sisdr1(S,Y)  
SDR(rt,1) = R_sisdr1(S(1,:),YY(1,:)); 
SDR(rt,2) = R_sisdr1(S(2,:),YY(2,:)); 

SDR(rt,4) = R_sisdr1(S(1,:),YY(2,:));
SDR(rt,5) = R_sisdr1(S(2,:),YY(1,:)); 
% ------------------SI_SDR------------------ 


% ------------------STOI--------------------

STOI(rt,1) = stoi(S1,YY(1,:),Fs1);
STOI(rt,2) = stoi(S2,YY(2,:),Fs2);

STOI(rt,4) = stoi(S1,YY(2,:),Fs1);
STOI(rt,5) = stoi(S2,YY(1,:),Fs2);

% ------------------STOI------------------


% ------------------PESQ------------------ 

YY1wav = sprintf( 'YY10%d.wav',rt);
YY2wav = sprintf( 'YY20%d.wav',rt);

YY(1,:) = YY(1,:)/max(max(abs(YY(1,:))));
YY(2,:) = YY(2,:)/max(max(abs(YY(2,:))));

audiowrite([upload,'\1PSO\',YY1wav],YY(1,:),Fs1);
audiowrite([upload,'\1PSO\',YY2wav],YY(2,:),Fs2);

PESQ(rt,1) = pesq_cd(filename1,[upload,'\1PSO\',YY1wav]);
PESQ(rt,2) = pesq_cd(filename2,[upload,'\1PSO\',YY2wav]);

PESQ(rt,4) = pesq_cd(filename1,[upload,'\1PSO\',YY2wav]);
PESQ(rt,5) = pesq_cd(filename2,[upload,'\1PSO\',YY1wav]);



% --------------------------Y--------------------------
% ------------------SI_SDR------------------ 

SDRY(rt,1) = R_sisdr1(S(1,:),Y(1,:)); 
SDRY(rt,2) = R_sisdr1(S(2,:),Y(2,:));  

SDRY(rt,4) = R_sisdr1(S(1,:),Y(2,:)); 
SDRY(rt,5) = R_sisdr1(S(2,:),Y(1,:));
% ------------------SI_SDR------------------ 


% ------------------STOI--------------------
%x--鍘熺煩闃碉紝y--鍒嗙鍚庣殑鐭╅�?, fs_sigal--闊抽棰戠巼

STOIY(rt,1) = stoi(S1,Y(1,:),Fs1);
STOIY(rt,2) = stoi(S2,Y(2,:),Fs2);

STOIY(rt,4) = stoi(S1,Y(2,:),Fs1);
STOIY(rt,5) = stoi(S2,Y(1,:),Fs2);

% ------------------STOI------------------


% ------------------PESQ------------------ 
%闊抽鍛藉悕
Y1wav = sprintf( 'Y10%d.wav',rt);
Y2wav = sprintf( 'Y20%d.wav',rt);

%ref_wav鍒嗙鍓嶇殑闊抽锛宒eg_wav鍒嗙鍚庣殑闊抽�?

Y(1,:) = Y(1,:)/max(max(abs(Y(1,:))));
Y(2,:) = Y(2,:)/max(max(abs(Y(2,:))));

audiowrite([upload,'\1PSO\',Y1wav],Y(1,:),Fs1);
audiowrite([upload,'\1PSO\',Y2wav],Y(2,:),Fs2);

PESQY(rt,1) = pesq_cd(filename1,[upload,'\1PSO\',Y1wav]);
PESQY(rt,2) = pesq_cd(filename2,[upload,'\1PSO\',Y2wav]);

PESQY(rt,4) = pesq_cd(filename1,[upload,'\1PSO\',Y2wav]);
PESQY(rt,5) = pesq_cd(filename2,[upload,'\1PSO\',Y1wav]);
% ------------------PESQ------------------

% --------------------------Y评价指标--------------------------

Fit2(rt,:) = Fit(rt,:);
end

AllMixXcorr = sepresults1.Mixcorr;
for rt1 = 1:runtime
    FinalXcorr(rt1,:) =min(AllMixXcorr(rt1,:));
end
XcorrStd = std(FinalXcorr,1);
XcorrVar = var(FinalXcorr,1);
XcorrMean = mean(FinalXcorr);

ft_max = max(fitness_max);
ft_mean = mean(fitness_max);
ERT_run =  mean(ERT,2);
aaa = std(ERT);
std_aaa = aaa^2;
min_ERT = min(ERT);
max_ERT = max(ERT);
mean_SDR = mean(SDR,1);
mean_STOI = mean(STOI,1);
mean_PESQ = mean(PESQ,1);

save([upload,'\1PSO\PSO01'])
hold off
end
