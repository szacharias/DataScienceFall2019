
h=logspace(-16,-1);
x=pi/3;
fun = @(x)sin(x);
derivative= @(x)cos(x);
n = length(h);
for i=1:n
    df(i) = (fun(h(i)+x)-fun(x))/h(i);
    Error(i) = abs(derivative(x)-df(i)); 
end

loglog(h , Error)
