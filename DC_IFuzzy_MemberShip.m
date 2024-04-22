function [s1,s2] = DC_IFuzzy_MemberShip(Data, Label, Kernel)


%% Main

pos_index=find(Label==1);
neg_index=find(Label==-1);

Data_Pos = Data(pos_index, :);
N_Pos = sum(Label==1);
e_Pos = ones(N_Pos, 1);

Data_Neg = Data(neg_index, :);
N_Neg = sum(Label==-1);
e_Neg = ones(N_Neg, 1);
% Processing
P_Ker_P = Function_Kernel(Data_Pos, Data_Pos, Kernel);
P_Ker_N = Function_Kernel(Data_Pos, Data_Neg, Kernel);
N_Ker_N = Function_Kernel(Data_Neg, Data_Neg, Kernel);

P_P = diag(P_Ker_P)-2*P_Ker_P*e_Pos/N_Pos+(e_Pos'*P_Ker_P*e_Pos)*e_Pos/(N_Pos^2);
r_s = max(P_P);

P_N = diag(P_Ker_P)-2*P_Ker_N*e_Neg/N_Neg+(e_Neg'*N_Ker_N*e_Neg)*e_Pos/(N_Neg^2);

N_N = diag(N_Ker_N)-2*N_Ker_N*e_Neg/N_Neg+(e_Neg'*N_Ker_N*e_Neg)*e_Neg/(N_Neg^2);
s_s = max(N_N);

N_P = diag(N_Ker_N)-2*P_Ker_N'*e_Pos/N_Pos+(e_Pos'*P_Ker_P*e_Pos)*e_Neg/(N_Pos^2);


Mem1=e_Pos-P_P/(r_s+10e-7);
Nmem1=P_P./(P_N+P_P);%

Mem2=e_Neg-N_N/(s_s+10e-7);
Nmem2=N_N./(N_P+N_N);%

s1=sqrt((Mem1.^2+(e_Pos-Nmem1).^2)./2);
s2=sqrt((Mem2.^2+(e_Neg-Nmem2).^2)./2);

ratio1=N_Pos/(N_Pos+N_Neg);
ratio2=N_Neg/(N_Pos+N_Neg);

s1=s1*ratio2;
s2=s2*ratio1;


end

