T=1/300
t=(0:T/1000:T)
delta=T/1000
t=t(1:1000)
f_max=40000
f_min=30000
up=cos((2*pi*t).*(((f_max-f_min)/T)*t+f_min))
dow=cos((2*pi*t).*(((f_min-f_max)/T)*t+f_max))
%plot(t,up)
b=randi([0 1],1,4)


for i=1:1:4
if(b(i)==0)
    b(i)=-1;
end
end
c=upsample(b,(uint32(T/delta)))
plot(c)
signal=0
for i=1:4000
    if(c(i)==1)
        signal=[signal up];
        
    else 
        if(c(i)==-1)
            signal=[signal dow];
    else
            continue
        end
    end
end
signal=signal(2:4001);
t_1=(0:T/1000:4*T);
t_1=t_1(1:4000);
plot(t_1,signal)
up_signal=[up up up up]
%plot(t_1,up_signal)
out=signal.*up_signal

%for j=1:3
 %   for i=(j-1)*1000:(j*1000)+1