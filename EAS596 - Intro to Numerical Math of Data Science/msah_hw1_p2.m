 
format long
clc
clear

x = pi/ 3 
h = logspace(-16 ,  -1 )
n = length(h)


for q = 1 : n  
    functionF(q) = ( sin(x + h(q)) - sin(x)) / h(q) ;
    O(q) = abs(cos(x) -  functionF(q));
    
end

loglog(h , O)
