load('data.txt');
prices = data(end-2002+1:end,2);
rates = (prices(2:end)-prices(1:end-1))./prices(1:end-1)*100;
model = garch('GARCHLags',1,'ARCHLags',1,'Offset',NaN);
windowsize = 1500;
vars95 = zeros(1,500);
vars99 = zeros(1,500);

for i=0:499
sigma_t = zeros(1,windowsize);
window_rates = rates(1+i:windowsize+1+i);
est_model = estimate(model,window_rates(2:end));
c0 = est_model.Constant;
c1 = cell2mat(est_model.ARCH);
b1 = cell2mat(est_model.GARCH);
mu = est_model.Offset;
sigma0 = est_model.UnconditionalVariance;
for t = 1:windowsize+1
    sigma_t(t) = sigma0;
    sigma0 = c0+c1*window_rates(t).^2+b1*sigma0;
end
%sigma_t1 = c0+c1*window_rates(end).^2+b1*sigma_t(end);

MC=sqrt(sigma_0)*normrnd(0,1,1,1000)+mu;
VaR95 = quantile(MC,0.95);
vars95(i+1)=VaR95;
VaR99 = quantile(MC,0.99);
vars99(i+1)=VaR99;
end
plot(vars95);hold on;plot(vars99);plot(rates(1502:end));