clear
clc
x=pi/3;
y=@(x)sin(x);
dy=cos(x);
h=logspace(-1,-16);
n=length(h); 
 
for i=1:n
    
    f1(i)=(y(x+h(i))-y(x))/h(i);
    f3(i) = abs(dy - f1); 
 
end 

       loglog(h(i),f3);
