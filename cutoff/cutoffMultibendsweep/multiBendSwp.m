clc,clear;
tic
%Wavelength,aCorea,aCoreb,BendR,RotA,bendModeNum
%������a�ᣬb�ᣬ�����뾶����ת�Ƕȣ���Ҫ���������������ģʽ��
%������ʼ��
Wavelength = 1.55;%����
aCorea = 8.15;aCoreb = 12;%a���b�᳤��um
modeNum=12;%ֱ����ģʽ����
BendR = 140;
angStep = 5;angEnd = 90;angLength = length(0:angStep:angEnd);
plotLoss = zeros(angLength,12);
%ɨ��Ƕȣ��ȼ����ֱ������neff�� RotAΪ�Ƕȣ�bendModeNumΪģʽ��Ŀ
for RotA=0:angStep:angEnd
    para.Wavelength = [num2str(Wavelength),'[um]'];
    para.aCorea = [num2str(aCorea),'[um]'];
    para.aCoreb = [num2str(aCoreb),'[um]'];
    para.RotA = num2str(RotA);%COSMOL�������Ϊ�ַ�������Ҫ��λ�Ĵ���λ��
    [outdata] = ECFMFstraight(para);
    %[outdata] = testECFMFstraight(para);
    neff = outdata.neff;
    for bendModeNum =1:2:12%����ֱ������neff������������
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