n = 23;
fc = 8000;

[z, p, k] = butter(n, 2*pi*fc, 'low', 's');

% Plot magnitude and freq.
[a, b] = butter(n, 2*pi*fc, 'low', 's');
figure('Name', 'Magnitude and frequency of butter');
freqs(a,b)

% continous time
fs = 24000;
t_resolution = 100; % Make it CT
t = 0:1/(t_resolution*fs):0.002; % 0.2 förut
t_end = 0.002;
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