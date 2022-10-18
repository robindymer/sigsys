% n = 10;
ripplePass = 3; % dB
rippleStop = 72.25; % dB (0.5/2^11 -> dB)
wp = 8000*2*pi; % Extract components 'til 8 kHz
ws = 11000*2*pi; % No components in range 8 - 11 kHz
fs = 20000; % sample freq.

% Calculate order and cutoff angular frequency
[n, Wp] = cheb1ord(wp, ws, ripplePass, rippleStop,'s');

% Coefficients
[numerator, denominator] = cheby1(n, ripplePass, Wp, 's');
% Make it a LTI-system
ct_filter = tf(numerator, denominator);

% Plot magnitude and freq.
% [a, b] = cheby1(n, ripplePass, Wp, 'low', 's');
% figure('Name', 'Magnitude and frequency of chebyshev I');
% freqs(numerator, denominator)
% disp(numerator)
% disp(denominator)

% continous time
f1 = 8e3;
f2 = 12e3;
t_resolution = 100; % Make it approximately CT

t_end = 0.002;
t = 0:1/(t_resolution*fs):1; % 0.2 förut

ct_signal_wanted = sin(f1*2*pi.*t);
ct_signal_disturbance = sin(f2*2*pi.*t);
ct_signal_in = ct_signal_wanted + ct_signal_disturbance;
figure('Name', 'Input signal');
plot(t, ct_signal_in)
xlim([0, t_end])

% Filter -> LTI system
% ct_filter = zpk(z, p, k);

% Simulate output response of filter
figure('Name', 'Output, wanted and disturbance');
hold on
grid on
output_signal = lsim(ct_filter, ct_signal_in, t);
plot(t, output_signal, 'b');
plot(t, ct_signal_wanted, 'g')
plot(t, ct_signal_disturbance, 'r')
xlim([0, t_end*2])
hold off

% Sampling
% sampled_output = output_signal(1:1/fs:end);
% t_sample = t(1:1/fs:end);
% figure('Name', 'Sampled output signal')
% plot(t_sample, sampled_output)

% Sampling
t_sampled = 0:1/fs:1;
ct_sampled = sin(2*pi*f1.*t_sampled) + sin(2*pi*f2.*t_sampled);

% FFT
N = length(ct_sampled); % Number of samples
X = fft(ct_sampled); % We'll get the N corresponding freq. values
fvector = (0:N-1)/N*fs; % Frequency
disp(length(fvector))
figure('Name', 'FFT')
plot(fvector/1e3, abs(X)/max(X)) % Hz -> kHz and normalize amplitude
xlim([0 fs/2e3])
xlabel('Frequency (kHz)')
ylabel('Amplitude')
title('Discrete Fourier Transform')