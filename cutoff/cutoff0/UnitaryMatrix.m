function [ output_args ] = UnitaryMatrix( sigma )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
hang=6;
%sigma=input_args.sigma;%step10,tao
lamda=1550*1e-9;
k0=2*pi/lamda;
r=ceil(10*log10(sigma));
beta=[4.90925679,4.90925679,4.91195035,4.91195035,4.91195036,4.91195036]*1e6;
meanbeta=mean(beta);
Normfactor=max(beta)-min(beta);
beta1=beta-meanbeta.*ones(1,6);
Bvector=(1/Normfactor).*beta1;
B=diag(Bvector);


T=eye(6);
L=1000000;%1000km

Lsec=1000;
N=ceil(L/Lsec);
Lbeta=2/Normfactor;
p=1/(2*Lsec/Lbeta);

sigma_coupling=sigma;

%for stu=1:1:N 

    H_Mreal=normrnd(0,1,hang,hang);
    H_Mimag=1i*normrnd(0,1,hang,hang);
    H_M=H_Mreal+H_Mimag;
    H_M=(H_M+H_M')/2;%%%%generate Hermitian random matrix
    H_M=sigma_coupling*H_M;
    output_args.UnitaryMatrix=expm(i/p*(B+H_M))*T
%end


end

