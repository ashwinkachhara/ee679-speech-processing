% To run this, you must have the following code: http://www.mathworks.com/matlabcentral/fileexchange/28826-silence-removal-in-speech-signals
% in your MATLAB path or working directory

segments = detectVoiced('zero_to_nine_Vedhas2_8k.wav');

index = 15;
Fs = 8000;

data = ['zero '; 'one  '; 'two  '; 'three'; 'four '; 'five '; 'six  '; 'seven'; 'eight'; 'nine ';];
num = cellstr(data);

if(size(segments,2) == 20),
    for i=1:20,
%         Saving each extracted segment into the appropriate directory.
        audiowrite(strcat(num{ceil(i/2)},num2str(index+rem(i+1,2)),'.wav'), segments{i},Fs);
    end
else
%     If we are getting more or less than 20 segments, then we need to
%     change the window parameters in detectVoiced
    printf('Change parameters in detectVoiced')
end