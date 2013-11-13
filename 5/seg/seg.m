segments = detectVoiced('zero_to_nine_Vedhas2_8k.wav');

index = 15;
Fs = 8000;

data = ['zero '; 'one  '; 'two  '; 'three'; 'four '; 'five '; 'six  '; 'seven'; 'eight'; 'nine ';];
num = cellstr(data);

if(size(segments,2) == 20),
    for i=1:20,
        audiowrite(strcat(num{ceil(i/2)},num2str(index+rem(i+1,2)),'.wav'), segments{i},Fs);
    end
else
    printf('Change parameters in detectVoiced')
end