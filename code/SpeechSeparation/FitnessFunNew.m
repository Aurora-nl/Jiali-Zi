function fitness =  FitnessFunNew(W,X)
%W=reshape(W,2,2);
W=[W;fliplr(W)];
Y = W*X;
j = size(Y,1);
fitness_x = 0;
wflag=W>0.01;
for o = 1:j
    yi = Y(o,:);
   f = (1/48* ((mean(yi.^4)/(mean(yi.^2).^2))-3));
    fitness_x = fitness_x+f;
    Y(o,:)=Y(o,:)/max(abs(Y(o,:)));
   
end
xcorrValue=xcorr(Y(1,:),Y(2,:));
YMax_xcorr = round(max(xcorrValue));
fitness = 1/fitness_x + 1/YMax_xcorr;
end