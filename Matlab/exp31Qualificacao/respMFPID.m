
function ymf = respMFPID(r,G,Kpid);
   z = tf('z',G.Ts);
   Kp = Kpid(1); Ki = Kpid(2); Kd = Kpid(3);
   Gc = Kp + Ki*z/(z-1) + Kd*(z-1)/z;
   Gmf = feedback(G*Gc,1);
   ymf = dlsim(Gmf.num{1},Gmf.den{1},r);

end
