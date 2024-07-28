% 三要素
A=0.5;              %幅度
f=440;              %频率
w=2*pi*f;           %角频率
T=1;                %观测时间
fs=16000;           %采样频率
d=1/fs;             %采样间隔 
t=0:d:T;            %离散时间t

s1=A*sin(w*t);              %正弦波
s2=A*sawtooth(w*t,0.5);     %三角波
s3=A*sawtooth(w*t,1);       %锯齿波
s4=A*square(w*t,50);        %方波
figure(1);
subplot(4,1,1);
plot(t,s1);
xlim([0 0.01]),title('正弦波'),xlabel('时间/s'),ylabel('幅度');
subplot(4,1,2);
plot(t,s2);
xlim([0 0.01]),title('三角波'),xlabel('时间/s'),ylabel('幅度');
subplot(4,1,3);
plot(t,s3);
xlim([0 0.01]),title('锯齿波'),xlabel('时间/s'),ylabel('幅度');
subplot(4,1,4);
plot(t,s4);
xlim([0 0.01]),title('方波'),xlabel('时间/s'),ylabel('幅度');



N=16000;        %采样点
n=0:N-1;
F=n*fs/N;

ff1=fft(s1,N);m1=abs(ff1);
ff2=fft(s2,N);m2=abs(ff2);
ff3=fft(s3,N);m3=abs(ff3);
ff4=fft(s4,N);m4=abs(ff4);

figure(2)
subplot(2,2,1);plot(F,m1);
title('正弦波'),xlabel('频率/Hz'),ylabel('幅度');
subplot(2,2,2);plot(F,m2);
title('三角波'),xlabel('频率/Hz'),ylabel('幅度');
subplot(2,2,3);plot(F,m3);
title('锯齿波'),xlabel('频率/Hz'),ylabel('幅度');
subplot(2,2,4);plot(F,m4);
title('方波'),xlabel('频率/Hz'),ylabel('幅度');