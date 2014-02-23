% for p=10 model of sound 'a'
a = [1,-0.420287293299905,-0.0167760932776719,-0.104562761984595,0.689852617695652,-0.361632554947867,0.140248097569097,-0.203610014001556,0.444672696487985,-0.120304813366367,-0.0794124187832130;];
sigma = 0.407359140844486;
F0 = 125;
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
title('Synthesized waveform \a\')
xlabel('t')



