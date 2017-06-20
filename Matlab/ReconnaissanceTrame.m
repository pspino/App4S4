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

s1(numel(t1)) = 0;
s2(numel(t2)) = 0;
s3(numel(t3)) = 0;

C11     = xcorr(t1,s1,'unbiased');
C12    = xcorr(t1,s2,'unbiased');
C13    = xcorr(t1,s3,'unbiased');

C21    = xcorr(t2,s1,'unbiased');
C22    = xcorr(t2,s2,'unbiased');
C23    = xcorr(t2,s3,'unbiased');

C31    = xcorr(t2,s1,'unbiased');
C32    = xcorr(t2,s2,'unbiased');
C33    = xcorr(t2,s3,'unbiased');

figure
subplot(3,1,1)
hold on;
plot(k1,C11,'b');
plot(k1,C12,'r');
plot(k1,C13,'g');
hold off;

subplot(3,1,2)
hold on;
plot(k1,C21,'b');
plot(k1,C22,'r');
plot(k1,C23,'g');
hold off;

subplot(3,1,3)
hold on;
plot(k1,C31,'b');
plot(k1,C32,'r');
plot(k1,C33,'g');
hold off;

%% correlation croisee de tous les son sur les trame
xC11     = xcorr(t1,s1);
xC12    = xcorr(t1,s2);
xC13    = xcorr(t1,s3);
L1 = length(t1);
k1 = - (L1-1) : (L1-1);

% subplot(6,1,4);
% plot(t1) 
% title('trame 1');
% subplot(6,1,5);
% plot(t2) 
% title('trame 2');
% subplot(6,1,6);
% plot(t3) 
% title('trame 3');

ht1 = ones(1,L1)/L1;
abst1 = abs(t1);
envt1 = conv(abst1,ht1);

figure
subplot(3,1,1)
hold on;
plot(k1,xC11);
plot(k1,xC12);
plot(k1,xC13);
hold off;
title('Fonction de correlation croisee entre la trame 1 et les sons donn� non compress�*')
xlabel('Decalage k')

%trame 2
xC11 = xcorr(t2,s1);
xC12= xcorr(t2,s2);
xC13= xcorr(t2,s3);
L1 = length(t2);
k1 = - (L1-1) : (L1-1);
subplot(3,1,2)
hold on;
plot(k1,xC11);
plot(k1,xC12);
plot(k1,xC13);
hold off;
title('Fonction de correlation croisee entre la trame 2 et les sons donn� non compress�*')
xlabel('Decalage k')

%trame 2
xC11 = xcorr(t3,s1);
xC12= xcorr(t3,s2);
xC13= xcorr(t3,s3);
L1 = length(t3);
k1 = - (L1-1) : (L1-1);
subplot(3,1,3)
hold on;
plot(k1,xC11);
plot(k1,xC12);
plot(k1,xC13);
hold off;
title('Fonction de correlation croisee entre la trame 3 et les sons donn� non compress�*')
xlabel('Decalage k')