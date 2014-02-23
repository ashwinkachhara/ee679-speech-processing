% for p=10 model of sound 'i'
a = [1,0.698317342461645,-0.909861237184334,-1.65274560720659,-0.235382082563609,0.952174308040117,0.937834384933943,-0.135865286890716,-0.412030429797570,-0.0311303168409126,0.188984000693420;]
sigma = sqrt(0.025784896943841);

Sa = wavread('i.wav');
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
