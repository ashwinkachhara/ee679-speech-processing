speechSignal = audioread('x1.wav');

Fs = 8000;

% A hamming window is chosen
winLen = 301;
winOverlap = 300;
wHamm = hamming(winLen);

% Framing and windowing the signal without for loops.
sigFramed = buffer(speechSignal, winLen, winOverlap, 'nodelay');
sigWindowed = diag(sparse(wHamm)) * sigFramed;

% Short-Time Energy calculation
energyST = sum(sigWindowed.^2,1);

% Time in seconds, for the graphs
t = [0:length(speechSignal)-1]/Fs;

winLen = 301;
winOverlap = 300;
wHamm = hamming(winLen);
magnitudeAv = sum(abs(sigWindowed),1);

detect = zeros(size(energyST,2),1);
prev_const = winOverlap;
for i=prev_const+1:size(energyST,2),
    stmean = mean((energyST((i-prev_const):i)).^2);
    if(stmean>0.0001),
        detect(i) = 1;
    end
end

figure(1)
subplot(3,1,1)
plot(speechSignal)
subplot(3,1,2)
plot(energyST)
subplot(3,1,3)
plot(detect)


