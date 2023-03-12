%% PART B
% recObj = audiorecorder;
% disp('Start recording.');
% recordblocking(recObj, 5);
% disp('End recording')
% play(recObj);
% soundArray = getaudiodata(recObj);
soundArray = load("soundArray.mat");
soundArray = soundArray.soundArray;
recObj = load("recObj.mat");
recObj = recObj.recObj;
% play(recObj);
% plot the sound signal
figure;
subplot(1,2,1);
plot(soundArray);
title('Plot of soundArray');
xlabel('t: Time (sec)');
ylabel('Amplitude');

partOfSoundArray = soundArray(8242 : 16667);
subplot(1,3,1);
plot(partOfSoundArray);
title('Plot of partOfSoundArray');
xlabel('t: Time (sec)');
ylabel('Amplitude');

firstPeriodOfPartOfSoundArray = partOfSoundArray(1 : 45);
% subplot(1,3,2);
% plot(firstPeriodOfPartOfSoundArray);
f = 174; 
w = 2*pi*f;
N = 350;
resultPiano = fs(firstPeriodOfPartOfSoundArray, w, N);
stem(-N:N, resultPiano);
title('Fourier Coefficients');
xlabel('k');
ylabel('ak');

% PART B Question 4

% F3 note on guitar
guitarSoundArray = load("GuitarF3soundArray.mat").soundArray;
guitarRecObj = load("GuitarF3recObj.mat").recObj;
guitarPartOfSoundArray = guitarSoundArray(12991 : 21110);
subplot(1,2,1);
plot(guitarSoundArray);
title('Plot of Guitar soundArray');
xlabel('t: Time (sec)');
ylabel('Amplitude');

subplot(1,2,2);
plot(guitarPartOfSoundArray);
title('Plot of Guitar partOfSoundArray');
xlabel('t: Time (sec)');
ylabel('Amplitude');

% F3 note on flute
fluteSoundArray = load("FluteF3soundArray.mat").soundArray;
fluteRecObj = load("FluteF3recObj.mat").recObj;
flutePartOfSoundArray = fluteSoundArray(7710 : 21796);
subplot(1,2,1);
plot(fluteSoundArray);
title('Plot of Flute soundArray');
xlabel('t: Time (sec)');
ylabel('Amplitude');

subplot(1,2,2);
plot(flutePartOfSoundArray);
title('Plot of Flute partOfSoundArray');
xlabel('t: Time (sec)');
ylabel('Amplitude');

% FSC calculation
firstPeriodOfPartOfSoundArray = guitarPartOfSoundArray(1 : 45);
resultGuitar = fs(firstPeriodOfPartOfSoundArray, w, N);
stem(-N:N, resultGuitar);
title('Fourier Coefficients');
xlabel('k');
ylabel('ak');

firstPeriodOfPartOfSoundArray = flutePartOfSoundArray(1 : 45);
resultFlute = fs(firstPeriodOfPartOfSoundArray, w, N);
stem(-N:N, resultFlute);
title('Fourier Coefficients');
xlabel('k');
ylabel('ak');

% Part B Question 5
synthesized = synthesis(resultPiano, w, N);
subplot(1,2,1);
plot(real(synthesized));
title('Synthesized Voice (one period)');
xlabel('n');
ylabel('Amplitude');
synthesized = repmat(synthesized, 178, 1);
synthesized = reshape(synthesized.',1,[]);
subplot(1,2,2);
plot(real(synthesized));
title('Synthesized Voice (same size as partOfSoundArray)');
xlabel('n');
ylabel('Amplitude');

audiowrite('handel.wav', real(synthesized), 8000);

% Part B Question 7
N1 = 1;
M = 164;

for k = 1 : size(resultPiano, 2)
    if resultPiano(1, k) > 0.0001 
        N1 = k;
        break;
    end
end

synthesized = synthesis(resultPiano, w, (M - N1) / 2);
synthesized = repmat(synthesized, 178, 1);
synthesized = reshape(synthesized.',1,[]);
audiowrite('partial.wav', real(synthesized), 8000);

% Part B Question 8
newFSC = zeros(1, size(resultPiano, 2));
for k = 1 : size(resultPiano, 2)
    [theta,rho] = cart2pol(real(resultPiano(1, k)), imag(resultPiano(1, k)));
    [x, y] = pol2cart(theta, 1);
    newFSC(1, k) = x + y * 1i;
end

newSynthesis = synthesis(newFSC, w, N);
newSynthesis = repmat(newSynthesis, 178, 1);
newSynthesis = reshape(newSynthesis.',1,[]);
audiowrite('mag1.wav', real(newSynthesis), 8000);

% Part B Question 9
newFSCPart9 = zeros(1, size(resultPiano, 2));
for k = 1 : size(resultPiano, 2)
    [theta,rho] = cart2pol(real(resultPiano(1, k)), imag(resultPiano(1, k)));
    [x, y] = pol2cart(0, rho);
    newFSCPart9(1, k) = x + y * 1i;
end

newSynthesis = synthesis(newFSCPart9, w, N);
newSynthesis = repmat(newSynthesis, 178, 1);
newSynthesis = reshape(newSynthesis.',1,[]);
audiowrite('phase0.wav', real(newSynthesis), 8000);

% function for synthesis
function[onePeriod] = synthesis(coefficients, w, N)
    f = w/(2*pi);
    T = 1 / f;
    t = 0 : 1/8000 : T;
    t = t(1:45);
    onePeriod = zeros(1, size(t, 2));
    
    for j = 1 : 45
        for k = -N : N
            onePeriod(1, j) = onePeriod(1, j) + coefficients(1, k + N + 1) * exp( 1i * k * w * t(1, j));
        end
    end
end

function[ak] = fs(sound, w, N)
   ak = zeros(1,2 * N+1); 
   f = w/(2*pi);
   T = 1 / f;
   t = 0 : 1/8000 : T;
   t = t(1:45);
   for k = -N : N
       ak(1, k + N + 1) = f * trapz(( exp( -1i * k * w * t)).*(sound.'));
   end
end