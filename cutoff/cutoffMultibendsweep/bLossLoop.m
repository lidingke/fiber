clc,clear;
tic
angEnd = 90;
angStep = 5;
angLength = length(0:angStep:angEnd);
plotLoss = zeros(19,8);
for i=0:angStep:angEnd
    for j =1:2:12
        Wavelength = 1.55;
        BendR = 100;
        aCorea = 8.15;
        aCoreb = 12;
        RotA =i;
        bendModeNum=j;
        modeNum=12;
        [bLoss] = simbendloss(Wavelength,BendR,aCorea,aCoreb,RotA,modeNum,bendModeNum);
        plotLoss(1+i/angStep,j) = bLoss(2);%
        plotLoss(1+i/angStep,j+1) = bLoss(1);
        disp('bloss=');
        disp(bLoss);
        xlswrite('plotdata.xlsx',plotLoss);
    end
end
toc