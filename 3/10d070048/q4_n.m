% for p=10 model of sound 'n'
a = [1,-0.336683172630504,-0.0955401231582934,-1.24594147043500,0.468450686416111,0.0442257434383397,0.618911147611879,-0.269140314973162,0.108207838982661,-0.197305482909665,0.166620298830989;];
sigma = sqrt(0.004622502872126);
F0 = 129.03;
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
title('Synthesized waveform \n\')
xlabel('t')

