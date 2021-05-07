function y = sis_mf(r,model_sis,rho,model_cont,theta)
  n = length(r);

  y = zeros(n,1);
  e = zeros(n,1);
  u = zeros(n,1);

  [npr,nno,lag_sis,nny,nnu,nne,newmodel_sis] = get_info(model_sis);
  [npr,nno,lag_cont,nny,nnu,nne,newmodel_cont] = get_info(model_cont);
  lag = max(lag_sis,lag_cont);

  % for i=(lag+1):n
    % ii = i-lag;
    % y(i-lag:i)=simodeld(model_sis,rho,u(i-lag:i),y(i-lag:i-1));
    % e(ii:i) = r(ii:i) - y(ii:i);
    % u(ii:i) = simodeld(model_cont,theta,e(i-lag:i),u(i-lag:i-1));
  % end
  
  for i=(lag+1):n
      ilag = i-lag;
      if i>250
          u(i) = u(i)+0.2;
      end
      y(ilag:i)=simodeld(model_sis,rho,u(ilag:i),y(ilag:i-1));
      e(ilag:i) = r(ilag:i) - y(ilag:i);
      u(ilag:i) = simodeld(model_cont,theta,e(ilag:i),u(ilag:i-1));
      
  end
end
