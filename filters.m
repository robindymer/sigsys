n = 6; % Order of filter
fc = 8000; % Passband edge freq.
fsc = 16000; % Stopband edge freq.
fs = 24000; % Sample freq.
Rp = 3; % Passband riple

% Passband edge freq. in rad/s
% Peak-to-peak passband ripple in dB

% [z2,p2,k2] = cheby2(n,Rp,2*pi*fsc,'s');
% [b2,a2] = zp2tf(z2,p2,k2);
% [h2,w2] = freqs(b2,a2,4096);
[z2,p2,k2] = cheby2(n, 3, fsc/(fs/2), 's');
[b2,a2] = zp2tf(z2,p2,k2);
[h2,w2] = freqs(b2,a2,fs);

plot(w2/(2e9*pi),mag2db(abs(h2)))
% axis([0 4 -40 5])