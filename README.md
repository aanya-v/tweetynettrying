# Set up virtual environment
---
in your terminal, use this to create a new virtual environment with the necessary dependencies 
```{bash}
conda env create -f environment.yml
```

If you already have a virtual environment and want to update it you can instead
```{bash}
conda env update -f environment.yml
```


# Set up tweety net structure

## Folder Setup
----
Start by creating a new project folder with the following structure:
```
vak_project_bird1/
├── configs/
├── scripts/
├── data/
└── results/
```
## Convert training files to .wav format
----
Tweety net doesn't work with .mat files so you need to convert them to the .wav format. Reference renamingtowav.mlx file for an example of how to rename the batch file and use rename_files_aanya.m to rename the training files!


## Add training files 
----
Place your training files inside a subfolder named `train` within the `data` directory. The structure should look like this:
```
vak_project_bird1/
├── configs/
│ └── vak_train.toml
│ └── vak_pred.toml
├── scripts/
├── data/
│ └── train/
│ ├── file1.wav
│ ├── file1.wav.not
│ ├── file2.wav
│ ├── file2.wav.not
│ ├── ...
│ └── rootresults/ # Empty folder used as the root_results_dir
├── output/
└── results/
```
# Training the Tweeting Net Model
----
1.) prep the toml file:
```bash
cd  C:\Users\avusiri\vak_project_bird1 #navigate to the vak folder
vak prep configs/vak_train.toml
```

> **Important**: If you have previously used this config, make sure the `path` field in the `[vak.prep.dataset]` section is commented out. The path will be auto-generated on the first run


will give you a message like this if it works: 
```bash
2025-06-19 15:53:10,787 - vak.prep.frame_classification.frame_classification - INFO - Saving dataset csv file: data\output\train_trying-vak-frame-classification-dataset-generated-250619_155130\train_trying_prep_250619_155130.csv
```

2.) train:
```bash
vak train configs/vak_train.toml
```
> If you use my toml file it runs on cpu so it takes forever bc I was unable to figure out how to use gpu instead but if you are able to access that it'll train way faster! Also take a lunch break or something/ don't touch the computer or else it detects a "keyboard interrupt" and you will need to rerun it



# Using your trained model to predict new data
----
## 🛠 1.) Preparing Your Dataset

Now your model is trained and should be ready to label new files! First you will need to have the new files in a .wav format. Use the code from before to convert them to .wav files. I like to put them in a subfolder called pred in the train folder. However, you can put this folder wherever you like as long as you assign data_dir correctly

```
data_dir = "data/train/pred"
```

Before predicting, you'll need to generate spectrogram frames using `vak prep`. 

```bash
vak prep configs/vak_pred.toml
```

> **Important**: If you have previously used this config, make sure the `path` field in the `[vak.prep.dataset]` section is commented out. The path will be auto-generated on the first run

## 2.) Predicting the syllables!
Now the `path` field in the `[vak.prep.dataset]` should be auto-generated with the correct location! Yay. Before running the predict be sure to put in the correct path locations for checkpoint_path labelmap_path and frames_standardizer_path. If this runs successfully your output will be a CSV file with the predicted labels.

```bash
vak predict configs/vak_pred.toml
```

## ⚙️ Tuning Parameters

Depending on your dataset, you may need to adjust key parameters. I would reccomend running it on the original parameters first and then adjusting afterwards!

- **`min_segment_dur`**  
  Controls the minimum syllable duration in seconds.  
  Example:  
  ```toml
  min_segment_dur = 0.03
  ```

- **`majority_vote`**  
  Determines whether to smooth labels across frames.  
  - `true`: Smooths transitions and removes very short syllables (e.g., `p, q, r, s` may merge into `p, s`)  
  - `false`: Preserves all predictions, including short/fragmented ones  

> In our case, setting `majority_vote = false` gave more detailed output, and we post-processed it using a custom notebook (`pruningCSV.ipynb`) to remove short/unwanted syllables.


# Converting CSV with annotations to .wav.not files
----


# POTENTIAL ERRORS and log 
[See error log](https://docs.google.com/document/d/1a5lbKRowmtcYCeoNzsEV__CA7FvF03H-hQYPCRfsTYA/edit?tab=t.0#heading=h.wwhrmlbkw9vs)


