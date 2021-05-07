%% Modelo de referencia
close all 
set(0,'defaultfigurecolor', [1 1 1]);
set(0, 'DefaultLineLineWidth', 2);
% set(0,'defaulttextinterpreter','latex');

%% Projeto do controlador por realimentacao de estado
clear
% Parametros:
Ts = 1;          % Periodo de amostragem
tfinal = 1000;   % Tempo de simulacao
t = 0:Ts:tfinal; % Vetor temporal
n = length(t);   % Numero de amostras


% Processo
% G = 0.00483*z/( z^2 - 1.463*z + 0.4878);% Ts = 2e-2; PID = {2, .1, 2})
% G = 0.1542*z/( z^2 - 1.463*z + 0.4878); % Ts = 2e-2; PID = {2, .1, 2})
% G = 0.02321*z/( z^2 - 1.463*z + 0.4878);  % Ts = 1; PID = {2, .1, 2}
z = tf('z',Ts);
G = 0.023210385844888*z/( z^2 - 1.463414634146634*z + 0.487804878048933);  % Ts = 1; PID = {2, .1, 2})
% Continuo


% Gerando resposta em malha aberta:
% rng(2);
u = prbs(n,9,10);            % Sinal de excitacao
y = dlsim(G.num,G.den,u);   % Sinal de saida

%% Modelo de referencia
      
% Parametros desejados:
tau = 10;
a = exp(-Ts/tau);

% z = tf('z',Ts);
T = (1-a)/(z-a);
yr = step(T,t);

%% Identificando controlador
Kpid0 = [2; 0.1; 2]
Kpid1 = VRFT_PID_MR1aO(tau,Ts,1,u,y)
Kpid2 = VRFT_PID_MR1aO_v2(tau,Ts,u,y)

%% Resposta em Malha fechada
ymf0 = degrauMFPID(G,Kpid0,t);
ymf1 = degrauMFPID(G,Kpid1,t);
ymf2 = degrauMFPID(G,Kpid2,t);

%% Figuras
f1=figure(1); clf;
set(f1,'TickLabelInterpreter', 'tex');
% subplot(3,1,1)
    % plot(t,yr,t,ymf0,'+b',t,ymf1,'--k',t,ymf2,'-.r');
    % title('Resposta em Malha Fechada');
    % ylim([0 1.2])
    % xlim([0 50]);
subplot(3,1,1)
    stairs(t,yr)
    hold on;
    stairs(t,ymf0,'.b')
%     ,'+b',t,ymf1,'--k',t,ymf2,'-.r');
    stairs(t,ymf1,'--k')
    stairs(t,ymf2,'+r');
    title('Resposta em Malha Fechada');
    ylim([0 1.2])
    xlim([0 30])
    
    
subplot(3,1,[2 3])
    [AX,H1,H2] = plotyy(t,u,t,y,'stairs');
    set(get(AX(1),'Ylabel'),'String','Entrada (u)') 
    set(get(AX(2),'Ylabel'),'String','Saida (y)')
    set(AX(1),'YTick',[-1:.5:1])
    set(AX(2),'YTick',[0:.2:.2])
    axis(AX(1),[0 tfinal -.1  3]); grid(AX(1));
    axis(AX(2),[0 tfinal -.2 max(y)]); grid(AX(2));
    xlabel('tempo (s)');
    % plot(t,u,'g',t,y,'b');
    % legend('entrada','saida');
    title('Resposta em Malha Aberta');

hideToolbar();
