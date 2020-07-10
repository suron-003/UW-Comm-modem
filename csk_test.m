T=1;
delta=1/512;
t=(0:delta:T-delta);
b=randi([0 1],1,4);
t_1=(0:delta:((length(b))*T)-delta)
delta=1/512;
f_max=124;
f_min=25;
t=(0:delta:T-delta);
up=cos((2*pi*t).*((((f_max-f_min)/T)*t)+f_min));
down=cos((2*pi*t).*((((f_min-f_max)/T)*t)+f_max));
%c=upsample(b,(uint32(T/delta)));
signal=0;
for i=1:length(b)
    if(b(i)==1)
        signal=[signal up];
    else
        signal=[signal down];
    end
end
a=length(signal);
signal=signal(2:a);
plot(t_1,signal)