function [output] = Matched_filter(input_signal,f_max,f_min)
%matched filter of up signal for CSK
T=1;
delta=1/512;
t=(-(T-delta):delta:0);
up=cos((2*pi*-t).*((((f_max-f_min)/T)*-t)+f_min));
down=cos((2*pi*-t).*((((f_min-f_max)/T)*-t)+f_max));
%append=0
%for i=1:length(up)-1
 %   append=[append 0];
%end
%input_signal=[input_signal append];
output=conv(input_signal,up);
end

