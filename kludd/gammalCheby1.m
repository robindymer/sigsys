% n = 10;
ripplePass = 3; % dB
rippleStop = 72.25; % dB (0.5/2^11 -> dB)
wp = 8000*2*pi; % Extract components 'til 8 kHz
ws = 11000*2*pi; % No components in range 8 - 11 kHz
fs = 24000; % sample freq.

% Calculate order and cutoff angular frequency
[N_cheb, Ws_cheb] = cheb1ord(wp, ws, ripplePass, rippleStop,'s');

% Elliptic filter - steep roll-off, ripple in pass- and stopband
% But we're satisfied with chebyshev I
[z, p, k] = cheby1(n, ripplePass, 2*pi*fc, 'low', 's');

% Plot magnitude and freq.
[a, b] = cheby1(n, ripplePass, 2*pi*fc, 'low', 's');
figure('Name', 'Magnitude and frequency of chebyshev I');
freqs(a,b)

% continous time
t_resolution = 10; % Make it CT

t_end = 0.002;
t = 0:1/(t_resolution*fs):t_end; % 0.2 förut

ct_signal_wanted = sin(6000*2*pi.*t);
ct_signal_disturbance = sin(14000*2*pi.*t);
ct_signal_in = ct_signal_wanted + ct_signal_disturbance;
figure('Name', 'Input signal');
plot(t, ct_signal_in)
% xlim([0, t_end])

% Filter -> LTI system
ct_filter = zpk(z, p, k);

% Simulate output response of filter
figure('Name', 'Output, wanted and disturbance');
hold on
grid on
output_signal = lsim(ct_filter, ct_signal_in, t);
plot(t, output_signal, 'b');
plot(t, ct_signal_wanted, 'g')
plot(t, ct_signal_disturbance, 'r')
hold off

% Sampling
sampled_output = output_signal(1:1/fs:end);
t_sample = t(1:1/fs:end);
figure('Name', 'Sampled output signal')
plot(t_sample, sampled_output)

% FFT
N = length(sampled_output); % Number of samples

X = fft(sampled_output); % We'll get the N corresponding freq. values
fvector = (0:N-1)/N*fs; % Frequency
disp(length(fvector))
figure('Name', 'FFT')
plot(fvector, abs(X)/max(X)) % Hz -> kHz and normalize amplitude
xlim([0 fs/2*1e-3])
xlabel('Frequency (kHz)')
ylabel('Amplitude')
title('Discrete Fourier Transform')
% disp(fvector(