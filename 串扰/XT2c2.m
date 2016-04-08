clear,clc;
%��������������ʽ�ĵ糡
xlsname='corer.csv'
[ corer ] = Csv2eh( xlsname )
xlsname='corel.csv'
[ corel ] = Csv2eh( xlsname )
%һ�ϲ�����Ϊ�˵����ų��ֲ�����ų���Ҫ��ʵ���鲿�ֿ����룬��Ȼ�Ὣiת�����ַ���
%��������ģʽ�ĵ糡�ֲ�ͼ
figure(1);
mesh(abs(corer.ne));
figure(3);
mesh(abs(corel.ne));

datax=corel.eh_data_xyo(1,:);
datay=corel.eh_data_xyo(2,:);
ncorer=1.4495;
ncorel=1.44447;
%intpfun(corer.ne*conj(corel.ne),datax,datay)
%�⼸��ע�͵��Ĵ��벻�ÿ�����Ϊ����֤���㲽�����޴����õ�
CpEfeild=(ncorer^2-ncorel^2)*intpfun(corer.ne.*conj(corel.ne),datax,datay)%���ϵ��������ļ���
%Poavzm=intpfun(corer.ne.*conj(corer.nh)+corer.nh.*conj(corer.ne),datax,datay)
AngFre=1.21526e15;%��Ƶ�ʣ�oumiga
ConstE0=8.85e-12;%��糣�� e0
Poavz=4*1.5273e-9%�����ܶ�,ÿ�μ�����Ҫ�Ķ�
%PdB=10*log10(Poavz)
disp('�������ϵ��');
Cprl=AngFre*ConstE0*CpEfeild/Poavz%�������ϵ����ʽ
%CprldB=10*log10(Cprl)
bendlen=100e-3;%�����뾶
AllLen=100e3;%�ܳ���
Beta=5.8649e6;%��������
CoreDistan=50e-6;%о��࣬ÿ�μ�����Ҫ�Ķ�
disp('���㴮��')
XTrl=2*Cprl^2*bendlen*AllLen/(Beta*CoreDistan)%���㴮��XT

T0=10*log10(XTrl)%���ŵ�λΪdB

