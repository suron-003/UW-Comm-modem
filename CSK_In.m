T=1;
delta=1/512;
t=(0:delta:T);
t=t(1:(1/delta));
f_max=125;
f_min=100;
BER=[0 0 0 0 0 0];
E_by_N=[0 2 4 6 8 10];
up=cos((2*pi*t).*((((f_max-f_min)/T)*t)+f_min));
dow=cos((2*pi*t).*((((f_min-f_max)/T)*t)+f_max));
for m=1:6
    count=0;
    for l=1:500
        b=randi([0 1],1,512);
        for i=1:1:512
if(b(i)==0)
    b(i)=-1;
end
        end
        c=upsample(b,(uint32(T/delta)));
        signal=0;
        for i=1:512*(T/delta)
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
        signal=signal(2:512*(T/delta)+1);
        t_1=(0:delta:512*T); 
        t_1=t_1(1:512*(T/delta));
        up_signal=0;
        for i=1:512
    up_signal=[up_signal up];
        end
        up_signal=up_signal(2:262145);
        out=signal.*up_signal;
        new_out=out*delta;
        demod=0;
        new_out=[new_out 0];
        k=T/delta;
        demod=cumsum(new_out(1:k+1));
        for n=1:511
    demod=[demod cumsum(new_out(n*k+2:(n+1)*k+1))];
        end
        t_1=[t_1 512*T];
        %with the noise
        Ps=(norm(demod)^2)/length(demod);
        SNR=10*log10(10/(E_by_N(m)));
        Pn=Ps/SNR;
        noise=wgn(1,262144,0.001);
        out_noise=noise.*up_signal;
        out_noise=[out_noise 0];
        demod_noise=cumsum(out_noise(1:k+1));
        for n=1:511
    demod_noise=[demod_noise cumsum(out_noise(n*k+2:(n+1)*k+1))];
        end
        P=(norm(demod_noise)^2)/length(demod_noise);
        fin_noise=(demod_noise)*(sqrt(Pn)/sqrt(P));
        f_output=demod+fin_noise;
        for n=1:512
    if(f_output((n*k)+1)>0.2750)
        d(n)=1;
    else
        d(n)=0;
    end
        end
        for i=1:512
            if(b(i)~=d(i))
                count=count+1;
            end
        end
    end
    BER(m)=(count/(500*512));
end
%semilogx(BER,E_by_N)
for p=1:6
    BER_act(i)=sqrt(2)*10*log10(10/(E_by_N(i)))
end
semilogx(BER_act,E_by_N)

