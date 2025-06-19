% Correctly rename .mat → .wav
% and .mat.not.mat → .wav.not.mat

files = dir('*.mat*');  % Finds all .mat-based files

for k = 1:length(files)
    oldName = files(k).name;

    if endsWith(oldName, '.mat.not.mat')
        % Change .mat.not.mat → .wav.not.mat
        newName = regexprep(oldName, '\.mat\.not\.mat$', '.wav.not.mat');

    elseif endsWith(oldName, '.mat') && ~contains(oldName, '.not')
        % Only regular .mat → .wav (ignoring ones with '.not')
        newName = regexprep(oldName, '\.mat$', '.wav');

    else
        continue  % Leave everything else alone
    end

    movefile(oldName, newName);
end
