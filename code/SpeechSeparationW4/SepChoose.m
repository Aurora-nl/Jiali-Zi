function [deCompresults,Yfinal]  = SepChoose(rt,sepresults,sigMix,plotOpt,upload)

for Numi=1:length(sepresults)
     Wnew=sepresults(Numi).postion(end,:);
     Wnew=[Wnew;fliplr(Wnew)];
     %Wnew=reshape(Wnew,2,2);
     y_de1=Wnew*sigMix;
   for i =1:2 
        Mixsig(i,:)=sigMix(i,:)/max(abs(sigMix(i,:)));
        desig1(i,:)=y_de1(i,:)/max(abs(y_de1(i,:)));
   end
   y_de2=Mixsig-desig1;
   y_de2_2=Mixsig-flipud(desig1);
    
  decomposeMix=[desig1;y_de2;y_de2_2];   
  maxValue=max(decomposeMix');
% save('F:\result\myDE_28Fun_dim50_0421.mat','mybestresult');
Num=0;
figList=[];
for i=1:size(decomposeMix,1)
%      gg=size(decomposeMix,1)
    for j=i+1:size(decomposeMix,1)
        Num=Num+1;
        xcorrValue(Num,:)=xcorr(decomposeMix(i,:)/maxValue(i),decomposeMix(j,:)/maxValue(j));
        Max_xcorr(Num)=round(max(xcorrValue(Num,:)));
        figList=[figList;i,j];
    end
end
[VRmin,VRindex]=min(Max_xcorr);
figID=figList(VRindex,:);
deCompresults(Numi).decompMix=decomposeMix;
deCompresults(Numi).figReultID=figID;
deCompresults(Numi).Mixcorr=Max_xcorr;

Yfinal(1,:) = decomposeMix(figID(1),:);
Yfinal(2,:) = decomposeMix(figID(2),:);

    if plotOpt
      figure(3)
%       subplot(2,1,1);plot(y_de1(1,:))
%       subplot(2,1,2);plot(y_de1(end,:))    
    for k=1:2  
        subplot(2,1,k);
        plot(y_de1(k,:),'k');
        set(gca,'fontname','Times New Roman','fontsize',9);
        title('No Transpose output signal');
        xlabel('time/ms','fontname','Times New Roman','fontsize',9);
        ylabel('amplitude/um','fontname','Times New Roman','fontsize',9);
    end
    fig3 = sprintf( '2NoTran-Y%d',rt);
    saveas(gcf,[upload,'\10NewDE\',fig3,'.jpg']);  

            if abs(round(Wnew(1,1),2))==abs(round(Wnew(1,2),2))
                figure(4)
%                 subplot(2,1,1);plot(y_de2(1,:));
%                 subplot(2,1,2);plot(y_de2(2,:));
                for k=1:2  
                    subplot(2,1,k);
                    plot(y_de2(k,:),'k');
                    set(gca,'fontname','Times New Roman','fontsize',9);
                    title('x-y output signal 1 ');
                    xlabel('time/ms','fontname','Times New Roman','fontsize',9);
                    ylabel('amplitude/um','fontname','Times New Roman','fontsize',9);
                end
                fig4 = sprintf( '3x-y1%d',rt);
                saveas(gcf,[upload,'\10NewDE\',fig4,'.jpg']); 
    
                figure(5)
%                 subplot(2,1,1);plot(y_de2_2(1,:));
%                 subplot(2,1,2);plot(y_de2_2(2,:));
                for k=1:2  
                    subplot(2,1,k);
                    plot(y_de2_2(k,:),'k');
                    set(gca,'fontname','Times New Roman','fontsize',9);
                    title('x-y output signal 2 ');
                    xlabel('time/ms','fontname','Times New Roman','fontsize',9);
                    ylabel('amplitude/um','fontname','Times New Roman','fontsize',9);
                end
                    fig5 = sprintf( '4x-y2%d',rt);
            %     saveas(gcf,[upload,'\7DE\',fig4,'.jpg']);   
                saveas(gcf,[upload,'\10NewDE\',fig5,'.jpg']); 

%                 figure(6*(Numi-1)+6)
                figure(6)
%                 subplot(2,1,1);plot(Yfinal(1,:),'color','r');
%                 subplot(2,1,2);plot(Yfinal(2,:),'color','r');
                for k=1:2  
                    subplot(2,1,k);
                    plot(Yfinal(k,:),'color','r');
                    set(gca,'fontname','Times New Roman','fontsize',9);
                    title('Final output signal');
                    xlabel('time/ms','fontname','Times New Roman','fontsize',9);
                    ylabel('amplitude/um','fontname','Times New Roman','fontsize',9);
                end
                fig6 = sprintf( '6final-Y%d',rt);
                saveas(gcf,[upload,'\10NewDE\',fig6,'.jpg']); 
                
            end
    end
end

