close all
%% Variables
xn = [2 1 -1 0];
hn = [1 -1 0 0];

%% a)
% hold on;
% scatter(0:1:3,xn);
% scatter(0:1:3,hn);

convDirect = conv(xn,hn);
%% b)
Xn = fft(xn);
Hn = fft(hn);

convIndirect = Xn .* Hn;
verification = ifft(convIndirect);
