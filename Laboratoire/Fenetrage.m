%% Fenetrage 

Fe = 256;
N = 128;
dF = Fe/N;
duree = 2; %s
f0 = 8; %Hz
t = 0:1/Fe:duree;
s = sin(2*pi*f0*t)

%% a)
AmpSpecter = fft(s);
plot(AmpSpecter);