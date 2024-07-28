c4=261.63;
e4=329.63;
g4=392.00;
b4=493.88;
fs=16000;           %采样频率
song=[];
song=[song,Sin(c4,fs)+Sin(e4,fs)+Sin(g4,fs)];
song=[song,Sin(c4,fs)+Sin(e4,fs)+Sin(g4,fs)+Sin(b4,fs)];
sound(song,fs);

t = 0:1/fs:2 - 1/fs;
wlen = 2048;         % 窗口大小
hop = 1024;           % hop size 即移动步长
[S1, f1, t1,p] = spectrogram(song,wlen,wlen - hop,1:1000,fs);

figure;
subplot(2, 1, 1);
plot([0:length(song)-1]/fs,song);
xlim([0,2]);
title('音频波形'),xlabel('时间/s'),ylabel('幅度');
subplot(2, 1, 2);
imagesc(t1, f1, 20*log10(abs(S1)));
%imagesc(t1, f1, p);
title('时域谱图'),xlabel('时间/s'),ylabel('频率/Hz');
colorbar;

function s=Sin(f,fs)
    A=0.5;              %幅度
    w=2*pi*f;           %角频率
    T=1;                %观测时间
    d=1/fs;             %采样间隔 
    t=0:d:T;            %离散时间t
    s=A*sin(w*t);       %正弦波
end