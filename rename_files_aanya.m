% Set working directory
dataDir = 'C:\Users\avusiri\vak_project\data\train_trying';
cd(dataDir)

defaultFs = 30000; % Default sampling rate

% --- PART 1: Convert .mat to .wav and delete original ---
matFiles = dir('*songbout*.mat');
for i = 1:length(matFiles)
    fname = matFiles(i).name;

    % Skip .mat.not.mat files
    if contains(fname, '.not.mat')
        continue
    end

    try
        s = load(fname);
        if isfield(s, 'board_adc_data')
            y = double(s.board_adc_data);
        elseif isfield(s, 'audio')
            y = double(s.audio);
        else
            fprintf('⚠️ Skipping %s: no valid audio field.\n', fname);
            continue
        end

        [~, name, ~] = fileparts(fname);
        audiowrite([name '.wav'], y, defaultFs);
        fprintf('✅ Created %s.wav\n', name);

        % Delete original .mat file
        delete(fname);
        fprintf('🗑️ Deleted original %s\n', fname);
    catch ME
        fprintf('❌ Error converting %s: %s\n', fname, ME.message);
    end
end

% --- PART 2: Rename .mat.not.mat to .wav.not.mat ---
noteFiles = dir('*songbout*.mat.not.mat');
for i = 1:length(noteFiles)
    oldName = noteFiles(i).name;
    newName = strrep(oldName, '.mat.not.mat', '.wav.not.mat');
    movefile(oldName, newName);
    fprintf('🔁 Renamed %s → %s\n', oldName, newName);
end
