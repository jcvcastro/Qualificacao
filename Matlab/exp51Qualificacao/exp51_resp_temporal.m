% simula_modelo_(arquivo)
%% Exemplo 5.1 - Qualificacao
% Simulacao da resposta temporal do modelo gerado no R
% Data: 2021-04-26


modelo_completo=csvread('exp51_resp_temporal_ideal_SR.csv',1,1);
model_cont0 = modelo_completo(:,2:end)
q0 = modelo_completo(:,1)
% modelo_completo=csvread('exp51_resp_temporal_SEM_ruido_case10.csv',1,1);
modelo_completo=csvread('exp51_resp_temporal_SEM_ruido_case24.csv',1,1);
model_cont1 = modelo_completo(:,2:end)
q1 = modelo_completo(:,1)
% modelo_completo=csvread('exp51_resp_temporal_COM_ruido_case10.csv',1,1);
modelo_completo=csvread('exp51_resp_temporal_COM_ruido_case24.csv',1,1);
model_cont2 = modelo_completo(:,2:end)
q2 = modelo_completo(:,1)

%% Modelo (Wei & Billings, 2008) - s1
Ts = 1;
nt = 60;
ns = 250;
rho = [-1.7; -0.8; 1; 0.81];
y0 = [0; 0];
model_sis = [1001; 1002; 2001; 2002];



ts = 0:Ts:(ns-1)*Ts;
r = square(2*pi*1/100*ts);
r = [zeros(1,10), r(1:end-10)]';

%% Modelo de referencia
% Parametros desejados:
tau = 5;            % cst de tempo do MR 1a ord
a = exp(-Ts/tau);    % parametro
d = 1;               % atraso puro de tempo
yr = MR1aO(r,a,d,1);
yr=yr';

%% Resposta em Malha fechada
ymf0 = sis_mf(r,model_sis,rho,y0,model_cont0,q0);
ymf1 = sis_mf(r,model_sis,rho,y0,model_cont1,q1);
ymf2 = sis_mf(r,model_sis,rho,y0,model_cont2,q2);
emf0 = yr-ymf0;
emf1 = yr-ymf1;
emf2 = yr-ymf2;

%% Fig2 - Resposta temporal y

set(0,'defaultfigurecolor', [1 1 1]);
% set(0, 'DefaultLineLineWidth', 1.5);
set(0,'defaulttextinterpreter','latex');

cor1 = [0 0 0];
cor2 = [0 0 1];
cor3 = [1 0 0];
cor4 = [0 0 0];
cores = [cor1; cor2; cor3; cor4];
% col = lines(5); 
corMagnif = [.8 .8 .8];
lw=1


f2=figure(2); clf;
subplot(3,1,1:2);
   hold on;
   ax=gca;
   ax.ColorOrder = cores;
   stairs(ts,r,'k:','LineWidth',lw);
   stairs(ts,yr,'k','LineWidth',0.5);
   stairs(ts,ymf1,'b--','LineWidth',1.5);
   stairs(ts,ymf2,'r:','LineWidth',lw);
   % stairs(ts,ymf0,'Color',[0 0.5 0],'LineWidth',lw);
   % set(gca,'Xticklabel',[])
   ylabel('output')
   ylim([-1.5 1.5])
   % set(gca,'XTick',[])
   xticklabels({})
   xticks(0:50:ts(end)+1)
   grid on;

   % rangeY=[-1.01 -0.99];
   % MagInset2(f2,ax,[100 105 rangeY],[130 165 -1.4 -0.5],{'NE','NW';'SE','SW'},corMagnif,corMagnif,corMagnif);
   % set(gca,'YTick',[rangeY],'XTick',[])
   
% 
%    MagInset2(f2,ax,[170 200 rangeY],[175 250 -1.25 0.3],{'SW','NW';'SE','NE'},corMagnif,corMagnif,corMagnif);
%    set(gca,'YTick',[rangeY],'XTick',[])
%    set(ax,'colororder',col)
%    % set(ax,'Visible','off')
   %
subplot(3,1,3)
   hold on;
   ax=gca;
   ax.ColorOrder = cores(2:end,:);
   corMagnif = [.8 .8 .8];
   yyaxis left
      stairs(ts,emf1,'b--','LineWidth',lw);
      stairs(ts,emf0,'b-.','LineWidth',lw);
      ylabel('abs. error (case 1) [10x]')
      yticks([-0.005 0 0.005])
      ylim([-0.01 0.01])
   yyaxis right
      stairs(ts,emf2,'r:','LineWidth',lw);
      ylabel('abs. error (case 2)')
      yticks([-0.1 0 0.1])
   xlabel('iteration ($k$)');
   xticks(0:50:ts(end)+1)
   grid on;
   
%    MagInset2(f2,gca,[85 142 0 0.1],[118 248 0.2 0.6],{'NW','SW';'NE','SE'},corMagnif,corMagnif,corMagnif);
%    set(gca,'YTick',[],'XTick',[])
%    ax=gca;
%    axesHandlesToAllLines = findobj(f2, 'Type', 'line')
 ha=get(f2,'children');
 % set(ha(2),'position',[0.05 .35 .9 .6])
 % set(ha(1),'position',[0.05 .1 .9 .2])
 for i=1:2, ha(i).GridAlpha = 0.2; end

   % rangeY=[0.96 1.001];

 %%
%  hideToolbar()

%% Salva Figuras (para tex)

figure(f2)
cleanfigure;
matlab2tikz('../../Figs/Cap5/ex51_resp_temporal_mf.tex','interpretTickLabelsAsTex', ...
   true,'height','6cm','width','15cm')


%%
