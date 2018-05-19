data = importdata('data.txt');
sp = data.data;
dates = data.rowheaders;
Returns = tick2ret(sp);
Returns = Returns(end-2000+1:end);
dates = datetime(dates, 'InputFormat', 'yyyy-MM-dd');
DateReturns = dates(end-2000+1:end);
SampleSize = length(Returns);

TestWindowStart      = 1501;
TestWindow           = TestWindowStart : SampleSize;
EstimationWindowSize = 1500;

pVaR = [0.95 0.99];

Lambda = 0.94;
Sigma2     = zeros(length(Returns),1);
Sigma2(1)  = Returns(1)^2;

for i = 2 : (TestWindowStart-1)
    Sigma2(i) = (1-Lambda) * Returns(i-1)^2 + Lambda * Sigma2(i-1);
end

Zscore = norminv(pVaR);
EWMA95 = zeros(length(TestWindow),1);
EWMA99 = zeros(length(TestWindow),1);

for t = TestWindow
    k     = t - TestWindowStart + 1;
    Sigma2(t) = (1-Lambda) * Returns(t-1)^2 + Lambda * Sigma2(t-1);
    Sigma = sqrt(Sigma2(t));
    EWMA95(k) = Zscore(1)*Sigma;
    EWMA99(k) = Zscore(2)*Sigma;
end

count95 = 0;
count99 = 0;
for i=1501:2000
   if Returns(i) > EWMA95(i-1500)
      count95 = count95 + 1;
   end
   if Returns(i) > EWMA99(i-1500)
      count99 = count99 + 1;
   end
end

figure;
hold on
plot(DateReturns(TestWindow),[EWMA95 EWMA99])
plot(DateReturns(1501:end), Returns(1501:2000))
ylabel('VaR')
xlabel('Data')
legend({'95% poziom unfoœci','99% poziom unfoœci'},'Location','Best')
title('VaR przy u¿yciu wa¿onej metody historycznej')

