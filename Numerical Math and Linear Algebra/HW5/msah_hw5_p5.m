x = [0 , 1 , 2,  3 , 4 , 5, 6 ];
y = [ - 0.02 , 1.1, 5.0 , 8.5 , 17.3, 26.1 , 42];

% linear
p = polyfit(x,y,1);
f=polyval(p,x);
r=corrcoef(x,y);

% quadratic
p1 = polyfit(x,y,4)
f1=polyval(p1,x)
r1=corrcoef(x,y)


plot(x,  f)
hold on
plot(x,  f1 , "-s")
hold off

