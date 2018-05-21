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
T95 = zeros(length(TestWindow),1);
T99 = zeros(length(TestWindow),1);


for t = TestWindow
    i = t - TestWindowStart + 1;
    EstimationWindow = t-EstimationWindowSize:t-1;
    X = Returns(EstimationWindow);
    sigma = std(X);
    parameters = mle(X,'distribution','tlocationscale');
    %Tutaj zgodnie z tym co Wojtek pisa³ i tutaj te¿ to jest: http://www.mathworks.com/help/stats/t-location-scale-distribution.html
    %to skoro wyestymowaliœmy parametry, to (X-mu)/sigma jest z rozk³adu
    %t-Studenta z n stopniami swobody. Czy to ma mi pos³u¿yæ do wyznaczenia
    %kwantyla? Wtedy ta sigma by³aby tym drugim parametrem wyestymowanym za
    %pomoc¹ mle?
    %Zscore = norminv(pVaR,parameters(1),parameters(2));
    Zscore = tinv(pVaR,parameters(3));
    %I co z t¹ œredni¹? Czy nie bierzemy jej pod uwagê? (Chodzi mi o wyk³ad
    %--> wzór na metodê parametryczn¹)
    T95(i) = Zscore(1)*sigma;
    T99(i) = Zscore(2)*sigma;
end

figure;
hold on
plot(DateReturns(TestWindow),[T95 T99])
plot(DateReturns(1501:end), Returns(1501:2000))
xlabel('Data')
ylabel('VaR')
legend({'95% poziom ufnoœci ','99% poziom ufnoœci'},'Location','Best')
title('Estymacja wartoœci zagro¿onej dla metody parametrycznej')
