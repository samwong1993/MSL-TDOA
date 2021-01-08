clear all
num = [5,6,7,8,9];
SNR = 10;
err = [];
clf
for idx = 1:length(num)
    filename = ".\model_1_M"+string(num(idx))+"_SNR10.txt";
    [err_1,err_2,err_3]=textread(filename,'%f%f%f','delimiter',',');
    err = [err (mean(err_1) + mean(err_2) + mean(err_3))];
end
err_shen = [];
for idx = 1:length(num)
    filename = ".\shen_model_1_M"+string(num(idx))+"_SNR10.txt";
    [err_1,err_2,err_3]=textread(filename,'%f%f%f','delimiter',',');
    err_shen = [err_shen (mean(err_1) + mean(err_2) + mean(err_3))];
end

plot(num,err_shen,'^-', 'linewidth', 1.1, 'markerfacecolor', [29, 191, 151]/255);
hold on
plot(num,err,'ok-','linewidth',1.1,'markerfacecolor',[36, 169, 225]/255);

% for i = 1:m
%     plot(sigma,10^3*error(i,:),'b--o') 
% end



sigma = 0.1;
%Attack example 1 
s = [40,40,-40,-40,40,0,-40,0,10;40,-40,40,-40,0,40,0,-40,5];
xTrue = [10,20,0;-10,0,-10];
[d,M] = size(s); K = size(xTrue,2);
Omega = ones(M-1,M-1)+eye(M-1);
crlb(5) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma)
s = [40,40,-40,-40,40,0,-40,0;40,-40,40,-40,0,40,0,-40];
xTrue = [10,20,0;-10,0,-10];
[d,M] = size(s); K = size(xTrue,2);
Omega = ones(M-1,M-1)+eye(M-1);
crlb(4) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma)
s = [40,40,-40,-40,40,0,-40;40,-40,40,-40,0,40,0];
xTrue = [10,20,0;-10,0,-10];
[d,M] = size(s); K = size(xTrue,2);
Omega = ones(M-1,M-1)+eye(M-1);
crlb(3) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma)
s = [40,40,-40,-40,40,0;40,-40,40,-40,0,40];
xTrue = [10,20,0;-10,0,-10];
[d,M] = size(s); K = size(xTrue,2);
Omega = ones(M-1,M-1)+eye(M-1);
crlb(2) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma)
s = [40,40,-40,-40,40;40,-40,40,-40,0];
xTrue = [10,20,0;-10,0,-10];
[d,M] = size(s); K = size(xTrue,2);
Omega = ones(M-1,M-1)+eye(M-1);
crlb(1) = TDOALocCRLB(s,xTrue(:,1),Omega,sigma)


plot(num,crlb,'*-r','linewidth',1.5);
legend("Shen's Alg with L-2 norm",'AMLC','CRLB');
xlabel('Number of Sensors')
ylabel('RMSE (m)')
ylim([0 5])
set(gca,'yscale','log')
set(gca,'xtick',[5:9])