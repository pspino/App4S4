close all;
Delta = 0.001;
t = 0:Delta:1-Delta;
x = sin(2*pi*10*t);                 % signal de départ x
gain = 0.8;                         % amplitude du bruit
bruit = randn(1,length(x))*gain;    % bruit blanc gaussien
xb = x+bruit;                       % ajout de bruit blanc
L = 50;                             % longueur du filtre à moyenne mobile
h = ones(1,L)/L;                    % filtre à moyenne mobile d’amplitude uniforme
y = conv(xb, h);                    % convolution du signal avec le filtre

figure
subplot(3, 1, 1)
plot(t,(abs(fft(x,1/Delta))))
subplot(3, 1, 2)
plot(t,(abs(fft(xb,1/Delta))))
subplot(3, 1, 3)
h2 = [ones(1,L)/L, zeros(1,L-1/Delta)]; % Ajoute de zéros à la fin du filtre
plot(t,(abs(fft(h2,1/Delta))))

figure
subplot(3, 1, 1)
plot(t, x)
subplot(3, 1, 2)
plot(t, xb)
subplot(3, 1, 3)
plot(t, y(fix(L/2):length(t)+fix(L/2)-1))