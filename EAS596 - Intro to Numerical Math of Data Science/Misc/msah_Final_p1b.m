
t0 = 0;
t_answer = 1;
t_span = [t0, t_answer];

y0 = 0;


[t_solution , y_solution ] = ode45( @(t,y) msah_Final_p1a(t, y) , t_span , y0);


%plot(t_solution, y_solution)