close all

alpha = 1000;           % Param�tre de modulation en fr�quence
Fe = 8000;              % Fr�quence d'�chantillonnage
F0 = 1000;              % Fr�quence initiale
T = 25;                 % Dur�e en secondes
t = (0:Fe*T-1)/Fe;      % temps
theta = 2*pi*F0*t + 0.5*pi*alpha*(t .^2);
x = cos (theta);
soundsc (x,Fe);
plot(abs(fftshift(fft(x))))