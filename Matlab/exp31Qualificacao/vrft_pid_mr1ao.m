function theta = vrft_pid_mr1ao(tau,h,d,u,y)
% Cria dados virtuais do "jeito antigo", baseado em C(z)*etil = Phi*ytil

Ts = h*d;
a = exp(-1/tau*Ts);
s = tf('s');

ud = u(1:d:end);
yd = y(1:d:end);
nu = length(ud);
% t1 = length(ud);

phi = zeros(nu,3);
% Função transferencia em malha fechada (Sensibilidade Complementar)
% desejada (1a ordem):
% Tz = tf(1-a,[1 -a],Ts)


% Construindo a matriz de regressores (vide anotacao):
td = 1;
for k = 2:nu-1
    phi(k,1) = (yd(k+1)-y(k))/(1-a);
    phi(k,2) = (yd(k+1))/(1-a);
    phi(k,3) = (yd(k+1)-2*yd(k)+yd(k-1))/(1-a);
end 
phi = phi(2:nu-1,:);
ud  = ud(2+1-td:nu-td);
% Identificando parâmetros usando MQ:

theta = phi\ud;
% figure(10);
    % clf;
    % ubar = phi*theta;
    % residuo = ubar-ud;
    % plot(residuo);
    % title('Residuo');
    
% theta = pinv(phi)*ud(2:end)
% theta = inv(phi.'*phi)*phi.'*ud(2:end);
% theta = (phi.'*phi)\phi.'*ud(2:end);

end
