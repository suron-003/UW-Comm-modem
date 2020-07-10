%Parameters
delta=1/512;
fs_x=512;
nBits=4;
T=1;
f_min=100;
f_max=125;
t=(0:delta:T-delta);
f_c=14000;
up=cos((2*pi*t).*((((f_max-f_min)/T)*t)+f_min));
%up=up.*cos(2*pi*f_c*t);
down=cos((2*pi*t).*((((f_min-f_max)/T)*t)+f_max));
%down=down.*cos(2*pi*f_c*t);

%Start of loop
%Generating input sequence
%b=randi([0 1],1,nBits)
b=[1 0 0 0]
%for j=1:6
signal=0;
for i=1:nBits
    if(b(i)==1)
        signal=[signal up];
    else
        signal=[signal down];
    end
end
t_1=(0:delta:(nBits*T)-delta);
a=length(signal);
signal=signal(2:a);
signal=signal.*cos(2*pi*f_c*t_1);
x=signal.';
%delete(fullfile('E:\Activities\in progress\UWcomm\Watermark\Watermark\input\signals', 'a.mat'));
%cd 'E:\Activities\in progress\UWcomm\Watermark\Watermark\input\signals';
save('E:\Activities\in progress\UWcomm\Watermark\Watermark\input\signals\input_signal.mat', 'fs_x','x','nBits');

%cd 'E:\Activities\in progress\UWcomm\Watermark\Watermark\matlab'

%watermark('x','NOF1', 'all');


