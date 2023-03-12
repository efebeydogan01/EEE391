recObj = audiorecorder;
disp('Start recording.');
recordblocking(recObj, 5);
disp('End recording')
play(recObj);
soundArray = getaudiodata(recObj);