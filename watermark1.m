%load('E:\Activities\in progress\UWcomm\Watermark\Watermark\input\signals\input_signal.mat')
cd 'E:\Activities\in progress\UWcomm\Watermark\Watermark\matlab';
watermark('input_signal','NOF1','single');
[rec,fs]=sfetch('input_signal','NOF1',7);
rec=rec(1:2048);
t_1=(0:delta:(nBits*T)-delta);
%receiver side downconversion
rec=rec.';
rec=rec./cos(2*pi*f_c*t_1);
noise = wgn(1,length(signal),0.1);
%plot(t_1,signal);

%parameters
delta=1/512;
fs_x=512;
nBits=4;
T=1;
f_min=100;
f_max=125;
SNR=20;

%Receiver side
%band pass filter
%The parameters of the filter like shape of response etc can be changed.
%But, here we use the default.

filsout=bandpass(rec,[100 125],1/delta);
filnout=bandpass(noise,[100 125],1/delta);
%plot(t_1,filout)

%Matched filter

y=(-(T-delta):delta:0);
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


