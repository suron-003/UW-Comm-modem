T=1/25000
a=0.35;
w=(1+a)/T;
delta=1/(8*w);
t=linspace(-5*T,5*T,round(10*T/delta))
p=1/T;
w=(1+a)/(T)
if(t==0)
    f=1-a+(4*a)/3.14
else
    if(t==(T/(4*a))|(t==(-T/(4*a))))
        f=((a/sqrt(2))*(1+2/3.14)*sin(3.14/(4*a)))+((1-(2/3.14))*cos(3.14/(4*a)))
    else
      f=((sin(3.14*(1-a)*p*t))+ (4*a*p*t.*cos(3.14*(1+a)*p*t)))./(3.14*p*t.*(1-(4*a*p*t).^2))
    end
end
plot(t,f);
x = randi([0 1],4,1)
for i=1:length(x)
    if(x(i)==0)
        x(i)=-1;
    else
        x(i)=1;
    end
end
x=upsample(x,round(T/delta));
y=conv(x,f);
ty=linspace(-5*T,8*T,length(y));
e_by_n=6;
SNR=-1*log(T)+(e_by_n);
g=awgn(y,SNR);
z=conv(g,f);
tz=linspace(-8*T,11*T,length(z));
subplot(2,1,1);
plot(tz,z);
subplot(2,1,2);
plot(ty,g);
O=[0 0 0 0 0 0 0 0 0 0 0 0];
for i=0:T:11*T
    if(z>=0)
        O=1
    else
        O=0
    end
end
        



