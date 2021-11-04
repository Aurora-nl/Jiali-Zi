function [ft_max]=SprepareDEW4(s,X,S,S1,S2,Fs1,Fs2,filename1,filename2,upload)
close('7')

runtime = 50; %运行次数
for rt = 1:runtime
    rt
    [W1,Emax,fym,Fit,YY,sepresults,Y] = DE_sprepareW4(s,X,rt,upload) ;
  
    ERT(1,rt) = Emax; %每次达到�?大�?�的收敛迭代次数
    fitness_max(1,rt) = fym;
    
    Data{rt} = W1;
    sepresults1(rt).decompMix = sepresults.decompMix;
    sepresults1(1).figReultID(rt,:) = sepresults.figReultID;
    sepresults1(1).Mixcorr(rt,:) = sepresults.Mixcorr;
    
    for i = 1:size(Y,1)
        Y12(i,:)=Y(i,:)/max(abs(Y(i,:)));
    end 
    YXcorr(rt,:) = xcorr(Y12(1,:),Y12(2,:));
    YMixcorr(rt,:) = round(max(YXcorr(rt,:)));

% ------------------SI_SDR------------------ 
% sisdr1 = R_sisdr1(S,Y)  %S 源信�? ，Y为分离信�?

%由于不确定分离的信号的顺序，故将分离的信号都与源信号计算相应的SISDR的�??
%S1源信号分别与分离信号Y1 Y2 YY1 YY2计算SISDR�?
SDR(rt,1) = R_sisdr1(S(1,:),YY(1,:)); 
SDR(rt,2) = R_sisdr1(S(2,:),YY(2,:)); %S2YY2未转�?

SDR(rt,4) = R_sisdr1(S(1,:),YY(2,:));
SDR(rt,5) = R_sisdr1(S(2,:),YY(1,:)); %S2YY1 未转�?


% ------------------SI_SDR------------------ 


% ------------------STOI--------------------
%x--原矩阵，y--分离后的矩阵, fs_sigal--音频频率

%S1源信号分别与分离信号Y1 Y2 YY1 YY2计算STOI�?
STOI(rt,1) = stoi(S1,YY(1,:),Fs1);
STOI(rt,2) = stoi(S2,YY(2,:),Fs2);

STOI(rt,4) = stoi(S1,YY(2,:),Fs1);
STOI(rt,5) = stoi(S2,YY(1,:),Fs2);


% ------------------STOI------------------

% ------------------PESQ------------------ 
%音频命名
YY1wav = sprintf( 'YY10%d.wav',rt);
YY2wav = sprintf( 'YY20%d.wav',rt);

%ref_wav分离前的音频，deg_wav分离后的音频
YY(1,:) = YY(1,:)/max(max(abs(YY(1,:))));
YY(2,:) = YY(2,:)/max(max(abs(YY(2,:))));

audiowrite([upload,'\7DE\',YY1wav],YY(1,:),Fs1);
audiowrite([upload,'\7DE\',YY2wav],YY(2,:),Fs2);

PESQ(rt,1) = pesq_cd(filename1,[upload,'\7DE\',YY1wav]);
PESQ(rt,2) = pesq_cd(filename2,[upload,'\7DE\',YY2wav]);

PESQ(rt,4) = pesq_cd(filename1,[upload,'\7DE\',YY2wav]);
PESQ(rt,5) = pesq_cd(filename2,[upload,'\7DE\',YY1wav]);


% --------------------------Y评价指标--------------------------
% ------------------SI_SDR------------------ 
% sisdr1 = R_sisdr1(S,Y)  %S 婧愪俊鍙? 锛孻涓哄垎绂讳俊�??

%鐢变簬涓嶇�?��?�氬垎绂荤殑淇�?�彿鐨勯『搴忥紝鏁呭皢鍒嗙鐨勪俊鍙烽兘涓庢簮淇″彿璁＄畻鐩稿簲鐨凷ISDR鐨勫??
%S1婧愪俊鍙峰垎鍒笌鍒嗙淇�?�彿Y1 Y2 YY1 YY2璁＄畻SISDR�??
SDRY(rt,1) = R_sisdr1(S(1,:),Y(1,:)); %S1YY1 鏈浆缃?
SDRY(rt,2) = R_sisdr1(S(2,:),Y(2,:));  %S2YY2鏈浆缃?

SDRY(rt,4) = R_sisdr1(S(1,:),Y(2,:)); %S1YY2 鏈浆缃?
SDRY(rt,5) = R_sisdr1(S(2,:),Y(1,:)); %S2YY1 鏈浆缃?
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

audiowrite([upload,'\7DE\',Y1wav],Y(1,:),Fs1);
audiowrite([upload,'\7DE\',Y2wav],Y(2,:),Fs2);

PESQY(rt,1) = pesq_cd(filename1,[upload,'\7DE\',Y1wav]);
PESQY(rt,2) = pesq_cd(filename2,[upload,'\7DE\',Y2wav]);

PESQY(rt,4) = pesq_cd(filename1,[upload,'\7DE\',Y2wav]);
PESQY(rt,5) = pesq_cd(filename2,[upload,'\7DE\',Y1wav]);
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


save([upload,'\7DE\DE01'])
hold off
end

