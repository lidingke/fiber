clear,clc;
%%
%��������������ʽ�ĵ糡
xlsname='iptSF57.csv'
[ corer ] = Csv2eh( xlsname )
xlsname='iptUHNA3.csv'
[ corel ] = Csv2eh( xlsname )
%һ�ϲ�����Ϊ�˵����ų��ֲ�����ų���Ҫ��ʵ���鲿�ֿ����룬��Ȼ�Ὣiת�����ַ���
%��������ģʽ�ĵ糡�ֲ�ͼ
figure(1);
mesh(abs(corer.ne));
figure(3);
mesh(abs(corel.ne));
%%
%����������
datax=corel.eh_data_xyo(1,:);
datay=corel.eh_data_xyo(2,:);
CP=corel.ne.*corer.ne;
CPA1=corel.ne.*conj(corer.ne);
CPA21=corel.ne.^2;
CPA22=corer.ne.^2;

pall=intpfun(CPA1,datax,datay)^2/(intpfun(CPA21,datax,datay)*intpfun(CPA22,datax,datay))

T0=-10*log10(pall)
