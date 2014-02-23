% EE679 Speech Processing Assignment 1-extra
% Ashwin Kachhara, 10d070048

% Synthesizing the sounds of each frequency in the song. Each of these
% sequences are of 8000 samples i.e. half a second with sampling rate of
% 16kHz. Directly using the functions, i had written for computing
% assignment 1.
y1 = resonator6poleout(730, 1090, 2440, 100, 185);%1
y2 = resonator6poleout(730, 1090, 2440, 100, 196);%2
y3 = resonator6poleout(730, 1090, 2440, 100, 220);%3
y4 = resonator6poleout(730, 1090, 2440, 100, 247);%4
y5 = resonator6poleout(730, 1090, 2440, 100, 277);%5
y6 = resonator6poleout(730, 1090, 2440, 100, 294);%6
y7 = resonator6poleout(730, 1090, 2440, 100, 330);%7

% Arranging accoring to time and sequence of notes as described in the doc
% file. We get the final signal y which contains the entire song.
y = [
y1(1:(0.2*16000));
y2(1:(0.2*16000));
y3(1:(0.4*16000));
y3(1:(0.4*16000));
y4(1:(0.4*16000));
y4(1:(0.4*16000));
y3(1:(0.4*16000));
y3(1:(0.2*16000));
y2(1:(0.2*16000));
y1(1:(0.4*16000));
y1(1:(0.2*16000));
y2(1:(0.2*16000));
y3(1:(0.4*16000));
y3(1:(0.4*16000));
y4(1:(0.4*16000));
y4(1:(0.4*16000));
y3(1:(0.4*16000));
y3(1:(0.2*16000));
y2(1:(0.2*16000));
y1(1:(0.4*16000));
y1(1:(0.2*16000));
y2(1:(0.2*16000));
y3(1:(0.4*16000));
y3(1:(0.4*16000));
y4(1:(0.4*16000));
y4(1:(0.4*16000));
y6(1:(0.4*16000));
y6(1:(0.4*16000));
y6(1:(0.3*16000));
y7(1:(0.4*16000));
y6(1:(0.4*16000));
y6(1:(0.3*16000));
y5(1:(0.4*16000));
y5(1:(0.2*16000));
y4(1:(0.3*16000));
y5(1:(0.3*16000));
y4(1:(0.3*16000));
y3(1:(0.4*16000));
y3(1:(0.2*16000));
];

% Normalizing the signal before exporting the audio i.e. finding the
% absolute maximum and dividing the entire sequence by it to avoid
% clipping.
maxvalue = max(abs(y));
y=y/abs(maxvalue);

wavwrite(y, 16000, 'song.wav');
