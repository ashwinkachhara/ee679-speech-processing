Fs = 8000;      %# Samples per second
toneFreq = 1200;  %# Tone frequency, in Hertz
nSeconds = 2;   %# Duration of the sound
% Generating the main frequency component
y1 = 4*sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

for i=1:24,
    % Generating the variable frequency ( this has lower amplitude)
    maskedFreq = 100*i;
    y2 = sin(linspace(0, nSeconds*maskedFreq*2*pi, round(nSeconds*Fs)));
    y = y1+y2;
    % Normalization after adding the 2 signals
    y = y/max(abs(y));
    % Writing to output file
    wavwrite(y,Fs,strcat('s', num2str(i*100)));
end

