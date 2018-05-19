data = importdata('data.txt');
sp = data.data;
dates = data.rowheaders;
Returns = tick2ret(sp);
dates = datetime(dates, 'InputFormat', 'yyyy-MM-dd');
DateReturns = dates(2:end);
SampleSize = length(Returns);

TestWindowStart      = 1501;
TestWindow           = TestWindowStart : SampleSize;
EstimationWindowSize = 1500;

pVaR = [0.05 0.01];

Historical95 = zeros(length(TestWindow),1);
Historical99 = zeros(length(TestWindow),1);

for t = TestWindow
    i = t - TestWindowStart + 1;
    EstimationWindow = t-EstimationWindowSize:t-1;
    X = Returns(EstimationWindow);
    Historical95(i) = -quantile(X,pVaR(1));
    Historical99(i) = -quantile(X,pVaR(2));
end

figure;
plot(DateReturns(1501:end),[Historical95 Historical99])
ylabel('VaR')
xlabel('Date')
legend({'95% Confidence Level','99% Confidence Level'},'Location','Best')
title('VaR Estimation Using the Historical Simulation Method')