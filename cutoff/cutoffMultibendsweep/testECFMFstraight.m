function [ outdata] = testECFMFstraight( para )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%     para.Wavelength = [num2str(Wavelength),'[um]'];
%     para.aCorea = [num2str(aCorea),'[um]'];
%     para.aCoreb = [num2str(aCoreb),'[um]'];
%     para.RotA = num2str(RotA);
%     
disp(para.Wavelength);
disp(para.aCorea);
disp(para.aCoreb);
disp(para.RotA);
outdata.neff=1:1:12;


end
