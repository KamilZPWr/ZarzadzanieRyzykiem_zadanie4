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

Zscore   = tinv(pVaR,1:2);
T95 = zeros(length(TestWindow),1);
T99 = zeros(length(TestWindow),1);


for t = TestWindow
    i = t - TestWindowStart + 1;
    EstimationWindow = t-EstimationWindowSize:t-1;
    Sigma = std(Returns(EstimationWindow));
    T95(i) = Zscore(1)*Sigma;
    T99(i) = Zscore(2)*Sigma;
end

figure;
hold on
plot(DateReturns(TestWindow),[T95 T99])
plot(DateReturns(1501:end), Returns(1501:2000))
xlabel('Data')
ylabel('VaR')
legend({'95% poziom ufnoœci ','99% poziom ufnoœci'},'Location','Best')
title('Estymacja wartoœci zagro¿onej dla metody parametrycznej')
