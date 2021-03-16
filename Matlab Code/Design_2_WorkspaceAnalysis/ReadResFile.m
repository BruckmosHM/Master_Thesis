% Reads the contents of a Res File (Resulution File from AutoCalculationFKL
% clear;
% clc;

% load('ResDesign1')

stbl = Res(:,1);
posStbl = find(stbl==1);
nStbl = length(posStbl);

if (nStbl ~= 0)
    StblRes = zeros(nStbl,15);
    for i=1:nStbl 
        StblRes(i,:) = Res(posStbl(i),:);
    end
    
    fprintf('%i suitable configurations found.\n\n',nStbl)
    
    [LMin,IL] = min(StblRes(:,2));
    fprintf('Minimal Length at i=%i  with    L = %.1f mm\n',IL,LMin)
    IL = find(StblRes(:,2)==LMin);
    
    
    [YMax,IYMax] = min(abs(StblRes(:,3)));
    fprintf('Minimal YMax   at i=%i with yMax = %.2f mm\n',IYMax,YMax)
    
    printRes(StblRes,[IL; IYMax]);
 
else
    fprintf('No suitable configurations found.');
end

function printRes(Res,I)
    
    fprintf('\nPos \tSuitable \t\tL \tyMax \tyMin \td1 \td2 \t\td3 \t\t d4 \t d5 \t r3\n');
    fprintf(['----------------------------------------------------',...
        '---------------------------------\n']);
    
    for k=1:length(I)
        i = I(k);    

        if Res(i,1)==1
            stbl = 'Yes';
        else
            stbl = 'No';
        end

        fprintf(['%i\t\t\t',stbl,'\t\t%.1f \t%.1f \t%.1f \t%.0f \t%.0f \t%.0f \t%.0f \t%.0f \t%.0f\n'],...
            i,Res(i,2),Res(i,3),Res(i,4),Res(i,5:9),Res(i,10)); 
    end
    fprintf('\n');

end
