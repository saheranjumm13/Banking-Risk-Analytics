import pandas as pd
from pathlib import Path

# Project folder
BASE_DIR = Path(__file__).resolve().parent

# Input and output folders
OUTPUT_DIR = BASE_DIR / "data"
OUTPUT_DIR.mkdir(exist_ok=True)

# Number of rows to keep
SAMPLE_SIZE = 10000

# Random seed for reproducibility
RANDOM_STATE = 42

# Datasets to sample
datasets = [
    "application_train",
    "application_train_cleaned",
    "application_train_feature_engineered",
    "bureau",
    "HomeCredit_columns_description",
    "installments_payments",
    "previous_application"
]

for name in datasets:

    print(f"\nProcessing: {name}")

    # Try CSV first
    csv_file = BASE_DIR / f"{name}.csv"

    # Try Excel if CSV doesn't exist
    xlsx_file = BASE_DIR / f"{name}.xlsx"

    try:

        if csv_file.exists():
            print("Reading CSV...")
            df = pd.read_csv(csv_file)

        elif xlsx_file.exists():
            print("Reading Excel...")
            df = pd.read_excel(xlsx_file)

        else:
            print(f"FILE NOT FOUND: {name}")
            continue

        print(f"Original rows: {len(df):,}")

        # Take maximum 10,000 rows
        sample_n = min(SAMPLE_SIZE, len(df))

        sample = df.sample(
            n=sample_n,
            random_state=RANDOM_STATE
        )

        # Save as CSV
        output_file = OUTPUT_DIR / f"{name}_sample_10000.csv"

        sample.to_csv(
            output_file,
            index=False
        )

        print(f"Saved: {output_file}")
        print(f"Sample rows: {len(sample):,}")

    except Exception as e:
        print(f"ERROR processing {name}: {e}")

print("\n===================================")
print("ALL DATASET SAMPLING COMPLETED")
print("===================================")