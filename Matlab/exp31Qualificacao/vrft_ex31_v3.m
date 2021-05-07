function theta = vrft_ex31_v3(tau,h,u,y)
% Cria dados virtuais usando regressores baseados no erro virtual
Ts = h;
a = exp(-1/tau*Ts);

nu = length(u);
ev = zeros(nu,1);
rv = zeros(nu,1);


phi = zeros(nu,4);
% Função transferencia em malha fechada (Sensibilidade Complementar)
% desejada (1a ordem):
% Tz = tf(1-a,[1 -a],Ts)

% Calculando erro virtual para MR de 1a ordem
for k = 1:nu-1
   rv(k) = (y(k+1) - a*y(k))/(1-a);
   ev(k) = rv(k) - y(k);
end
% Construindo a matriz de regressores 
% td = 1;
for k = 3:nu-1
    phi(k,1) = ev(k);
    phi(k,2) = ev(k-1);
    phi(k,3) = ev(k-2);
    phi(k,4) = u(k-1);
end 
phi2 = phi(3:nu-1,:);
u2  = u(3:nu-1);
% Identificando parâmetros usando MQ:

theta = phi2\u2;


end
