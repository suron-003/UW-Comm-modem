clear all
syms t

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
x = randi([0 1],512,1)
b=[1 0 0 1]
%have to interpolate and generate NRZ pulse of appropriate time period,
%then apply SRRC pulse shaping whenever there is a change in value of the
%NRZ pulse
signal=0 
for i=1:size(b,2)
    if(b(i)==1)
        signal=[signal (1*f)]
    elseif(b(i)==0)
        signal=[signal (-1*f)]
    end
end
k=linspace(0,T,length(signal))
plot(k,signal)
