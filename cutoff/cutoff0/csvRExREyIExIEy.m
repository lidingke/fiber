function [ output_args ] = csvRExREyIExIEy( xlsname )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%input�� csv�ȸ�ʽ���ļ����ļ�����������load��������ģ�������һ����ʽ�ġ�
%output��������ʽ�ĵ�ų���
%xlsname = 'corer.csv';
eh_data_all=load(xlsname);
%um����ĵ�λת��Ϊm
output_args.eh_data_xyo=eh_data_all(1:2,:).*1e-6;

eh_data_all(1:2,:)=[];
ex_num=size(eh_data_all);
eh_data.realEx=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.realEy=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.imagEx=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.imagEy=eh_data_all(1:ex_num(2),:);

output_args.complexEx=eh_data.realEx+eh_data.imagEx*i;
output_args.complexEy=eh_data.realEy+eh_data.imagEy*i;

end

