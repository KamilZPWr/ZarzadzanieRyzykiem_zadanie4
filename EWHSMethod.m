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

w = [1./(1+sum(cumprod(ones(1,EstimationWindowSize-1)*Lambda)))];
for i=2:1500
    w = [w Lambda*w(end)];
end
w = w';
P = fliplr(Returns);
EWHS95 = zeros(length(TestWindow),1);
EWHS99 = zeros(length(TestWindow),1);
for t = TestWindow
    i = t - TestWindowStart + 1;
	M = [P(t-EstimationWindowSize:t-1), w];
    M = sortrows(M);
    M = [M(:,1), cumsum(M(:,2))];
    EWHS95(i) = M(findIndexWhereValueCloseToX(M(:,2),pVaR(1)), 1) ;
    EWHS99(i) = M(findIndexWhereValueCloseToX(M(:,2),pVaR(2)), 1);
end

count95 = 0;
count99 = 0;
for i=1501:2000
   if Returns(i) > EWHS95(i-1500)
      count95 = count95 + 1;
   end
   if Returns(i) > EWHS99(i-1500)
      count99 = count99 + 1;
   end
end

figure;
hold on
plot(DateReturns(1501:end),[EWHS95 EWHS99])
plot(DateReturns(1501:end), Returns(1501:2000))
ylabel('VaR')
xlabel('Data')
legend({'95% poziom unfoœci','99% poziom unfoœci', 'Stopa zwrotu'},'Location','Best')
title('VaR przy u¿yciu wa¿onej metody historycznej')