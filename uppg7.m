% Parameters for the system
G = 0.8;
R = 828000;
C = 1e-9;
K = 0.32;

% Define the system
sys1 = tf(-1, [(R*C/G)^2, K*R*C/G, 1]); % LP

% bode(sys1);
% legend('H1')

% rect with fundamental freq. 50 HZ
% period 1/f = 1/50 = 0.02, duration 0.1 sec
[u, t] = gensig("square", 0.02, 0.1);
% plot(t, u)

% Sim. output with rect as input
% lsim simulates response data
lsim(sys1, u, t)
grid on