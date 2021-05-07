function [e, m] = MR1inv(u,y,a,d,gain) 
   N = length(y);

   r = zeros(N-d,1);
   e = zeros(N-d,1);
   for k = d:N-d
      r(k-d+1) = (y(k+1) - a*y(k))/(1-a)/gain;
   end
   e = r - y(1:N-d);
   m = u(1:N-d);
end
