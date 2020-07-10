T=1;
delta=1/512;
t=(0:delta:T);
t=t(1:(1/delta));
f_max=125;
f_min=100;
up=cos((2*pi*t).*((((f_max-f_min)/T)*t)+f_min));
dow=cos((2*pi*t).*((((f_min-f_max)/T)*t)+f_max));
%plot(t,up)
b=randi([0 1],1,4);
for i=1:1:4
if(b(i)==0)
    b(i)=-1;
end
end
c=upsample(b,(uint32(T/delta)));
%plot(c)
signal=0;
for i=1:4*(T/delta)
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
signal=signal(2:4*(T/delta)+1);
t_1=(0:delta:4*T);
t_1=t_1(1:4*(T/delta));
%plot(t_1,signal)
up_signal=[up up up up];
%plot(t_1,up_signal)
out=signal.*up_signal;
%plot(t_1,out)
new_out=out*delta;
demod=0;
new_out=[new_out 0];
k=T/delta;
%new_out=new_out(1:2048);
demod=cumsum(new_out(1:k+1));
demod=[demod cumsum(new_out(k+2:2*k+1))];
demod=[demod cumsum(new_out(2*k+2:3*k+1))];
demod=[demod cumsum(new_out(3*k+2:4*k+1))];
%plot(demod)
%demod=demod(2:2049);
t_1=[t_1 4*T];
%plot(t_1,demod)
%threshold=((0.5)+(0.05))/2
%plot(demod)
%for n=1:4
 %   if(demod((n*k)+1)>0.2750)
  %      d(n)=1;
   % else
    %    d(n)=0;
    %end
%end

%with the noise
Ps=(norm(demod)^2)/length(demod);
E_by_N=2;
SNR=10*log10(10/(E_by_N));
Pn=Ps/SNR;
noise=wgn(1,2048,0.001);
out_noise=noise.*up_signal;
out_noise=[out_noise 0];
demod_noise=cumsum(out_noise(1:k+1));
demod_noise=[demod_noise cumsum(out_noise(k+2:2*k+1))];
demod_noise=[demod_noise cumsum(out_noise(2*k+2:3*k+1))];
demod_noise=[demod_noise cumsum(out_noise(3*k+2:4*k+1))];
P=(norm(demod_noise)^2)/length(demod_noise)
fin_noise=(demod_noise)*(sqrt(Pn)/sqrt(P));
%fin_noise/100;
%plot(fin_noise)
f_output=demod+fin_noise;
plot(t_1,f_output);
for n=1:4
    if(f_output((n*k)+1)>0.2750)
        d(n)=1;
    else
        d(n)=0;
    end
end





  