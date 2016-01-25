function intp=intpfun(intdata,datax,datay)
A1=intdata;
S=size(A1);%
%S=S(2)
%X_temp=X1(1,:);Y_temp=Y1(:,1);
X_temp=datax;
Y_temp=datay;
C=ones(size(datax));
for ii=1:(S(2)-1)/2
    j=2*ii;  C(1,j)=4;  C(1,j+1)=2;
end
C(1,S(2))=1;
for ii=1:(S(1)-1)/2
    j=2*ii; C(j,:)=4*C(1,:);  C(j+1,:)=2*C(1,:);
end
C(S(1),:)=C(1,:);

%C
% Calculate the integration
A0=(X_temp(S(2))-X_temp(1))*(Y_temp(S(1))-Y_temp(1))/9/(S(2)-1)/(S(1)-1);
intp=A0*sum(sum(C.*(abs(A1))));