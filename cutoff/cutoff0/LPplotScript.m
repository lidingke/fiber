load('LPmat.mat')
LPmat=[LP01a.complexEx,LP01b.complexEx,LP11a.complexEx,LP11b.complexEx,LP11a1.complexEx,LP11b1.complexEx];
sigma = 4.5e9;
[ UMmat ] = UnitaryMatrix( sigma );
size(UMmat.UnitaryMatrix)
size(LPmat)
%plotmat=UMmat.UnitaryMatrix(1,1)*LPmat(1)+UMmat.UnitaryMatrix(1,2)*LPmat(2)+UMmat.UnitaryMatrix(1,3)*LPmat(3)+UMmat.UnitaryMatrix(1,4)*LPmat(4)+UMmat.UnitaryMatrix(1,5)*LPmat(5)+UMmat.UnitaryMatrix(1,6)*LPmat(6);
plotmat=UMmat.UnitaryMatrix(1,1)*LP01a.complexEx+UMmat.UnitaryMatrix(1,2)*LP01b.complexEx+UMmat.UnitaryMatrix(1,3)*LP11a.complexEx...
+UMmat.UnitaryMatrix(1,4)*LP11b.complexEx+UMmat.UnitaryMatrix(1,5)*LP11a1.complexEx+UMmat.UnitaryMatrix(1,1)*LP11b1.complexEx;
size(plotmat)

% %plotmat=LPmat;
% LPcell={'LP01a','LP01b','LP11a','LP11b','LP11a1','LP11b1'};
% %LP01,LP11axaybxby
% lenplot=size(plotmat,1);
% plotall=zeros(lenplot);
% 
% for plotmark=1:6
%     
%     plotmatf=plotmat(:,1:lenplot);
%     size(plotmat)
%     plotmat(:,1:lenplot)=[];
% %     xlsname=['plot',char(LPcell(plotmark)),'.csv'];
% %     [ LPPLOT ] = csvRExREyIExIEy( xlsname );
% %     figure(plotmark)
% %     imagesc(abs(plotmatf));
% %     title(xlsname)
%     plotall=plotall+plotmatf;
% end

    figure(10)
    imagesc(abs(plotmat));
