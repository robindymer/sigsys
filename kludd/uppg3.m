% Part a: draw pole-zero plots for H1, H2 and H3
G = 0.8;
R = 1000;
C = 1e-9;
K = 1;

sys3 = tf([-1, 0, 0], [1, G*K/(R*C), (G/(R*C))^2]);
sys2 = tf([-1, 0], [R*C/G, K, G/(R*C)]);
sys1 = tf(-1, [(R*C/G)^2, K*R*C/G, 1]);

% Pole-zero plots
% figure;
% h1 = iopzplot(sys1);
% figure;
% h2= iopzplot(sys2);
% figure;
h3 = iopzplot(sys3);

% Impulse response
% figure;
% impulse(sys1);
% figure;
% impulse(sys2);
% figure;
% impulse(sys3);

% figure;
% bode(sys1);
% figure;
% bode(sys2);
% figure;
% bode(sys3);

% setoptions(h,'IOGrouping','all')