function dispResults(Res,obj,Link,pos)
%DISPRESULTS prints the Results of a struct


if pos==1
    fprintf('Start of Link\n')
elseif pos==length(Res(1).Mb1)
    fprintf('End of Link\n')
else
    fprintf('Position at x=%i*l(i)\n',pos-1)
end


if Link==0    
    if obj==1 % truss
        fprintf('\tLink \tM \t\tarea \tmass \tB \t\tH \t\ttb \t\th\n')
        for k=1:length(Res)
            fprintf('\t%i \t\t%0.1f \t%0.1f \t%0.3f \t%0.1f \t%0.1f \t%0.1f \t%0.1f\n',...
                k,Res(k).Mb1(pos),Res(k).area(pos),Res(k).m,Res(k).B(pos),Res(k).H(pos),Res(k).tb(pos),Res(k).th(pos))
        end
    else % tube
        fprintf('\tLink \tM \t\t\tarea \tmass \tR \t\tt\n')
        for k=1:length(Res)
            fprintf('\t%i \t\t%0.1f \t%0.1f \t%0.3f \t%0.1f \t%0.1f\n',...
                k,Res(k).Mb1(pos),Res(k).area(pos),Res(k).m,Res(k).R(pos),Res(k).t(pos))
        end
    end
else
    if obj==1 % truss
        fprintf('\tLink \tM \t\tarea \tmass \tB \t\tH \t\ttb \t\th\n')
        k=Link;
        fprintf('\t%i \t\t%0.1f \t%0.1f \t%0.3f \t%0.1f \t%0.1f \t%0.1f \t%0.1f\n',...
            k,Res(k).Mb1(pos),Res(k).area(pos),Res(k).m,Res(k).B(pos),Res(k).H(pos),Res(k).tb(pos),Res(k).th(pos))
    else % tube
        fprintf('\tLink \tM \t\t\tarea \tmass \tR \t\tt\n')
        k=Link;
        fprintf('\t%i \t\t%0.1f \t%0.1f \t%0.3f \t%0.1f \t%0.1f\n',...
            k,Res(k).Mb1(pos),Res(k).area(pos),Res(k).m,Res(k).R(pos),Res(k).t(pos))
    end
    
end
