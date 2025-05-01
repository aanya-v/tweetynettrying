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


# Training the Tweeting Net Model
----





# Using your trained model to predict new data
----
## 🛠 Preparing Your Dataset

Before predicting, you'll need to generate spectrogram frames using `vak prep`:

```bash
vak prep configs/vak_pred_chat_v2.toml
```

> **Important**: If you have previously used this config, make sure the `path` field in the `[vak.prep.dataset]` section is commented out. The path will be auto-generated on the first run

## PREDICT! 

