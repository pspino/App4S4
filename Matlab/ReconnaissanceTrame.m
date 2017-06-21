close all;
clear all;
clc;
%% correlation
[t1, f1] = audioread('TramesAReconnaitre\trame1.wav');
[t2, f2] = audioread('TramesAReconnaitre\trame2.wav');
[t3, f3] = audioread('TramesAReconnaitre\trame3.wav');

[s1, fe] = audioread('SonsACompresser\son1.wav');
[s2, fe] = audioread('SonsACompresser\son2.wav');
[s3, fe] = audioread('SonsACompresser\son3.wav');

%% correlation normalise de tous les son sur les trame

L1 = length(t1);
L2 = length(s1);
k1 = - (L1-1) : (L1-1);


q1 = zeros([length(t1),1]);
q2 = zeros([length(t2),1]);
q3 = zeros([length(t3),1]);

for i = 1:length(s1)
    k=i+140e3;
    q1(k) = s1(i);
    q2(k) = s2(i);
    q3(k) = s3(i);
end

C11    = xcorr(t1,q1,'unbiased');
C12    = xcorr(t1,q2,'unbiased');
C13    = xcorr(t1,q3,'unbiased');

C21    = xcorr(t2,q1,'unbiased');
C22    = xcorr(t2,q2,'unbiased');
C23    = xcorr(t2,q3,'unbiased');

C31    = xcorr(t3,q1,'unbiased');
C32    = xcorr(t3,q2,'unbiased');
C33    = xcorr(t3,q3,'unbiased');


subplot(3,2,1)
hold on;
plot(k1,C11);
plot(k1,C12);
plot(k1,C13);
title('Fonction de correlation normalise entre la trame 1 et les sons donné non compressé*')
xlabel('Decalage k')
hold off;

subplot(3,2,3)
hold on;
plot(k1,C21);
plot(k1,C22);
plot(k1,C23);
title('Fonction de correlation normalise entre la trame 2 et les sons donné non compressé*')
xlabel('Decalage k')
hold off;

subplot(3,2,5)
hold on;
plot(k1,C31);
plot(k1,C32);
plot(k1,C33);
title('Fonction de correlation normalise entre la trame 3 et les sons donné non compressé*')
xlabel('Decalage k')
hold off;

%% correlation croisee de tous les son sur les trame
xC11    = xcorr(t1,s1);
xC12    = xcorr(t1,s2);
xC13    = xcorr(t1,s3);
L1 = length(t1);
k1 = - (L1-1) : (L1-1);

% subplot(3,1,4);
% plot(t1) 
% title('trame 1');
% subplot(3,1,5);
% plot(t2) 
% title('trame 2');
% subplot(3,1,6);
% plot(t3) 
% title('trame 3');

ht1 = ones(1,L1)/L1;
abst1 = abs(t1);
envt1 = conv(abst1,ht1);

subplot(3,2,2)
hold on;
plot(k1,xC11);
plot(k1,xC12);
plot(k1,xC13);
hold off;
title('Fonction de correlation croisee entre la trame 1 et les sons donné non compressé*')
xlabel('Decalage k')

%trame 2
xC11 = xcorr(t2,s1);
xC12= xcorr(t2,s2);
xC13= xcorr(t2,s3);
L1 = length(t2);
k1 = - (L1-1) : (L1-1);
subplot(3,2,4)
hold on;
plot(k1,xC11);
plot(k1,xC12);
plot(k1,xC13);
hold off;
title('Fonction de correlation croisee entre la trame 2 et les sons donné non compressé*')
xlabel('Decalage k')

%trame 2
xC11 = xcorr(t3,s1);
xC12= xcorr(t3,s2);
xC13= xcorr(t3,s3);
L1 = length(t3);
k1 = - (L1-1) : (L1-1);
subplot(3,2,6)
hold on;
plot(k1,xC11);
plot(k1,xC12);
plot(k1,xC13);
hold off;
title('Fonction de correlation croisee entre la trame 3 et les sons donné non compressé*')
xlabel('Decalage k')


%% threshold 
% figure
% autocorr(s1);

thres = 0.02;   
for i = 1:length(C11)
    if(thres < C11(i))
        disp('trame 1 detecter')
    end
    if(thres < C12(i))
        disp('trame 2 detecter')
    end
    if(thres < C13(i))
        disp('trame 3 detecter')
    end
end
for i = 1:length(C21)
    if(thres < C11(i))
        disp('trame 1 detecter')
    end
    if(thres < C12(i))
        disp('trame 2 detecter')
    end
    if(thres < C13(i))
        disp('trame 3 detecter')
    end
end
for i = 1:length(C31)
    if(thres < C11(i))
        disp('trame 1 detecter')
    end
    if(thres < C12(i))
        disp('trame 2 detecter')
    end
    if(thres < C13(i))
        disp('trame 3 detecter')
    end
end