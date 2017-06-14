close all

alpha = 1000;           % Paramètre de modulation en fréquence
Fe = 8000;              % Fréquence d'échantillonnage
F0 = 1000;              % Fréquence initiale
T = 25;                 % Durée en secondes
t = (0:Fe*T-1)/Fe;      % temps
theta = 2*pi*F0*t + 0.5*pi*alpha*(t .^2);
x = cos (theta);
soundsc (x,Fe);
plot(abs(fftshift(fft(x))))