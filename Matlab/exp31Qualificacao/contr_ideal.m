%%
% clear
    
syms a1 a2 b1 b2 c1 c2 d1 d2 z A

G = (b1*z + b2)/(z^2-a1*z-a2)
M = (1-A)/(z-A)

C = M/G/(1-M)
C = simplify(C)
C = collect(C,z)
pretty(C)
%% Numerico
clear
a1 = -1.7; a2 = -0.8;
b1 = 1; b2 = 0.81;

Ts = 1;
tau = 5;
A = exp(-Ts/tau);

z = tf('z',Ts);

G = (b1*z + b2)/(z^2-a1*z-a2)
M = (1-A)/(z-A)

C = M/G/(1-M)
C = minreal(C)
%%
%
%% PID
syms Kp Ki Kd z
C = Kp + Ki*z/(z-1)  + Kd*(z-1)/z
C = collect(C,z)
pretty(C)
