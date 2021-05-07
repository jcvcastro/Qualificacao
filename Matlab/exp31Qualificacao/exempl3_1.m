%% Exemplo 3.1 - Qualificacao
% Data: 2021-04-26
clear

% Criando sinal de entrada:
nt = 60;
ns = 250;
% u = prbs(nt,9,10);            % Sinal de excitacao
Ts = 1;
distAmp = 0.5;    % Amplitude do disturbio
distTime = 75;   % Instante do disturbio
t = 0:Ts:(nt-1)*Ts;
u = square(2*pi*1/50*t);
u = [zeros(1,10), u(1:end-10)];
u = u';
y1 = zeros(nt,1);

%% Modelo (Wei & Billings, 2008) - s1
rho = [-1.7; -0.8; 1; 0.81];
y0 = [0; 0];
model_sis = [1001; 1002; 2001; 2002];
y=simodeld(model_sis,rho,u,y0); 


G = tf([0 rho(3:4)'],[1 -rho(1:2)'],Ts);


%% Modelo de referencia
      
% Parametros desejados:
tau = 5;            % cst de tempo do MR 1a ord
a = exp(-Ts/tau);    % parametro
d = 1;               % atraso puro de tempo



%% identificando controlador

z = tf('z',Ts);
theta0 = [0.181269246922018   0.308157719767431   0.145015397537615 0.189999999999999  0.809999999999997]';
model_cont0 = [2000; 2001; 2002; 1001; 1002]
theta0

[theta1 rv ev] = vrft_ex31_v2(tau,Ts,u,y)
    model_cont1 = [2000; 2001; 2002; 1001; 1002];
    theta1
    C1 = tf(theta1(1:3)', [1 -theta1(4:end)'],Ts)

% theta2 = vrft_ex31_v3(tau,Ts,u,y)
%     model_cont2 = [2000; 2001; 1001; 1002];
%     C2 = tf(theta2(1:2)', [1 -theta2(3:end)'],Ts)
theta2 = vrft_ex31_v3(tau,Ts,u,y)
    model_cont2 = [2000; 2001; 2002; 1001];
    C2 = tf(theta2(1:3)', [1 -theta2(4)' 0],Ts)

kpid1 = vrft_pid_mr1ao(tau,Ts,1,u,y)
   Kp = kpid1(1); Ki = kpid1(2); Kd = kpid1(3);
   C3 = Kp + Ki*z/(z-1) + Kd*(z-1)/z
   
[kpid4, theta4_ols, theta4_cls] = vrft_ex31_v4(tau,Ts,u,y)
    model_cont4 = [2000; 2001; 2002; 1001];
    C4 = tf(theta4_cls(1:3)', [1 -theta4_cls(4)' 0],Ts)

% [kpid2, theta2] = vrft_pid_mr1ao_v2(tau,Ts,u,y)
% model_cont2 = [2000; 2001; 2002; 1001];

%%
sim('simulacao_sis2aord')
% plota_resp_sis_linear

%% Resposta em Malha fechada
% ts = 0:Ts:(ns-1)*Ts;
% r = square(2*pi*1/100*ts);
% r = [zeros(1,10), r(1:end-10)]';
% yr = MR1aO(r,a,d,1);
% ymf0 = sis_mf(r,model_sis,rho,model_cont0,theta0);
% ymf1 = respMFPID(r,G,kpid1);
% % ymf2 = respMFPID(r,G,kpid2);
% ymf2 = sis_mf(r,model_sis,rho,model_cont2,theta2);
% ymf3 = sis_mf(r,model_sis,rho,model_cont3,theta3);

% z = tf('z',G.Ts);
% Gc = tf(theta2(1:3)',[1 -theta2(4)' 0],Ts)
% Gmf = feedback(G*Gc,1);
% ymf4 = dlsim(Gmf.num{1},Gmf.den{1},r);

 
%% Figuras
% f1=figure(1); clf;
% % set(f1,'TickLabelInterpreter', 'tex');
% subplot(3,1,1)
%     plot(ts,yr,ts,ymf1,'--g',ts,ymf2,'-.g',ts,ymf3,'--r',ts,ymf0,':k');
%     title('Resposta em Malha Fechada');
%     legend('yr','ymf1','ymf2','ymf3','ymf0')
%     ylim([-1.2 1.2])
%     % xlim([0 500]);
% % subplot(3,1,1)
%     % plot(ts,yr, ts,ymf0,'.b', ts,ymf1,'--k', ts,ymf2,'-.r');
%     % % stairs(ts,yr)
%     % % hold on;
%     % % stairs(ts,ymf0,'.b')
% % % %     ,'+b',ts,ymf1,'--k',ts,ymf2,'-.r');
%     % % stairs(ts,ymf1,'--k')
%     % % stairs(ts,ymf2,'+r');
%     % title('Resposta em Malha Fechada');
%     % ylim([-1.2 1.2])
%     % xlim([0 1000])
%     %
%     
%     subplot(3,1,2)
%     plot(t,u)
%     subplot(3,1,3)
%     plot(t,y)
% % subplot(3,1,[2 3]% )
%     % tfinal = 1000;
%     % [AX,H1,H2] = plotyy(t,u,t,y,'stairs');
%     % set(get(AX(1),'Ylabel'),'String','Entrada (u)')
%     % set(get(AX(2),'Ylabel'),'String','Saida (y)')
%     % set(AX(1),'YTick',[-1:.5:1])
%     % set(AX(2),'YTick',[0:.2:.2])
%     % axis(AX(1),[0 tfinal -.1  3]); grid(AX(1));
%     % axis(AX(2),[0 tfinal -.2 max(y)]); grid(AX(2));
%     % xlabel('tempo (s)');
%     % % plot(ts,u,'g',ts,y,'b');
%     % % legend('entrada','saida');
%     % title('Resposta em Malha Aberta');
% 
% % hideToolbar();
% %
% %
% %
