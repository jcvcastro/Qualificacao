%
cor1 = [0  0  0];
cor2 = [0  0  1];
cor3 = [1 0.5 0];
cor4 = [0  5 0];
cores = [cor1; cor2; cor3; cor4];
% colormap(mycolors);
% set(0,'DefaultFigureColormap',feval('parula'));
col = lines(5); 
%
%% Padroes para Figuras
% close all
set(0,'defaultfigurecolor', [1 1 1]);
% set(0, 'DefaultLineLineWidth', 1.5);
set(0,'defaulttextinterpreter','latex')
% set(f1,'TickLabelInterpreter', 'tex');

%% Dados
ts   = SD1{1}.Values.Time;
yr   = SD1{1}.Values.Data;
ymf1 = SD1{2}.Values.Data;
ymf2 = SD1{3}.Values.Data;
ymf3 = SD1{4}.Values.Data;
ymf4 = SD1{5}.Values.Data;
emf1 = SD2{1}.Values.Data(:,1);
emf2 = SD2{1}.Values.Data(:,2);
emf3 = SD2{1}.Values.Data(:,3);
emf4 = SD2{1}.Values.Data(:,4);

%% Fig1 - Training data

f1=figure(4); clf;
subplot(4,1,1)
   stairs(t,u,'LineWidth',1)
   set(gca,'box','off','Xticklabel',[],'YTick',[-2 -1 0 1])
   grid on;
   ylabel('$\tilde{u}$')
   ylim([-1.2 1.2])
   % ylabel('$$\tilde{u}$')
subplot(4,1,2)
   stairs(t,y,'LineWidth',1)
   set(gca,'box','off','Xticklabel',[],'YTick',[-2 -1 0 1])
   grid on;
   ylabel('$\tilde{y}$')
   ylim([-2 1.2])
   % ylabel('$$\tilde{y}$')
subplot(4,1,3)
set(gca)
   stairs(t,rv,'LineWidth',1)
   set(gca,'box','off','Xticklabel',[],'YTick',[-10   0  10])
   grid on;
   ylabel('$\tilde{r}$')
   ylim([-12 14])
subplot(4,1,4)
   stairs(t,ev,'LineWidth',1)
   set(gca,'box','off','Xticklabel',[0:10:60],'YTick',[-10   0  10]);
   grid on;
   ylabel('$\tilde{e}$')
   xlabel('iteration ($k$)');
   ylim([-12 14])
 ha=get(gcf,'children');
 set(ha(4),'position',[.1 .76 .9 .2])
 set(ha(3),'position',[.1 .54 .9 .2])
 set(ha(2),'position',[.1 .32 .9 .2])
 set(ha(1),'position',[.1 .1 .9 .2])
 for i=1:4, ha(i).GridAlpha = 0.2; end
 %%

%% Fig2 - Resposta temporal y
    
f2=figure(2); clf;
subplot(2,1,1)
   hold on;
   ax=gca;
   ax.ColorOrder = cores;
   plot(ts,yr,':','LineWidth',1);
   stairs(ts,ymf1,'LineWidth',1);
   stairs(ts,ymf2,'--','LineWidth',1);
   stairs(ts,ymf3,'-.','LineWidth',1);
   stairs(ts,ymf4,':','Color','magenta','LineWidth',1);
   % set(gca,'Xticklabel',[])
   ylabel('output')
   % p32=stairs(ts,ymf1,'b','LineWidth',1);
   % p32=stairs(ts,ymf2,'--m','LineWidth',1);
   % p32=stairs(ts,ymf3,'-.r','LineWidth',1);
   % p31=plot(ts,yr,'k','LineWidth',0.5);
   ylim([-1.5 1.5])
   %
   % MagInset(f2,ax,[26.209677 51.555300 -1.001 -0.999],[25 100 -1.451895 -1.137026],{'NW','NW';'NE','NE'});
   % set(gca,'YTick',[],'XTick',[])
   %
   MagInset2(f2,ax,[74 102 0.95 1.1],[110 150 0 1.5],{'NE','NW';'SE','SW'},corMagnif,corMagnif,corMagnif);
   set(gca,'YTick',[],'XTick',[])
   rangeY=[0.96 1.001];

   MagInset2(f2,ax,[170 200 rangeY],[175 250 -1.25 0.3],{'SW','NW';'SE','NE'},corMagnif,corMagnif,corMagnif);
   set(gca,'YTick',[rangeY],'XTick',[])
   set(ax,'colororder',col)
   % set(ax,'Visible','off')
   %
subplot(2,1,2)
   hold on;
   ax=gca;
   ax.ColorOrder = cores(2:end,:);
   corMagnif = [.8 .8 .8];
   stairs(ts,emf1,'LineWidth',1);
   stairs(ts,emf2,'--','LineWidth',1);
   stairs(ts,emf3,'-.','LineWidth',1);
   stairs(ts,emf4,':','Color','magenta','LineWidth',1);
   ylabel('abs. error')
   xlabel('iteration ($k$)');
   MagInset2(f2,gca,[85 142 0 0.1],[118 248 0.2 0.6],{'NW','SW';'NE','SE'},corMagnif,corMagnif,corMagnif);
   set(gca,'YTick',[],'XTick',[])
   ax=gca;
   % ax.XColor = corMagnif; ax.YColor = corMagnif;
   axesHandlesToAllLines = findobj(f2, 'Type', 'line')
% axesHandlesToAllLines.Color(1) = corMagnif
%%

% %% Fig6
% figure(6)
% subplot(2,1,1)
% f6=figure(6); clf;
%
% ax = gca;
% MagInset(f2,ax,[26.209677 51.555300 -1.001 -0.999],[25 100 -1.451895 -1.137026],{'NW','NW';'NE','NE'});
% set(gca,'YTick',[],'XTick',[])
% MagInset(f1,ax,[74 102 0.95 1.1],[110 150 0 1.5],{'NE','NW';'SE','SW'});
% set(gca,'YTick',[],'XTick',[])
% rangeY=[0.97 1.001];
% MagInset(f1,ax,[170 200 rangeY],[175 250 -1.25 0.3],{'SW','NW';'SE','NE'});
% set(gca,'YTick',[rangeY],'XTick',[])
% set(ax,'colororder',col)
% % set(ax,'Visible','off')



%



%% Salva Figuras (para tex)
% %%
% figure(f1)
% cleanfigure;
% matlab2tikz('./figs/exp31_train_data4.tex','interpretTickLabelsAsTex',true,'height','6cm','width','.9\textwidth')
% %
figure(f2)
cleanfigure;
matlab2tikz('./figs/exp31_time_response_new.tex','interpretTickLabelsAsTex',true,'height','6cm','width','.9\textwidth')
% % %
%
%
%
%
%% Figuras antigas
%
% f1=figure(1); clf;
% % set(f2,'TickLabelInterpreter', 'tex');
   % hold on
   % stairs(t,y,'b', 'LineWidth',1)
   % ylabel('$\tilde{y}$')
   % stairs(t,u,'k--','LineWidth',1)
   % ylabel('amplitude')
   % xlabel('iteration ($k$)');
   % ylim([-2 1.4])
%
% f2=figure(2); clf;
% % set(f2,'TickLabelInterpreter', 'tex');
% subplot(2,1,1)
   % stairs(t,y,'LineWidth',1)
   % ylabel('$\tilde{y}$')
   % ylim([-2 1.2])
% subplot(2,1,2)
   % stairs(t,u,'LineWidth',1)
   % ylabel('$\tilde{u}$')
   % xlabel('iteration ($k$)');
   % ylim([-1.2 1.2])
    %
