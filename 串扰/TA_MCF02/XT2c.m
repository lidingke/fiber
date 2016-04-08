clear,clc;

%输入q在p处的场
% xlsname='iptSF57.csv'
% xlsname='iptFr1.csv'
xlsname='corer.csv'
eh_data_all=load(xlsname);
eh_data_xyo=eh_data_all(1:2,:).*1e-6;


eh_data_all(1:2,:)=[];
ex_num=size(eh_data_all);


eh_data.realne=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
% sum(sum(eh_data.realne));
eh_data.realnh=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.imagne=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
% sum(sum(eh_data.imagne));
eh_data.imagnh=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];


%
corer.ne=eh_data.realne+eh_data.imagne*i;

%
corer.nh=eh_data.realnh+eh_data.imagnh*i;

xlsname='corel.csv'
eh_data_all=load(xlsname);
eh_data_xyo=eh_data_all(1:2,:).*1e-6;


eh_data_all(1:2,:)=[];
ex_num=size(eh_data_all)


eh_data.realne=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
% sum(sum(eh_data.realne));
eh_data.realnh=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.imagne=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
% sum(sum(eh_data.imagne));
eh_data.imagnh=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];


%
corel.ne=eh_data.realne+eh_data.imagne*i;

%
corel.nh=eh_data.realnh+eh_data.imagnh*i;
%一上部分是为了导入电磁场分布，电磁场需要将实部虚部分开导入，不然会将i转换成字符串
%绘制两个模式的电场分布图
figure(1);
mesh(abs(corer.ne));
figure(2);
mesh(abs(corel.ne));

datax=eh_data_xyo(1,:);
datay=eh_data_xyo(2,:);
ncorer=1.4495;
ncorel=1.44447;
%intpfun(corer.ne*conj(corel.ne),datax,datay)
%这几个注释掉的代码不用看，是为了验证计算步骤有无错误用的
CpEfeild=(ncorer^2-ncorel^2)*intpfun(corer.ne.*conj(corel.ne),datax,datay)%耦合系数积分项的计算
%Poavzm=intpfun(corer.ne.*conj(corer.nh)+corer.nh.*conj(corer.ne),datax,datay)
AngFre=1.21526e15;%角频率，oumiga
ConstE0=8.85e-12;%介电常数 e0
Poavz=4*1.5273e-9%能流密度,每次计算需要改动
%PdB=10*log10(Poavz)
disp('计算耦合系数');
Cprl=AngFre*ConstE0*CpEfeild/Poavz%计算耦合系数公式
%CprldB=10*log10(Cprl)
bendlen=100e-3;%弯曲半径
AllLen=100e3;%总长度
Beta=5.8649e6;%传播常数
CoreDistan=50e-6;%芯间距，每次计算需要改动
disp('计算串扰')
XTrl=2*Cprl^2*bendlen*AllLen/(Beta*CoreDistan)%计算串扰XT

T0=10*log10(XTrl)%串扰单位为dB

