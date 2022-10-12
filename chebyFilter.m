n = 10;
fc = 8000;

% Elliptic filter - steep roll-off, ripple in pass- and stopband
[z, p, k] = cheby1(n, ripple, 2*pi*fc, 'low', 's');

% Plot magnitude and freq.
[a, b] = cheby1(n, ripple, 2*pi*fc, 'low', 's');
figure('Name', 'Magnitude and frequency of cheby');
freqs(a,b)

% continous time
fs = 24000;
t_resolution = 100; % Make it CT

t_end = 0.2;
t = 0:1/(t_resolution*fs):t_end; % 0.2 förut

ct_signal_wanted = sin(6000*2*pi.*t);
ct_signal_disturbance = sin(14000*2*pi.*t);
ct_signal_in = ct_signal_wanted + ct_signal_disturbance;
figure('Name', 'Input signal');
% plot(t, ct_signal_in)
xlim([0, t_end])

% Filter -> LTI system
ct_filter = zpk(z, p, k);

hold on
grid on
output_signal = lsim(ct_filter, ct_signal_in, t);
plot(t, output_signal, 'b');
plot(t, ct_signal_wanted, 'g')
plot(t, ct_signal_disturbance, 'r')
hold off

sampled_output = output_signal(1:1/fs:end);
t_sample = t(1:1/fs:end);
figure('Name', 'Bruh')
plot(t_sample, sampled_output)