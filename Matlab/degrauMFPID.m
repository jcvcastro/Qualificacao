function ymf = degrauMFPID(G,Kpid,t);
   z = tf('z',G.Ts);
   Kp = Kpid(1); Ki = Kpid(2); Kd = Kpid(3);
   Gc = Kp + Ki*z/(z-1) + Kd*(z-1)/z;
   Gmf = feedback(G*Gc,1);
   ymf = step(Gmf,t);

end

