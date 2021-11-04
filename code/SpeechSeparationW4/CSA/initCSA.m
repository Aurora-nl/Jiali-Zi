function [x]=initCSA(N,pd,Lb,Ub) % 函数初始化

for i=1:N % Generation of initiaLb soLbUbtions (position of crows)初始解的生成(乌鸦的位置)
    for j=1:pd
        x(i,j)=Lb-(Lb-Ub)*rand; % Position of the crows in the space乌鸦在空间中的位置
    end
end