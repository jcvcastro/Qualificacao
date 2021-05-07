function finalstr=traduzmodelo(model,x,y,u,e,k,N)
    [m,n] = size(model);
    finalstr = '';
    var = '';
    str = cell(m,1);
    for i=1:m
        for j=1:n
            ind = floor(model(i,j)/1000);
            if (ind == 1)
                var = y;
            elseif (ind == 2)
                var = u;
            elseif (ind == 3)
                var = e;
            end
            str{i} = strcat( str{i}, ['*' var '(' k '-' num2str(model(i,j)-ind*1000) ')']);
        end
    end
    for i=1:m
        if (x(i)<0)
            signal = ' - ';
            x(i) = abs(x(i));
        elseif (i==1)
            signal = ' ';
        else
            signal = ' + ';
        end
        finalstr = strcat(finalstr, [signal num2str(x(i),N) str{i}]);
    end
    finalstr = strcat([y '(' k ') = '], finalstr);
end

