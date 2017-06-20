close all;

[s1, fe] = audioread('SonsReconstruit\reconstruit1.wav');
[s2, fe] = audioread('SonsReconstruit\reconstruit2.wav');
[s3, fe] = audioread('SonsReconstruit\reconstruit3.wav');

[t1, fe] = audioread('TramesAReconnaitre\trame1.wav');
[t2, fe] = audioread('TramesAReconnaitre\trame2.wav');
[t3, fe] = audioread('TramesAReconnaitre\trame3.wav');

N = length(s1);                 %nb D'echantillons
df = fe/N;                      %pas
freq = -fe/2:df:(fe/2 - df);    %plage de freq.

%% Correlation
c1 = 0;
c2 = 0;
c3 = 0;

c1 = sum(s1 .* t1);

% soundsc(t1,fe);