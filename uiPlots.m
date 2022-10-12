% Parameters for the system
G = 0.8;
R = 1000;
C = 1e-9;
K = 1;

% Define the systems
sys3 = tf([-1, 0, 0], [1, G*K/(R*C), (G/(R*C))^2]); % HP
sys2 = tf([-1, 0], [R*C/G, K, G/(R*C)]); % BP
sys1 = tf(-1, [(R*C/G)^2, K*R*C/G, 1]); % LP

% Create a figure window
fig = uifigure;
% Create som text
lbl = uilabel(fig,"Position",[100 50 350 32]);
% Give it some style
lbl.Text = "<font style='color:green;'>Choose what to plot</font> for transfer functions <em>H1, H2</em> and <em>H3</em>.";
lbl.Interpreter = "html";

% Create three push buttons for each operation
btnPZ = uibutton(fig,'push',...
               'Text', 'Pole-zero',...
               'Position',[420, 218, 100, 22],...
               'ButtonPushedFcn', @(btn,event) plotPoleZero(sys1, sys2, sys3));
btnIR = uibutton(fig,'push',...
               'Text', 'Impulse response',...
               'Position',[220, 218, 110, 22],...
               'ButtonPushedFcn', @(btn,event) plotIR(sys1, sys2, sys3));
btnBode = uibutton(fig,'push',...
               'Text', 'Bode',...
               'Position',[20, 218, 100, 22],...
               'ButtonPushedFcn', @(btn,event) plotBode(sys1, sys2, sys3));

% Create the function for the ButtonPushedFcn callback
function plotPoleZero(sys1, sys2, sys3)
% Pole-zero plots
figure;
iopzplot(sys1);
legend('H1')
figure;
iopzplot(sys2);
legend('H2')
figure;
iopzplot(sys3);
legend('H3')
end

function plotIR(sys1, sys2, sys3)
% Impulse response plots
figure;
impulse(sys1);
legend('H1')
figure;
impulse(sys2);
legend('H2')
figure;
impulse(sys3);
legend('H3')
end

function plotBode(sys1, sys2, sys3)
% Bode plots
figure;
bode(sys1);
legend('H1')
figure;
bode(sys2);
legend('H2')
figure;
bode(sys3);
legend('H3')
end