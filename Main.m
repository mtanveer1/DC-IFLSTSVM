close all;clear all;clc;

Training_data=load("traindata.txt");
testing_data=load("testdata.txt");


FunPara.c_1=0.0001;
FunPara.c_2=0.00001;
FunPara.kerfpara.pars=4;
FunPara.kerfpara.type='rbf';
[ auc]=DC_IFLSTSVM_func(testing_data,Training_data,FunPara);


display(auc)