close all;

L = 1001;
lags = -500:1:500;

n1 = randn(L,1);% premier signal de bruit blanc
n2 = randn(L,1);% deuxi�me signal de bruit blanc

subplot(2, 1, 1)
plot(lags, xcorr(n1, n2, (L-1)/2, 'unbiased')) % corr�lation crois�e des deux signaux de bruit

grid
D = fix((rand(1)-1)*L); % valeur de d�calage al�atoire
nc = circshift(n1,-D);  % d�calage de D �chantillons

subplot(2, 1, 2)
plot(lags, xcorr(n1, nc, (L-1)/2, 'unbiased'))
grid