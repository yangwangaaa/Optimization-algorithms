clc;
clear all;
close all;

%% Importeren van de data
S3= xlsread('SoilTempData.xlsx');

%% ClonalSelectionAlg runnen
N=20;
n1=10; 
n2=5;
rho=20;
gamma1=0.06;
gamma2=15;
Nmax=10;
M=ClonalSelectionAlg(S3,N,n1,n2,rho,gamma1,gamma2,Nmax);

S = xlsread('TemperatuurData_day.xlsx');
S2 = xlsread('TemperatuurData_anomalieDetection_day.xlsx')
r = 0.08;
n = 1000;

A =  NegSelectionAlg(S,r,n);
figure(2)
fig = DataAnomalies(A, S2, r)
