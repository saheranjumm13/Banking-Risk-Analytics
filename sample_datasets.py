import pandas as pd
import os

# Main project folder
base_path = r"C:\Users\DELL\Downloads\Bank_loan"

# Data folder
data_path = os.path.join(base_path, "data")

os.makedirs(data_path, exist_ok=True)

# -----------------------------
# 1. Application Train
# -----------------------------
application_train = pd.read_csv(
    os.path.join(base_path, "application_train.csv")
)

application_train_sample = application_train.sample(
    n=min(10000, len(application_train)),
    random_state=42
)

application_train_sample.to_csv(
    os.path.join(data_path, "application_train_sample_10000.csv"),
    index=False
)

# -----------------------------
# 2. Cleaned Dataset
# -----------------------------
cleaned = pd.read_csv(
    os.path.join(base_path, "application_train_cleaned.csv")
)

cleaned_sample = cleaned.sample(
    n=min(10000, len(cleaned)),
    random_state=42
)

cleaned_sample.to_csv(
    os.path.join(data_path, "application_train_cleaned_sample_10000.csv"),
    index=False
)

# -----------------------------
# 3. Feature Engineered Dataset
# -----------------------------
feature_engineered = pd.read_csv(
    os.path.join(base_path, "application_train_feature_engineered.csv")
)

feature_engineered_sample = feature_engineered.sample(
    n=min(10000, len(feature_engineered)),
    random_state=42
)

feature_engineered_sample.to_csv(
    os.path.join(
        data_path,
        "application_train_feature_engineered_sample_10000.csv"
    ),
    index=False
)

print("All three sample datasets created successfully!")

print("\nFiles created:")
print("1. application_train_sample_10000.csv")
print("2. application_train_cleaned_sample_10000.csv")
print("3. application_train_feature_engineered_sample_10000.csv")