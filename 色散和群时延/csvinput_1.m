clear all;
%input
ex_data=load('4O3.csv')

% format transform
esize=size(ex_data)
%input lambda num=5 input mode num =12
lanum=5;
modenum=12;
esnum=esize(1)/modenum;
if esnum ~= fix(esnum)
    disp('csv���󳤿���,�Ƿ����鲨����Ŀ�Ƿ�Ϊ5��ģʽ��Ŀ�Ƿ�������ȷ');
    return;
end
    exe_data(1,:)=ex_data(1:modenum:esize(1),1);
    %����һ����ÿ��modenumȡ1����Ϊ�����ĺ���
for i=1:esnum
    exe_temp=ex_data(modenum+(i-1)*modenum:-1:1+(i-1)*modenum,3);
    %����3������ģʽ��modenumΪһ�鸽����Ӧ�Ĳ�����
    %����ʹ�õ�һ��ģʽ�������棬COMSOL�е�����Ĭ�ϵ�һ��ģʽ�������棬��������ֵ���㡣
    exe_data(2:(modenum+1),i)= exe_temp;
end
%exe_data,��������ģʽ���������ǲ���
lambda=exe_data(1,:)
%templen=size(exe_data)
%len=templen(1,1)-1
for k=1:modenum
    %Betain.Fbeta=Fbeta(:,k)'
    Betain.Fneff=exe_data(k+1,:)
    Betain.lambda=lambda
    [ Betao ] = beta0123( Betain )
    ModeDc(k)=Betao.Dc%ps/km/nm
    ModeDtao(k)=-1*Betao.Dtao%ps/m
    ModeT(k)=ModeDtao(k)-ModeDtao(1)
end


% % LP01
% LP01Dc=ModeDc(len)
% LP01DMGD=ModeDtao(len)-ModeDtao(len)
% %LP01DMGDp=ModeDtaop(len)-ModeDtaop(len)
% %LP11
% LP11Dc=ModeDc(len-2)
% LP11DMGD=ModeDtao(len-2)-ModeDtao(len)
% %LP11DMGDp=ModeDtaop(len-2)-ModeDtaop(len)
% %LP11
% LP21Dc=ModeDc(len-6)
% LP21DMGD=ModeDtao(len-6)-ModeDtao(len)
% %LP21DMGDp=ModeDtaop(len-6)-ModeDtaop(len)
% %LP02
% LP02Dc=ModeDc(len-10)
% LP02DMGD=ModeDtao(len-10)-ModeDtao(len)
% %LP02DMGDp=ModeDtaop(len-10)-ModeDtaop(len)
% beta123all=[LP01Dc LP11Dc LP21Dc LP02Dc;LP01DMGD LP11DMGD LP21DMGD LP02DMGD]%;LP01DMGDp LP11DMGDp LP21DMGD LP02DMGDp]
% 
