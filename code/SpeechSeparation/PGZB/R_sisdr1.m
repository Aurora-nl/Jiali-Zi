% function sisdr1 = R_sisdr1(S,Y)
% 
%     fss1=norm(S)^2; 
%     s1t=(S.*Y)/fss1;%S1源信号，sig1ric分离信号，结果
%     s1T=s1t.*S;
%     s1e=Y-s1T;
%     sisdr1=10*log10(norm(s1T)^2/norm(s1e)^2);
% end

function SISDR = R_sisdr1(clean_sig, rec_sig)
    clean_sig = clean_sig-mean(clean_sig)
    rec_sig = rec_sig-mean(rec_sig)
    s_target = dot(rec_sig, clean_sig) * clean_sig/dot(clean_sig, clean_sig);
    e_noise = rec_sig - s_target;
    SISDR = 10*log10(dot(s_target, s_target)/dot(e_noise, e_noise));

end