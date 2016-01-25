clc;clear;
%%
xlsname = 'plotLP01a.csv';
[ LP01a ] = csvRExREyIExIEy( xlsname );
figure(1)
imagesc(abs(LP01a.complexEx));
title(xlsname)
%%
xlsname = 'plotLP01b.csv';
[ LP01b ] = csvRExREyIExIEy( xlsname );
figure(2)
imagesc(abs(LP01b.complexEx));
title(xlsname)
%%
xlsname = 'plotLP11a.csv';
[ LP11a ] = csvRExREyIExIEy( xlsname );
figure(3)
imagesc(abs(LP11a.complexEx));
title(xlsname)
%%
xlsname = 'plotLP11b.csv';
[ LP11b ] = csvRExREyIExIEy( xlsname );
figure(4)
imagesc(abs(LP11b.complexEx));
title(xlsname)
%%
xlsname = 'plotLP11a1.csv';
[ LP11a1 ] = csvRExREyIExIEy( xlsname );
figure(5)
imagesc(abs(LP11a1.complexEx));
title(xlsname)
%%
xlsname = 'plotLP11b1.csv';
[ LP11b1 ] = csvRExREyIExIEy( xlsname );
figure(6)
imagesc(abs(LP11b1.complexEx));
title(xlsname)

%%
load('LPmat.mat')
LPmat=[LP01a.complexEx,LP01b.complexEx,LP11a.complexEx,LP11b.complexEx,LP11a1.complexEx,LP11b1.complexEx]';
sigma = 4.5e-9;
[ UMmat ] = UnitaryMatrix( sigma );
plotmat=UMmat(1,:)*LPmat;




