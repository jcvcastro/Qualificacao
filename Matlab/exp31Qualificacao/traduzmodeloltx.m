function finalstr=traduzmodeloltx(model,x,y,u,e,k)
    [m,n] = size(model);
    finalstr = '';
    str = cell(m,1);
    for i=1:m
        for j=1:n
            ind = floor(model(i,j)/1000);
            if (ind == 1)
                str{i} = strcat( str{i}, [y '_{' k '-' num2str(model(i,j)-ind*1000) '}']);
            elseif (ind == 2)
                str{i} = strcat( str{i}, [u '_{' k '-' num2str(model(i,j)-ind*1000) '}']);
            elseif (ind == 3)
                str{i} = strcat( str{i}, [e '_{' k '-' num2str(model(i,j)-ind*1000) '}']);
            end
        end
    end
        % termosltx(model,str,y,u,e,k);
    for i=1:m
        if (x(i)<0)
            signal = ' - ';
            x(i) = abs(x(i));
        elseif (i==1)
            signal = ' ';
        else
            signal = ' + ';
        end
        finalstr = strcat(finalstr, [signal num2str(x(i)) str{i}]);
    end
    finalstr = strcat([y '_' k ' = '], finalstr);
end

