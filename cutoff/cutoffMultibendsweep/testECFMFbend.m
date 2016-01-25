function [ outdata ] = testECFMFbend( para )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% 
%         para.coreNeff = num2str(outdata.neff(modeNum-bendModeNum+1));
%         para.BendR = [num2str(BendR),'[mm]'];
%         
disp(para.Wavelength);
disp(para.aCorea);
disp(para.aCoreb);
disp(para.RotA);
disp(para.coreNeff);
disp(para.BendR);
outdata.BlossdBM=[para.coreNeff,para.coreNeff+1]

end

