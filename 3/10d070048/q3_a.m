% for p=10 model of sound 'a'
a = [1,-0.420287293299905,-0.0167760932776719,-0.104562761984595,0.689852617695652,-0.361632554947867,0.140248097569097,-0.203610014001556,0.444672696487985,-0.120304813366367,-0.0794124187832130;];
sigma = sqrt(0.165941469629558);

Sa = wavread('a.wav');
Ls = length(Sa);
S = zeros(Ls,1);
S(1) = Sa(1);
S(2:end) = Sa(2:end) - 0.975*Sa(1:end-1);

%30ms window, sampling rate of 8k
Lw = 0.03 * 8000;
w = hamming(Lw);

Sw = zeros(Lw+10,1);
Suw = zeros(Lw+10,1);
strt = floor(Ls/2-Lw/2);
Sw(11:Lw+10) = S(strt:strt+Lw-1).*w;
Suw(11:Lw+10) = S(strt:strt+Lw-1);

e1 = zeros(Lw,1);
e2 = zeros(Lw,1);

for i=1:240,
    e1(i) = a*Sw(i+10:-1:i)/sigma;
    e2(i) = a*Suw(i+10:-1:i)/sigma;
end
figure(1)
plot(e1)
title('Residual Error signal | inv filter with windowed signal')
xlabel('n')

figure(2)
plot(e2)
title('Residual Error signal | inv filter with unwindowed signal')
xlabel('n')
% The peaks are at 83 and 147. Difference is 64, corresponding to 125 Hz

