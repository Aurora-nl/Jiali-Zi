function kidsPop = Variation(kidsPop,VARIATIONRATE)
for n=1:size(kidsPop,1)
    if rand<VARIATIONRATE
        temp = kidsPop{n};
        %ÕÒµ½±äÒìÎ»ÖÃ
        location = ceil(length(temp)*rand);
        temp = [temp(1:location-1) num2str(~temp(location))...
            temp(location+1:end)];
       kidsPop{n} = temp;
    end
end