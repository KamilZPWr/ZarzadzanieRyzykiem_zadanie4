data = importdata('data.txt');
sp = data.data;
dates = data.rowheaders;
Returns = tick2ret(sp);
Returns = Returns(1:2000);
dates = datetime(dates, 'InputFormat', 'yyyy-MM-dd');
DateReturns = dates(2:2001);
SampleSize = length(Returns);

TestWindowStart      = 1501;
TestWindow           = TestWindowStart : SampleSize;
EstimationWindowSize = 1500;

pVaR = [0.95 0.99];

Historical95 = zeros(length(TestWindow),1);
Historical99 = zeros(length(TestWindow),1);

for t = TestWindow
    i = t - TestWindowStart + 1;
    EstimationWindow = t-EstimationWindowSize:t-1;
    X = Returns(EstimationWindow);
    Historical95(i) = quantile(X,pVaR(1));
    Historical99(i) = quantile(X,pVaR(2));
end

count95 = 0
count99 = 0
for i=1501:2000
   if Returns(i) > Historical95(i-1500)
      count95 = count95 + 1 
   end
   if Returns(i) > Historical99(i-1500)
      count99 = count99 + 1 
   end
end

figure;
hold on
plot(DateReturns(1501:end),[Historical95 Historical99])
plot(DateReturns(1501:end), Returns(1501:2000))
ylabel('VaR')
xlabel('Date')
legend({'95% Confidence Level','99% Confidence Level'},'Location','Best')
title('VaR Estimation Using the Historical Simulation Method')