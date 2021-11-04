function fitness =  FitnessFun(W,Z)
W=[W;fliplr(W)];
Y =  W * Z;
j = size(Y,1);
fitness_x = 0;
for o = 1:j
    yi = Y(o,:);
     f = (1/48* ((mean(yi.^4)/(mean(yi.^2).^2))-3));
    fitness_x = fitness_x+f;
end
fitness = 1/fitness_x;
end