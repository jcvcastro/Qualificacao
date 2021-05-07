%% Analise usando ERR
% Caso do exemplo 5.1?
% Sistema Linear de 2a ordem

clear
close all
%%
% carrega os dados
train_data=csvread('s.2ndOrdLinSystem.VRFTtraindata_wn.csv',1,1);
% train_data=csvread('./s.2ndOrdLinSystem.VRFTtraindata_sqr_rnd.csv',1,1);
k=train_data(:,1);
e=train_data(:,3); % erro de acionamento (entrada)
m=train_data(:,2); % acao de controle (saida)
%%
figure(2); clf;
subplot(2,1,1)
plot(1:length(e),e);
ylabel('e')
subplot(2,1,2)
plot(1:length(m),m);
ylabel('m')
xlabel('k')

%%
% veriuficacao do tempo de amostragem

mvt_ts(m)

%%
% toleravel. Mas a entrada poderia ser um pouco mais lenta.
% alguma nao linearidade eh visivel... 

% Calculo da FAC
[t,r,l]=myccf([m e],40,1,0,'k');
figure; clf;
stem(t,r,'k');
hold on
plot([t(1) t(end)],[l l],'k',[t(1) t(end)],[-l -l],'k');
hold off

% temos problemas de causalidade. Note que ha correlacoes para
% atrasos negativos. Acredito que isto seja resultado da
% realimentacao (?? verificar). Farei um ajuste de 2 amostras,
% mas note que ainda haverah um bocado de correlacao do lado esquerdo...
%% identificacao
% os dados de identificacao serao de 100 a 700
% COM remocao dos niveis medios
% vou atrasar o sinal de saida em relacao ao de entrada por 2 amostras,
% na mao...
n=length(m);
ni=floor(0.1*n);
nt=floor(0.7*n);
nv=n;

% Adiantando a entrada
atrs = 0;
% Treinamento:
ei=e(ni:nt);
mi=m(ni:nt);
ei=ei(1+atrs:end);
mi=mi(1:end-atrs);
ei=ei-mean(ei);
mi=mi-mean(mi);
% Validacao:
ev=e(nt+1:nv);
mv=m(nt+1:nv);
ev=ev(1+atrs:end);
mv=mv(1:end-atrs);
ev=ev-mean(ev);
mv=mv-mean(mv);


%% Exportando dados
% dados_i = [ei mi];
% dados_v = [ev mv];
% save  dados_analise_ERR_input.dat dados_i -ascii;
% save  dados_analise_ERR_input.dat dados_v -ascii;
%%
% definicao de metaparametros
DG=2; % grau de nao linearidade
ny=4; % maximo atraso em m
nu=4; % maximo atraso em e

% sem termos de ruido => modelo NARX
[Cand,tot2]=genterms2(DG,ny,nu);

mape=[];
for np=2:8
  [model,x,E,va]=orthreg(Cand(2:end,:),ei,mi,[np 0],0); 
  [npr,nno,lag,nny,nnu,nne,newmodel] = get_info(model);

  % Plot free-run simulation
  % ym=simodeld(model,x(:,1),ev,mv(1:lag));
  modelo{np}=newmodel;
  % figure; clf;
  % plot(1:length(ym),ym,1:length(mv),mv,'k');
  % um(:,np) = ym;

  % mean absolute percentual error
  % mape(np)=(sum(abs(mv-ym))/(std(mv)*length(mv)))*100;
end
q_ls = x(:,1);

% dados_val = [ym mv];
% save  dados_analise2_aguirre_validacao.dat dados_val -ascii;
mape_arx=mape;
% table(mape',x(:,1),'VariableNames',{'MAPE','Coeff'})
tabela=[model x(:,1)]
table(model,x(:,1),'VariableNames',{'Model','Coeff'})
hideToolbar;

model_cont = model;
%%

% model_cont_ideal = [1001 1002 2000 2001 2002]';
% model_cont = model_cont_ideal
% model_cont = model
% Phi2 = [mi(2:end-1) mi(1:end-2) ei(3:end) ei(2:end-1) ei(1:end-2)];
% Phi3=build_pr(model_cont,ei,mi);
% theta2 = Phi2\mi(3:end)
% theta3 = Phi3(3:end,:)\mi(3:end)

%% Fechado a malha

rho = [-1.7; -0.8; 1; 0.81];
model_sis = [1001; 1002; 2001; 2002];
model_cont0 = model_cont;
theta0 = x(:,1);

% theta_ideal = [0.181 0.308  0.145  0.19 0.81]';
% model_cont_ideal = [2000 2001 2002 1001 1002]';
% theta0 = theta_ideal;
% model_cont0=model_cont_ideal;


Ts = 1;
tau = 5;
d=1
a = exp(-Ts/tau);
ns=length(ev);
ts = 0:Ts:(ns-1)*Ts;
r = square(2*pi*1/60*ts);
r = [zeros(1,10) r(1:end-10)]';

yr = MR1aO(r,a,d,1);
yr=yr';
y0=[0; 0];
ymf0 = sis_mf(r,model_sis,rho,y0,model_cont0,theta0);

figure; clf;
hold on;
stairs(ts,r)
stairs(ts,yr)
stairs(ts,ymf0)


%% Outra forma:
% %
% % So para modelo linear
%
% % Modelo Ideal para teste:
% % theta0 = [0.181 0.308  0.145  0.19 0.81]';
% % model_cont0 = [2000 2001 2002 1001 1002]';
%
% % Por enquanto o regressor deve estar formatado:
% [model_cont1 idx]=sort(model_cont0);
% theta1=theta0(idx(:,1),1);
%
% % theta1=theta_ideal(idx(:,1),1);
% % [model_cont1 idx]=sort(model_cont_ideal);
%
% G= tf(rho(3:4)',[1 -rho(1:2)'],1);
% n_num=0; n_den=0;
% idxnum=[]; idxden=[];
% for(i=1:length(model_cont1(:,1)))
%   mCi=model_cont1(i,1);
%   if((mCi>=1000)&&(mCi<2000))
%     idxden=[idxden rem(mCi,1000)];
%     n_den=n_den+1;
%   elseif ((mCi>=2000)&&(mCi<3000))
%     idxnum=[idxnum rem(mCi,2000)];
%     n_num=n_num+1;
%   end
% end
% num=[]; den=[];
%
% num(idxnum+1)=theta1(n_den+1:n_den+n_num);
% den(idxden)=theta1(1:n_den);
% den = [1 -den];
%
% C1= tf(num,den,Ts)
%
% sim('simulacao_sis2aord.slx')
%
%% 

