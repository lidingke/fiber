clc,clear;
tic
%Wavelength,aCorea,aCoreb,BendR,RotA,bendModeNum
%������a�ᣬb�ᣬ�����뾶����ת�Ƕȣ���Ҫ���������������ģʽ��
%������ʼ��
Wavelength = 1.55;%����
aCorea = 8.15;aCoreb = 10;%a���b�᳤��um
modeNum=12;%ֱ����ģʽ����
%BendR = 140;
RotA = 0;
angBeg=10;angStep=10;angEnd=150;angLength = length(angBeg:angStep:angEnd);
plotLoss = zeros(angLength,12);
plotNeff = zeros(angLength,12);
%ɨ��Ƕȣ��ȼ����ֱ������neff�� RotAΪ�Ƕȣ�bendModeNumΪģʽ��Ŀ
para.Wavelength = [num2str(Wavelength),'[um]'];
para.aCorea = [num2str(aCorea),'[um]'];
para.aCoreb = [num2str(aCoreb),'[um]'];
para.RotA = num2str(RotA);%COSMOL�������Ϊ�ַ�������Ҫ��λ�Ĵ���λ��
[outdata] = ECFMFstraight(para);
%[outdata] = testECFMFstraight(para);
neff = outdata.neff;
processStepNum = 1;
for BendR=angBeg:angStep:angEnd
    for bendModeNum =1:2:12%����ֱ������neff������������
        para.coreNeff = num2str(neff(modeNum-bendModeNum+1)');
        para.BendR = [num2str(BendR),'[mm]'];
        [outdata] = ECFMFbend(para);
        %[outdata] = testECFMFbend(para);
        bLoss(1)=outdata.BlossdBM(1);bLoss(2)=outdata.BlossdBM(2);
        bNeff(1)=outdata.neffBend(1);bNeff(2)=outdata.neffBend(2);
        plotLoss(1+BendR/angStep,bendModeNum) = bLoss(2);
        plotLoss(1+BendR/angStep,bendModeNum+1) = bLoss(1);
        plotNeff(1+BendR/angStep,bendModeNum) = bNeff(2);
        plotNeff(1+BendR/angStep,bendModeNum+1) = bNeff(1);
        disp('bloss=');disp(bLoss);
        processStep=100*processStepNum/(length(10:angStep:angEnd)*length(1:2:12));
        processStepNum=processStepNum+1;
        stepNumstr=['���ȣ�',num2str(processStep),'%'];disp(stepNumstr);
        xlswrite('plotdatabendswap0.xlsx',plotLoss);
        xlswrite('plotneffbendswap0.xlsx',plotNeff);
        [ plot ] = Csv2eh( 'plot.csv' );figure(1);mesh(abs(plot.ne));
    end
end
toc