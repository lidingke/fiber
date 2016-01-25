function [bLoss] = simbendloss(Wavelength,BendR,aCorea,aCoreb,RotA,modeNum,bendModeNum)
%init
%simbendloss(1.55,140,8.15,10,0,8,2)
%Wavelength,BendR,aCorea,aCoreb,RotA,modeNum,bendModeNum
%�����������뾶��a�ᣬb�ᣬ��ת�Ƕȣ�ֱ��������ģʽ������Ҫ���������������ģʽ��
%������ʼ��
modeNum=12;
para.Wavelength = [num2str(Wavelength),'[um]'];
para.aCorea = [num2str(aCorea),'[um]'];
para.aCoreb = [num2str(aCoreb),'[um]'];
para.RotA = num2str(RotA);
para.modeNum = num2str(modeNum);
%ֱ����
[outdata] = ECFMFstraight(para);
%disp(outdata.neff);
%get No.mode neff into bend fiber
if modeNum<bendModeNum
    disp('��ģʽ��Ӧ�ô���ѡȡ������ģ�����ģʽ��');
    return;
end
para.coreNeff = num2str(outdata.neff(modeNum-bendModeNum+1));
para.BendR = [num2str(BendR),'[mm]'];
[outdata] = ECFMFbend(para);
% disp('bendloss='); 
% disp(outdata.BlossdBM');
bLoss(1)=outdata.BlossdBM(1);
bLoss(2)=outdata.BlossdBM(2);
%plot Ex
xlsname = 'plot.csv';
[ plot ] = Csv2eh( xlsname );
figure(1);
mesh(abs(plot.ne));




