clc,clear;
tic
%Wavelength,aCorea,aCoreb,BendR,RotA,bendModeNum
%波长，a轴，b轴，弯曲半径，旋转角度，需要计算的弯曲波导的模式数
%参数初始化
Wavelength = 1.55;%波长
aCorea = 8.15;aCoreb = 12;%a轴和b轴长度um
modeNum=12;%直波导模式总数
BendR = 140;
angStep = 5;angEnd = 90;angLength = length(0:angStep:angEnd);
plotLoss = zeros(angLength,12);
%扫描角度，先计算出直波导的neff， RotA为角度，bendModeNum为模式数目
for RotA=0:angStep:angEnd
    para.Wavelength = [num2str(Wavelength),'[um]'];
    para.aCorea = [num2str(aCorea),'[um]'];
    para.aCoreb = [num2str(aCoreb),'[um]'];
    para.RotA = num2str(RotA);%COSMOL输入参数为字符串，需要单位的带单位。
    [outdata] = ECFMFstraight(para);
    %[outdata] = testECFMFstraight(para);
    neff = outdata.neff;
    for bendModeNum =1:2:12%根据直波导的neff计算弯曲波导
        para.coreNeff = num2str(neff(modeNum-bendModeNum+1)');
        para.BendR = [num2str(BendR),'[mm]'];
        [outdata] = ECFMFbend(para);
        %[outdata] = testECFMFbend(para);
        bLoss(1)=outdata.BlossdBM(1);bLoss(2)=outdata.BlossdBM(2);
        plotLoss(1+RotA/angStep,bendModeNum) = bLoss(2);
        plotLoss(1+RotA/angStep,bendModeNum+1) = bLoss(1);
        disp('bloss=');disp(bLoss);
        xlswrite('plotdata.xlsx',plotLoss);
        [ plot ] = Csv2eh( 'plot.csv' );figure(1);mesh(abs(plot.ne));
    end
end
toc