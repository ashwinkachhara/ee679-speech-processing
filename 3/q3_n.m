% for p=10 model of sound 'n'
a = [1,-0.336683172630503,-0.0955401231582948,-1.24594147043500,0.468450686416110,0.0442257434383423,0.618911147611882,-0.269140314973162,0.108207838982659,-0.197305482909666,0.166620298830989;];
sigma = sqrt(0.004622502872126);

Sa = wavread('n.wav');
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