% for p=10 model of sound 'i'
a = [1,0.698317342461645,-0.909861237184334,-1.65274560720659,-0.235382082563609,0.952174308040117,0.937834384933943,-0.135865286890716,-0.412030429797570,-0.0311303168409126,0.188984000693420;];
sigma = sqrt(0.025784896943841);
F0 = 133.33;
Fs = 8000;

% Generating the impulse train
T0 = round(1/F0);
t = 0:1/Fs:1;
imptrain = zeros(size(t));
imptrain(1:Fs/F0:end) = 1;
imptrain = imptrain*sigma;

S = zeros(8000,1);

for i=11:8000,
    S(i) = imptrain(i)- S(i-1:-1:i-10)'*a(2:end)';
end
Sd = zeros(8000,1);
Sd(1) = S(i);
for i=11:8000,
    Sd(i) = 0.975*Sd(i-1) + S(i);
end

Ssyn = Sd(11:2410);
figure(1)
plot(Ssyn(500:740))
title('Synthesized waveform \i\')
xlabel('t')


