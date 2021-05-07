function y = sis_mf(r,model_sis,rho,y0,model_cont,theta)
  n = length(r);
  y = zeros(n,1);
  y(1:length(y0)) = y0;
  e = zeros(n,1);
  u = zeros(n,1);

  [npr,nno,lag_sis,nny,nnu,nne,newmodel_sis] = get_info(model_sis);
  [npr,nno,lag_cont,nny,nnu,nne,newmodel_cont] = get_info(model_cont);
  maxlag = max(lag_sis,lag_cont);

  % for i=(maxlag+1):n
    % ii = i-maxlag;
    % y(i-maxlag:i)=simodeld(model_sis,rho,u(i-maxlag:i),y(i-maxlag:i-1));
    % e(ii:i) = r(ii:i) - y(ii:i);
    % u(ii:i) = simodeld(model_cont,theta,e(i-maxlag:i),u(i-maxlag:i-1));
  % end
  
  for i=(maxlag+1):n
      ilag_cont = i-lag_cont;
      ilag_sis =  i-lag_sis;
      y(ilag_sis:i)=simodeld(model_sis,rho,u(ilag_sis:i),y(ilag_sis:i-1));
      e(ilag_cont:i) = r(ilag_cont:i) - y(ilag_cont:i);
      u(ilag_cont:i) = simodeld(model_cont,theta,e(ilag_cont:i),u(ilag_cont:i-1));
  end
end
