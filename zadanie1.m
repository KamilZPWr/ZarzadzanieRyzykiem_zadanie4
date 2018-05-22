%Metoda parametryczna

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

%Sprawdzenie s³usznoœci wyboru rozk³adu t-Studenta
%Dystrybuanta r. normalnego
[F,x] = ecdf(Returns); 
plot(x,F);
hold on
plot(x,normcdf(x,0,0.0133))
title('Porównanie dystrybuant')
%Dystrybuanta r. t-Studenta
figure
x = -10:0.001:10;
y = tcdf(x,4.0343);
z = normcdf(x,0,1);
plot(x,y,'-',x,z,'-.')
%Kstest
test_cdf = makedist('tlocationscale','mu',0,'sigma',0.0133,'nu',4.0343);
[h,p] = kstest(Returns,'CDF',test_cdf,'Alpha',0.01)

for t = TestWindow
    i = t - TestWindowStart + 1;
    EstimationWindow = t-EstimationWindowSize:t-1;
    X = Returns(EstimationWindow);
    parameters = mle(X,'distribution','tlocationscale');
    Zscore = parameters(2)*tinv(pVaR,parameters(3))+parameters(1);
    T95(i) = Zscore(1);
    T99(i) = Zscore(2);
end

figure;
hold on
plot(DateReturns(TestWindow),[T95 T99])
plot(DateReturns(1501:end), Returns(1501:2000))
xlabel('Data')
ylabel('VaR')
legend({'95% poziom ufnoœci ','99% poziom ufnoœci'},'Location','Best')
title('Estymacja wartoœci zagro¿onej dla metody parametrycznej')

 count95 = 0;
 count99 = 0;
 for i=1501:2000
   if Returns(i) > T95(i-1500)
       count95 = count95 + 1;
    end
    if Returns(i) > T99(i-1500)
       count99 = count99 + 1;
    end
 end
 (count95/500)*100
 (count99/500)*100
 
 %Zapisanie danych do póŸniejszego testowania
dlmwrite('dane.txt',Returns(1501:2000))
dlmwrite('VaR95.txt',T95)
dlmwrite('VaR99.txt',T99)