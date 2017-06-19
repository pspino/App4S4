close all;

%% ouverture des sons
[s1, fe] = audioread('SonsACompresser\son1.wav');
[s2, fe] = audioread('SonsACompresser\son2.wav');
[s3, fe] = audioread('SonsACompresser\son3.wav');

%% Calcul du pas de la fr�quence pour un spectre discret ainsi que de la plage de fr�quence (Nyquist theorem)
N = length(s1); %nb D'echantillons
df = fe/N;  %pas
freq = -fe/2:df:(fe/2 - df);    %plage de freq.

% Filtre a moyenne mobile.
% L = 44100;
% h = ones(1,L)/L;
% 
% filteredS1 = conv(s1,h);
% plot(filteredS1);

%% Sinus des sons
figure;
subplot(3, 1, 1)
plot(s1,'r');
hold on
%plot(env1);

subplot(3, 1, 2)
plot(s2,'r');
hold on
%plot(env2);

subplot(3, 1, 3)
plot(s3,'r');
hold on 
%plot(env3);

%% FFT
amp1 = fft(s1,N);
amp2 = fft(s2,N);
amp3 = fft(s3,N);

ang1 = angle(amp1);
ang2 = angle(amp2);
ang3 = angle(amp3);

% Remise en absolut.
amp1 = abs(amp1);
amp2 = abs(amp2);
amp3 = abs(amp3);

[pks1, freq1] = findpeaks(amp1(1:end/2), 'MinPeakProminence', 2.8,'MinPeakDistance', 190);
[pks2, freq2] = findpeaks(amp2(1:end/2), 'MinPeakProminence', 3,'MinPeakDistance', 900);
[pks3, freq3] = findpeaks(amp3(1:end/2), 'MinPeakProminence', 2  ,'MinPeakDistance', 850);

t = 0:1/fe:N/fe;
sin1 = 0;

for i = 1:16
    sin1 = sin1 + (pks1(i)/N *2)*cos(2*pi*(freq1(i)-1)/N*fe*t + ang1(freq1(i)));
    sin2 = sin1 + (pks2(i)/N *2)*cos(2*pi*(freq2(i)-1)/N*fe*t + ang2(freq1(i)));
    sin3 = sin1 + (pks3(i)/N *2)*cos(2*pi*(freq3(i)-1)/N*fe*t + ang3(freq1(i)));
end

figure
subplot(3,1,1);
plot(amp1);
subplot(3,1,2);
plot(amp2);
subplot(3,1,3);
plot(amp3);

figure
subplot(3,1,1);
plot(pks1);
subplot(3,1,2);
plot(pks2);
subplot(3,1,3);
plot(pks3);

figure;
subplot(3,1,1);
plot(sin1);
subplot(3,1,2);
plot(sin2);
subplot(3,1,3);
plot(sin3);

% %Exemple de sortie graphique en supposant que les transform�es de Fourier ad�quates ont �t� calcul�es
% figure;
% subplot(3, 1, 1)
% plot(abs(freq), res1); % Transform�eDeS1 n'existe pas, il faut la trouver dans le cadre de cette unit�
% xlabel('f (Hz)')
% ylabel('Amplitude (V)')
% title('Spectre du son 1')
% 
% subplot(3, 1, 2)
% plot(abs(freq),  res2) % Transform�eDeS2 n'existe pas, il faut la trouver dans le cadre de cette unit�
% xlabel('f (Hz)')
% ylabel('Amplitude (V)')
% title('Spectre du son 2')
% 
% subplot(3, 1, 3)
% plot(abs(freq),  res3) % Transform�eDeS3 n'existe pas, il faut la trouver dans le cadre de cette unit�
% xlabel('f (Hz)')
% ylabel('Amplitude (V)')
% title('Spectre du son 3')

% �coute des fichiers (support� seulement sous windows: wavplay)
% Il est possible d'utiliser soundsc (independant de tous les systemes
%  d'exploitation)
% soundsc(sin1, fe);
% [s1, fe, NBITS] = wavread('son1');
% [s2, fe, NBITS] = wavread('son2');
% [s3, fe, NBITS] = wavread('son3');