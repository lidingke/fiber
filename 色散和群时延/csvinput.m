clear all;
%input
ex_data=load('4O3.csv')

% format transform
esize=size(ex_data)
%input lambda num=5 input mode =12
lanum=5;
modenum=12;
esnum=esize(1)/modenum;
if esnum ~= fix(esnum)
    disp('csv矩阵长宽不对,是否请检查波长数目是否为5，模式数目是否配置正确');
    return;
end
for i=1:esnum
    exe_data(1,i)=ex_data(1+(i-1)*12,1);
    exe_data(2:13,i)=ex_data(1+(i-1)*12:12+(i-1)*12,3);
    %是否需要考虑重新排序，使得低阶模式排在前面
end
lambda=exe_data(1,:)
templen=size(exe_data)
len=templen(1,1)-1
for k=1:len
    %Betain.Fbeta=Fbeta(:,k)'
    Betain.Fneff=exe_data(k+1,:)
    Betain.lambda=lambda
    [ Betao ] = beta0123( Betain )
    ModeDc(k)=Betao.Dc%ps/km/nm
    ModeDtao(k)=-1*Betao.Dtao%ps/m
end


% LP01
LP01Dc=ModeDc(len)
LP01DMGD=ModeDtao(len)-ModeDtao(len)
%LP01DMGDp=ModeDtaop(len)-ModeDtaop(len)
%LP11
LP11Dc=ModeDc(len-2)
LP11DMGD=ModeDtao(len-2)-ModeDtao(len)
%LP11DMGDp=ModeDtaop(len-2)-ModeDtaop(len)
%LP11
LP21Dc=ModeDc(len-6)
LP21DMGD=ModeDtao(len-6)-ModeDtao(len)
%LP21DMGDp=ModeDtaop(len-6)-ModeDtaop(len)
%LP02
LP02Dc=ModeDc(len-10)
LP02DMGD=ModeDtao(len-10)-ModeDtao(len)
%LP02DMGDp=ModeDtaop(len-10)-ModeDtaop(len)
beta123all=[LP01Dc LP11Dc LP21Dc LP02Dc;LP01DMGD LP11DMGD LP21DMGD LP02DMGD]%;LP01DMGDp LP11DMGDp LP21DMGD LP02DMGDp]

