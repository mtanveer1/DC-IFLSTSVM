function [auc, acc, time] = DC_IFLSTSVM_func(Test_data,Train_data,FunPara)
kerfPara = FunPara.kerfpara;
c1=FunPara.c_1;
c3=c1;
c2=FunPara.c_2;
c4=c2;
[sam,no_col]=size(Train_data);
obs = Train_data(:,no_col);
data=Train_data(:,1:end-1);
A = Train_data(obs==1,1:end-1);
B = Train_data(obs~=1,1:end-1);
[m1,~]=size(A);
[m2,~]=size(B);
e1=ones(m1,1);
e2=ones(m2,1);
mew=kerfPara.pars;
%% initialize solution for conjugate gradient descent method
x0=0.01*ones(sam+1,1);
max_iter=100;
tol=10^-4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Kernel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
if strcmp(kerfPara.type,'lin')
    H=[A,e1];
    G=[B,e2];
else
    C=[A;B];
    K1 = exp(-(1/(mew^2))*(repmat(sqrt(sum(A.^2,2).^2),1,size(C,1))-2*(A*C')+repmat(sqrt(sum(C.^2,2)'.^2),size(A,1),1)));
    H=[K1,e1];
    K2 = exp(-(1/(mew^2))*(repmat(sqrt(sum(B.^2,2).^2),1,size(C,1))-2*(B*C')+repmat(sqrt(sum(C.^2,2)'.^2),size(B,1),1)));
    G=[K2,e2];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute (w1,b1) and (w2,b2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[s1,s2]=DC_IFuzzy_MemberShip(data,obs,kerfPara);
%% DTWSVM1
N=s2'*G;
HH=H'*H;
A1=-(HH+c1*eye(size(HH))+c2*(N'*N));
b1=c2*N*(s2'*e2);
u1=conjugate_gradient(x0,A1,b1',max_iter,tol);    

%% DTWSVM2
M=s1'*H;
GG=G'*G;
A2=(GG+c3*eye(size(GG))+c4*(M'*M));
b2=c4*M*(s1'*e1);
u2=conjugate_gradient(x0,A2,b2',max_iter,tol);
time=toc;
w1=u1(1:(length(u1)-1));
b1=u1(length(u1));
w2=u2(1:(length(u2)-1));
b2=u2(length(u2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predict and output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_label=Test_data(:,end);
test_X=Test_data(:,1:end-1);
tst_num=size(Test_data,1);
if strcmp(kerfPara.type,'lin')
    T_mat=Test_data(:,end-1);
    y1=T_mat*w1+b1*ones(tst_num,1);
    y2=T_mat*w2+b2*ones(tst_num,1);
else
    K3= exp(-(1/(mew^2))*(repmat(sqrt(sum(data.^2,2).^2),1,size(data,1))-2*(data*data')+repmat(sqrt(sum(data.^2,2)'.^2),size(data,1),1)));
    C=[A;B];
    T_mat = exp(-(1/(mew^2))*(repmat(sqrt(sum(test_X.^2,2).^2),1,size(C,1))-2*(test_X*C')+repmat(sqrt(sum(C.^2,2)'.^2),size(test_X,1),1)));
    y1=(T_mat*w1+b1*ones(tst_num,1))/sqrt(w1'*K3*w1);
    y2=(T_mat*w2+b2*ones(tst_num,1))/sqrt(w2'*K3*w2);
end
predict_Y=sign(abs(y2)-abs(y1));
err=sum(predict_Y~=test_label);
acc=(1-err/tst_num)*100;

%% accuracy
no_test=tst_num;
classifier=predict_Y;  %% classifier corresponds to prediucted values and obs1 corresponds to actual vaue
obs1=test_label;
match = 0.;
match1=0;

posval=0;
negval=0;

for i = 1:no_test
    if(obs1(i)==1)
        if(classifier(i) == obs1(i))
            match = match+1;
        end
        posval=posval+1;
    elseif(obs1(i)==-1)
        if(classifier(i) ~= obs1(i))
            match1 = match1+1;
        end
        negval=negval+1;
    end
end
if(posval~=0)
    a_pos=(match/posval);
else
    a_pos=0;
end

if(negval~=0)
    am_neg=(match1/negval);
else
    am_neg=0;
end
AUC=(1+a_pos-am_neg)/2;
auc=AUC*100;
end