close all;
grid on;
%% ouverture des sons
[s1, fe] = audioread('SonsACompresser\son1.wav');
[s2, fe] = audioread('SonsACompresser\son2.wav');
[s3, fe] = audioread('SonsACompresser\son3.wav');

%% Calcul du pas de la fr�quence pour un spectre discret ainsi que de la plage de fr�quence (Nyquist theorem)
N = length(s1); %nb D'echantillons
df = fe/N;  %pas
freq = -fe/2:df:(fe/2 - df);    %plage de freq.

%% Sinus des sons

figure;
subplot(3, 1, 1)
plot(s1,'r');
subplot(3, 1, 2)
plot(s2,'r');
subplot(3, 1, 3)
plot(s3,'r');

%% FFT
amp1 = fft(s1,fe);
amp2 = fft(s2,fe);
amp3 = fft(s3,fe);

ang1 = angle(amp1);
ang2 = angle(amp2);
ang3 = angle(amp3);

% Remise en absolut.
amp1 = abs(amp1);
amp2 = abs(amp2);
amp3 = abs(amp3);

[pks1, freq1] = findpeaks(amp1(1:end/2), 'MinPeakProminence', 2.75,'MinPeakDistance', 120);
[pks2, freq2] = findpeaks(amp2(1:end/2), 'MinPeakProminence', 3,'MinPeakDistance', 900);
[pks2test, freq2test] = findpeaks(amp2(1:end/2), 'MinPeakProminence', 1,'MinPeakDistance', 700);

[pks3, freq3] = findpeaks(amp3(1:end/2), 'MinPeakProminence', 3,'MinPeakDistance', 470);

t = 0:1/fe:((N/fe)-(1/fe));

sin1 = 0;
sin2 = 0;
sin2test =0;
sin3 = 0;

for i = 1:16
    sin1 = sin1 + (pks1(i)/N *2)*cos(2*pi*(freq1(i)-1)/N*fe*t + ang1(freq1(i)));
    sin2 = sin2 + (pks2(i)/N *2)*cos(2*pi*(freq2(i)-1)/N*fe*t + ang2(freq2(i)));
    sin3 = sin3 + (pks3(i)/N *2)*cos(2*pi*(freq3(i)-1)/N*fe*t + ang3(freq3(i)));
end

figure
subplot(3,1,1);
plot(amp1);
title('Module du son1 sur les frequences');
xlabel('Frequence (Hz)');
ylabel('Module');
subplot(3,1,2);
plot(amp2);
title('Module du son2 sur les frequences');
xlabel('Frequence (Hz)');
ylabel('Module');
subplot(3,1,3);
plot(amp3);
title('Module du son3 sur les frequences');
xlabel('Frequence (Hz)');
ylabel('Module');

figure
subplot(3,1,1);
bar(freq1,pks1,0.05,'r');
title('Figure des pics selectionnes du module du son1');
xlabel('Frequences (Hz)');
ylabel('Module');
subplot(3,1,2);
bar(freq2,pks2,0.05,'r');
title('Figure des pics selectionnes du module du son2');
xlabel('Frequences (Hz)');
ylabel('Module');
subplot(3,1,3);
bar(freq3,pks3,0.05,'r');
title('Figure des pics selectionnes du module du son3');
xlabel('Frequences (Hz)');
ylabel('Module');

figure;
subplot(3,1,1);
plot(sin1);
title('Cosinus reconstruit appartir des parametre du son1');
xlabel('Echantillion');
ylabel('Amplitude');
subplot(3,1,2);
plot(sin2);
title('Cosinus reconstruit appartir des parametre du son2');
xlabel('Echantillion');
ylabel('Amplitude');
subplot(3,1,3);
plot(sin3);
title('Cosinus reconstruit appartir des parametre du son3');
xlabel('Echantillion');
ylabel('Amplitude');

%Filtre a moyenne mobile.
L = 5000;
h = ones(1,L)/L;

abs1 = abs(s1);
abs2 = abs(s2);
abs3 = abs(s3);

env1 = conv(abs1,h);
env2 = conv(abs2,h);
env3 = conv(abs3,h);

figure;
subplot(3, 1, 1)
plot(abs1,'r');
hold on
plot(env1);
title('Signal du son1 redresse avec l''enveloppe convolue');
xlabel('Echantillion');
ylabel('Amplitude');
subplot(3, 1, 2)
plot(abs1,'r');
hold on
plot(env2);
title('Signal du son2 redresse avec l''enveloppe convolue');
xlabel('Echantillion');
ylabel('Amplitude');
subplot(3, 1, 3)
plot(abs1,'r');
hold on
plot(env3);
title('Signal du son3 redresse avec l''enveloppe convolue');
xlabel('Echantillion');
ylabel('Amplitude');

sample1 = [];
sample2 = [];
sample3 = [];

for i = 1:1000:N
    sample1(end+1) = env1(i);
    sample2(end+1) = env2(i);
    sample3(end+1) = env3(i);
end

i = 1:1000:70000;
k = 1:1:length(s1);

%Lineaire
lin1 = interp1(i,sample1,k);
lin2 = interp1(i,sample2,k);
lin3 = interp1(i,sample3,k);

%Spline-Cubic
splin1 = spline(i,sample1,k);
splin2 = spline(i,sample2,k);
splin3 = spline(i,sample3,k);

figure
subplot(3,1,1);
plot(env1);
hold on
plot(lin1);
hold on
plot(k,splin1);
title('Enveloppe Convolue, interpole lineairement et interpole Spline-Cubic  du son1')
xlabel('Echantillon')
ylabel('Amplitude')
legend('bleu: enveloppe, Rouge: Lineaire, Jaune: Spline-Cubic');

subplot(3,1,2);
plot(env2);
hold on
plot(lin2);
hold on
plot(k,splin2);
title('Enveloppe Convolue, interpole lineairement et interpole Spline-Cubic  du son2')
xlabel('Echantillon')
ylabel('Amplitude')
legend('bleu: enveloppe, Rouge: Lineaire, Jaune: Spline-Cubic');

subplot(3,1,3);
plot(env3);
hold on
plot(lin3);
hold on
plot(k,splin3);
title('Enveloppe Convolue, interpole lineairement et interpole Spline-Cubic du son3')
xlabel('Echantillon')
ylabel('Amplitude')
legend('bleu: enveloppe, Rouge: Lineaire, Jaune: Spline-Cubic');
hold off

outlin1 = sin1 .*lin1;
outlin2 = sin2 .*lin2;
outlin3 = sin3 .*lin3;

figure 
subplot(3,1,1)
plot(outlin1)
title('Son1 reconstitue');
xlabel('Echantillon');
ylabel('Amplitude');
subplot(3,1,2)
plot(outlin2)
title('Son2 reconstitue');
xlabel('Echantillon');
ylabel('Amplitude');
subplot(3,1,3)
plot(outlin3)
title('Son3 reconstitue');
xlabel('Echantillon');
ylabel('Amplitude');

audiowrite('SonsReconstruit\reconstruit1.wav',outlin1,fe);
audiowrite('SonsReconstruit\reconstruit2.wav',outlin2,fe);
audiowrite('SonsReconstruit\reconstruit3.wav',outlin3,fe);

filename = 'newson2Spline.wav';
newson2Spline = newson2Spline./(max(abs(newson2Spline)));
audiowrite(filename,newson2Spline,fe)

%  soundsc(outlin1,fe);
%  pause(2)
%  soundsc(s1,fe);

% soundsc(outlin2,fe);
% pause(2)
% soundsc(s2,fe);
% pause(2)

%  soundsc(outlin3,fe);
% pause(2)
%  soundsc(s3,fe);

