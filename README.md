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

# Convert files to .wav format
----
Tweety net doesn't work with .mat files so you need to convert them to the .wav format. Reference renamingtowav.mlx file for an example of how to rename the batch file and use rename_files_aanya.m to rename the training files! 


# Training the Tweeting Net Model
----
prep the toml file -> vak prep configs/vak_train.toml
will give you a message like this if it works: 2025-06-19 15:53:10,787 - vak.prep.frame_classification.frame_classification - INFO - Saving dataset csv file: data\output\train_trying-vak-frame-classification-dataset-generated-250619_155130\train_trying_prep_250619_155130.csv

train! -> vak train configs/vak_train.toml




# Using your trained model to predict new data
----
## 🛠 1.) Preparing Your Dataset

Before predicting, you'll need to generate spectrogram frames using `vak prep`. 

```bash
vak prep configs/vak_pred_chat_v2.toml
```

> **Important**: If you have previously used this config, make sure the `path` field in the `[vak.prep.dataset]` section is commented out. The path will be auto-generated on the first run

## 2.) Predicting the syllables!
Now the `path` field in the `[vak.prep.dataset]` should be auto-generated with the correct location! Yay. If this runs successfully your output will be a CSV file with the predicted labels.

```bash
vak predict configs/vak_pred_chat_v2.toml
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
