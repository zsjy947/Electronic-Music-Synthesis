load('music.mat')        %所有样本，二维矩阵，时域样本
            %每列表示：单个样本的采样长度，单个样本采集时长为2.5 s，采样频率为Fs =20 kHz
                            %所以单个样本的采样长度为2.5*20k =50000
                            %第一列为第1个样本-状态1，第二列为第2个样本-状态2
 
                            
features = table;           %特征表
sample_number = NUM;          %sample_number为样本个数
sample_length = 1:1:210000;  %sample_length为单个样本的采样长度
 
Fs = 50000;                 %采样频率Fs=20 KHz
t = (1:1:210000)/Fs;         %采样时间t=2.5s
b = (1:210000);              %实际区间
 
 
 
P1_length = 105000;% 频域长度。为时域下的1/2；长度需要为偶数
frequency_samples= zeros(sample_number,P1_length);%把每个样本samples2都从时域通过傅里叶变换到频域
                                                  %frequency_samples为所有样本的频域数据幅值，同样为矩阵
                                                  %列数为P1_length，行大小即为样本个数
 
 
figure(1)
subplot(211)
plot(t(b),ZD6(1,b))
xlabel('时间/s')
ylabel('时域幅值/A')
title('第1个样本-状态1')          %第1个样本-状态1的波形
subplot(212)
plot(t(b),ZD6(2,b))
xlabel('时间/s')
ylabel('时域幅值/A')
title('第2个样本-状态2')          %第2个样本-状态2的波形
 
 
Fs = 50000;
x = ZD6(1,b);
L = length(x);
y = fft(x);
f = (0:L-1)*Fs/L;
y = y/L;
figure(2)
subplot(411)
plot(t(b),ZD6(1,b))
xlabel('时间/s')
ylabel('时域幅值/A')
title('第1个样本-状态1')
 
 
subplot(412)
plot(f,abs(y))
 
fshift = (-L/2:L/2-1)*Fs/L;
yshift = fftshift(y);
subplot(413)
plot(fshift,abs(yshift))
 
P2 = abs(fft(x)/L);
P1 = P2(1:L/2);
P1(2:end-1) = 2*P1(2:end-1);
fnew = (0:(L/2-1))*Fs/L;
subplot(414)
plot(fnew,P1)
 
 
figure(3)
plot(fnew,P1)
xlim([0 100])
ylabel('频域幅值','FontSize',25)
xlabel('频率/Hz','FontSize',25)
% title('第1个样本-状态1')
 
 
for i=1:NUM       %把时域每个样本都从时域通过傅里叶变换到频域
    Fs = 50000;
    x = ZD6(i,b);
    L = length(x);
    y = fft(x);
    f = (0:L-1)*Fs/L;
    y = y/L;
 
    fshift = (-L/2:L/2-1)*Fs/L;
    yshift = fftshift(y);
 
    P2 = abs(fft(x)/L);
    P1 = P2(1:L/2);
    P1(2:end-1) = 2*P1(2:end-1);
    fnew = (0:(L/2-1))*Fs/L;
    
    frequency_samples(i,:)= P1; %P1为向量，其长度为P1_length
                                %frequency_samples为所有样本的频域数据幅值，同样为矩阵
                                %行数为P1_length，列大小即为样本个数
end
 
 
for i=1:NUM
    v = frequency_samples(i,:);
    %频域相关特征
        features.Mean = mean(v);                         %平均值
        features.Std = std(v);                           %标准差
        features.Skewness = skewness(v);                 %偏度
        features.Kurtosis = kurtosis(v);                 %峭度
        features.max = max(v);                           %最大值
        features.min = min(v);                           %最小值
        features.Peak2Peak = peak2peak(v);               %峰峰值
        features.RMS = rms(v);                           %均方根
        features.CrestFactor = max(v)/rms(v);            %振幅因数
        features.ShapeFactor = rms(v)/mean(abs(v));      %波形因数
        features.ImpulseFactor = max(v)/mean(abs(v));    %冲击因数
        features.MarginFactor = max(v)/mean(abs(v))^2;   %裕度因数
        features.Energy = sum(v.^2);                     %能量
 
end

