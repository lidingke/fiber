function [ output_args ] = csvRExREyIExIEy( xlsname )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%input： csv等格式的文件的文件名，可以用load函数载入的，并满足一定格式的。
%output：复数形式的电磁场。
%xlsname = 'corer.csv';
eh_data_all=load(xlsname);
%um坐标的单位转换为m
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

