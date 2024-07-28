for i = 1 : 12
    if (i ==1)
        tunes = zeros([12 3]);
        tunes(10, 1) = 220;                                          
        tunes(10, 2) = 440;
        tunes(10, 3) = 880;
        frequency_diff = 2^(1/12).^[-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2]';        
    end
    tunes(i, 1:end) = tunes(10, 1:end) .* frequency_diff(i);
end

load('music.mat');
fs=16000;
t = 0:1/fs:2 - 1/fs;
wlen = 2048;         % 窗口大小
hop = 1024;           % hop size 即移动步长
fre=zeros([19 10]);
answer={};


    [S1, f1, t1,p] = spectrogram(y,wlen,wlen - hop,1:1000,fs);
    
    figure;
    subplot(2, 1, 1);
    plot([0:length(y)-1]/fs,y);
    xlim([0,4.75]);
    title('音频波形'),xlabel('时间/s'),ylabel('幅度');
    subplot(2, 1, 2);
    imagesc(t1, f1, 20*log10(abs(S1)));
    title('时域谱图'),xlabel('时间/s'),ylabel('频率/Hz');
    colorbar;


for i=1:19
    song=y(1+4000*(i-1):4000*i);    
    N=16000;
    Y=fft(song,fs);
    n2=1:N/2+1;
    f=(n2-1)*fs/N;
    result=abs(Y(n2))*2/N;
    Tr=islocalmax(result);
    [pks,locs]=findpeaks(result,'MinpeakProminence',0.015,'Annotate','extents');
    figure;
    subplot 211; plot([0:length(song)-1]/fs,song);title('原始音频');xlabel('时间/s');ylabel('幅度');
    subplot 212; plot(f,result,locs,pks,'ro');xlim([0,1000]);xlabel('频率/Hz');ylabel('幅度');title('频谱图')
    grid;
    
    for j=1:length(locs)
        if locs(j)>1000
            break;
        end
        cor=abs(tunes-locs(j));
        cor_min=min(cor,[],"all");
        [row,col]=find(cor==cor_min);
        fre(i,j)=tunes(row,col);
        str=['第',int2str(i) ,'段'];
        answer(i,1)=cellstr(join(str));
        answer(i,j+1)=cellstr(join(tostring(row,col)));
    end
    
end

function y=tostring(row,col)
    if row==1
        y=['C',num2str(col+2)];
    elseif row==2
        y=['C',num2str(col+2),'#'];
    elseif row==3
        y=['D',num2str(col+2)];
    elseif row==4
        y=['D',num2str(col+2),'#'];
    elseif row==5
        y=['E',num2str(col+2)];
    elseif row==6
        y=['F',num2str(col+2)];
    elseif row==7
        y=['F',num2str(col+2),'#'];
    elseif row==8
        y=['G',num2str(col+2)];
    elseif row==9
        y=['G',num2str(col+2),'#'];
    elseif row==10
        y=['A',num2str(col+2)];
    elseif row==11
        y=['A',num2str(col+2),'#'];
    elseif row==12
        y=['B',num2str(col+2)];
    end
end
