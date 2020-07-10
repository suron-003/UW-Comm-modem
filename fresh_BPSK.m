a=1;
T=1/25000;
p=1/T;
w=(1+a)/(T);
delta=1/(8*w);
t=linspace(-5*T,5*T,(10*T)/delta);
if(t==0)
    f=1-a+(4*a)/3.14;
else
    if(t==(T/(4*a))||(t==(-T/(4*a))))
        f=((a/sqrt(2))*(1+2/3.14)*sin(3.14/(4*a)))+((1-(2/3.14))*cos(3.14/(4*a)));
    else
      f=((sin(3.14*(1-a)*p*t))+ (4*a*p*t.*cos(3.14*(1+a)*p*t)))./(3.14*p*t.*(1-(4*a*p*t).^2))
    end
end
sum=0
%plot(t,f)
%H=fft(f)
%y=20*log10(abs(H))
%plot(t,y)
RC=conv(f,f)
RC=[RC 0]
%t1=linspace(-10*T,10*T,(20*T/(delta)));
%plot(t1,RC)
E_by_N=[0 2 4 6 8 10]
BER=zeros(1,500)
BER_f=zeros(1,6)
for m=1:6
for k=1:500
b=randi([0 1],1,20)
for i=1:1:20
if(b(i)==0)
    b(i)=-1;
end
end
c=upsample(b,(T/delta))
%zero_array=zeros(1,109)
%c=[zero_array c]
output=conv(c,RC)
%t2=(-10*T:delta:29*T)
%output=output(1:625)
%plot(t2,output)
%output_bits=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
%array_indices=[0 0]
%for i=161:625
 %   if(mod(t2(i),T)==0)
  %      array_indices=[array_indices i]
   % end
%end
%for i=1:20
 %   array_indices_1(i)=array_indices(i+2)
%end
%for i=1:20
%5    output_bits(i)=output(array_indices_1(i))
%end
%for i=1:20
%    if(output_bits(i)>0)
 %       output_bits(i)=1
  %  else
   %     output_bits(i)=0
    %end
    %end
%eyediagram(output,16)
output=output(1:623)
Ps=(norm(output)^2)/length(output)
SNR=10*log10(10/(E_by_N(m)))
Pn=Ps/SNR
ln=29*T/(delta)
ln=int16(464)
noise=wgn(1,ln,10)
final_noise=conv(f,noise)
Pn_1=(norm(final_noise)^2)/length(final_noise)
final_noise=((final_noise)*sqrt(Pn))/(sqrt(Pn_1))
output_signal=output+final_noise
t_f=(-10*T:delta:29*T)
t_f=t_f(1:623)
%plot(t_f,output_signal)
output_bits=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
array_indices=[0 0]
for i=161:623
    if(mod(t2(i),T)==0)
        array_indices=[array_indices i]
    end
end
for i=1:20
    array_indices_1(i)=array_indices(i+2)
end
for i=1:20
    output_bits(i)=output_signal(array_indices_1(i))
end
for i=1:20
    if(output_bits(i)>0)
        output_bits(i)=1
    else
        output_bits(i)=0
    end
end
for i=1:20
    if(output_bits(i)==0)
        output_bits(i)=-1
    end
end
error_bits=0
for i=1:20
    if(b(i)~=output_bits(i))
        error_bits=error_bits+1
    end
end
BER(k)=error_bits/20;
sum=sum+BER(k)
end
BER_f(m)=sum
end
semilogx(E_by_N,BER_f)
BER_act=zeros(1,6)
for p=1:6
    BER_act(i)=sqrt(2)*10*log10(10/(E_by_N(i)))
end
semilogx(E_by_N,BER_act)