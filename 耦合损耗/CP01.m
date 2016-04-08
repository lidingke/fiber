clear,clc;
%%
%导入两个复数形式的电场
xlsname='iptSF57.csv'
[ corer ] = Csv2eh( xlsname )
xlsname='iptUHNA3.csv'
[ corel ] = Csv2eh( xlsname )
%一上部分是为了导入电磁场分布，电磁场需要将实部虚部分开导入，不然会将i转换成字符串
%绘制两个模式的电场分布图
figure(1);
mesh(abs(corer.ne));
figure(3);
mesh(abs(corel.ne));
%%
%计算耦合损耗
datax=corel.eh_data_xyo(1,:);
datay=corel.eh_data_xyo(2,:);
CP=corel.ne.*corer.ne;
CPA1=corel.ne.*conj(corer.ne);
CPA21=corel.ne.^2;
CPA22=corer.ne.^2;

pall=intpfun(CPA1,datax,datay)^2/(intpfun(CPA21,datax,datay)*intpfun(CPA22,datax,datay))

T0=-10*log10(pall)
