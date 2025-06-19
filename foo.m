% function foo(filename, threshold)
filename = 'aanyabr173gr56.annot.csv';
threshold = 2e4;
data = readtable(filename);
datacell = readcell(filename);
lbl = string(datacell(2:end,1));
data.label = lbl;
%iterate for each annotation number (song file) 
file_len = data.annotation(end);
for i=1:file_len
    file_idx = find(data.annotation==i); %index of rows for current song file
    %audio_path and annotation csv filename
    audio_path = char(data.notated_path(file_idx(1)));
    tweetynet_csv = data.annot_path(1);
    %segmentation parameters
    threshold = threshold;
    min_int = 2; %ms min space between syllables
    min_dur = 20; %20 ms duration of syllable
    sm_win = 2; %smoothing window
    %song labels
    labels = strjoin(data.label(file_idx(1:end)));
    labels = strrep(labels, ' ', ''); %remove spaces
    %onsets and offsets
    onsets = data.onset_s(file_idx(1:end)) * 1000;
    offsets = data.offset_s(file_idx(1:end)) * 1000;
    fuldir=dir();
    path = fuldir(1).folder;
    fname= [audio_path(1:end-3) 'not.mat'];
    save(fname, "fname","audio_path","tweetynet_csv","threshold","min_int","min_dur","sm_win","labels","onsets","offsets")
end
%end
