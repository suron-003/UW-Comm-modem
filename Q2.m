t=(-100:0.01:100);

a=0.35;
T=5;
p=1/T;
if(t==0)
    f=1-a+(4*a)/3.14
else
    if(t==(T/(4*a))|(t==(-T/(4*a))))
        f=((a/sqrt(2))*(1+2/3.14)*sin(3.14/(4*a)))+((1-(2/3.14))*cos(3.14/(4*a)))
    else
       f=((sin(3.14*(1-a)*p*t))+ (4*a*p*t.*cos(3.14*(1+a)*p*t)))./(3.14*p*t.*(1-(4*a*p*t).^2))
    end
end
y=conv(f,f)
t=linspace(-100,0.01,length(y))

plot(t,y)
%doubtful