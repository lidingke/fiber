function [ output_args ] = Csv2eh( xlsname )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%input： csv等格式的文件的文件名，可以用load函数载入的，并满足一定格式的。
%output：复数形式的电磁场。
%xlsname='corer.csv'
eh_data_all=load(xlsname);
output_args.eh_data_xyo=eh_data_all(1:2,:).*1e-6;


eh_data_all(1:2,:)=[];
ex_num=size(eh_data_all);
eh_data.realne=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.realnh=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.imagne=eh_data_all(1:ex_num(2),:);
eh_data_all(1:ex_num(2),:)=[];
eh_data.imagnh=eh_data_all(1:ex_num(2),:);
%eh_data_all(1:ex_num(2),:)=[];


% %
output_args.ne=eh_data.realne+eh_data.imagne*i;
% 
% %
output_args.nh=eh_data.realnh+eh_data.imagnh*i;

end

