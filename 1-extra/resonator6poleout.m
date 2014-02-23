function y = resonator6poleout(F1, F2, F3, B, F0)
% y = resonator6poleout(F1, F2, F3, B, F0)
% Function which calculates the output of a 3 formant filter (F1, F2, F3,
% B) with equal bandwidth of all formants. The input signal is an impulse
% train of frequency F0 is passed through it.

h1 = resonator2poleimpout(F1, B, F0);
h2 = resonator2poleout(F2, B, h1);
h3 = resonator2poleout(F3, B, h2);

y = h3(1:8000);
