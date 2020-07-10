%Parameters
delta=1/8000;
nBits=8;
%SNR=[2 4 6 8 10 12];
SNR=8;
T=1;
f_min=1000;
f_max=2000;
f_c=14000;
t=(0:delta:T-delta);
up=cos((2*pi*t).*((((f_max-f_min)/T)*t)+f_min));
down=cos((2*pi*t).*((((f_min-f_max)/T)*t)+f_max));
%BER=[0 0 0 0 0 0];

%Start of loop
%Generating input sequence
%PN=[1 0 1 0 1 1 1 0 1 1 0 0 0 1 1 1 1 1 0 0 1 1 0 1 0 0 1 0 0 0 0 1]
b=randi([0 1],1,nBits)
%b=[PN b]
%nBits=nBits+32;
%b=[0 0 1 0]
%for j=1:6
signal=0;
for i=1:nBits
    if(b(i)==1)
        signal=[signal up];
    else
        signal=[signal down];
    end
end
a=length(signal);
signal=signal(2:a);
t_1=(0:delta:nBits*T-delta);
%noise = wgn(1,length(signal),0.1);
%plot(signal)
%plot(abs(fft(up)))
soundsc(signal,8000)
%plot(t_1,signal);
%{
%Receiver side
%band pass filter
%The parameters of the filter like shape of response etc can be changed.
%But, here we use the default.

filsout=bandpass(signal,[100 125],1/delta);
filnout=bandpass(noise,[100 125],1/delta);
%plot(t_1,filout)

%Matched filter

y=(-(T-delta:delta:0);
up=cos((2*pi*-y).*((((f_max-f_min)/T)*-y)+f_min));
down=cos((2*pi*-y).*((((f_min-f_max)/T)*-y)+f_max));
m_sout=conv(filsout,up);
m_nout=conv(filnout,up);

%noise re-scaling and addition
Pn=(norm(m_nout)^2)/length(m_nout);
Ps=(norm(m_sout)^2)/length(m_sout);
x=SNR;
PN=Ps/x;
mf_nout=((m_nout)*sqrt(PN))/(sqrt(Pn));
out=mf_nout+m_sout;
%plot(m_out)

%Recovering the bits
output=0;
for i=1:nBits
    if(out(i*512)>75)
        output=[output 1];
    else
        output=[output 0];
    end
end
output=output(2:nBits+1)

%Calculating the BER
count=0;
for p=1:nBits
    if(b(p)~=output(p))
        count=count+1;
    end
end
count
%BER(j)=(count/n)
%end
%plot(BER,SNR)
%}