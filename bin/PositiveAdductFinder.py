# jamie pike

# python script to find putative positive adducts from a multi column csv file. 
# Declaration: I trailed Chat-GPTs script writing abilities for this. I used Chat-GPT v3 to help my write this, some parts worked well, others required adjustment from me. 

import csv
import sys

# Define the positive adducts with their observed weight and ∆ from M+H
positive_adducts = {
    'M+H': 1.00728,
    'M+Na': 22.98922,
    'M+K': 38.96316,
    'M+NH4': 18.03383,
    'M+CH3OH+H': 33.03349,
    'M+Ca': 39.96204,
    'M+ACN+H': 41.03383,
    'M+ACN+Na': 64.01577,
    'M+DMSO+H': 79.02121
}

# Define a function to check if the observed m/z matches with any adduct within a certain range
def check_adduct(observed_mz, expected_mz, tolerance):
    return abs(observed_mz - expected_mz) <= tolerance

# Load dataset from CSV file
observed_data = []

with open(sys.argv[1], newline='') as csvfile:
    reader = csv.reader(csvfile)
    next(reader)  # Skip the header row if present
    for row_index, row in enumerate(reader):
        for col_index, mz in enumerate(row):
            try:
                mz_numeric = float(mz.split('M')[1].split('T')[0])
                rt_numeric = float(mz.split('T')[1])
                observed_data.append((mz_numeric, rt_numeric, row_index, col_index))
            except (ValueError, IndexError):
                pass  # Ignore unexpected row formats

# Initialize counters for potential adducts
potential_adducts_count = 0
within_column_count = {adduct: 0 for adduct in positive_adducts}
between_columns_count = {adduct: 0 for adduct in positive_adducts}
column_counts = {f"Within Column {i}": {adduct: 0 for adduct in positive_adducts} for i in range(len(row))}

# Check for potential adducts
for mz1, rt1, row1, col1 in observed_data:
    for mz2, rt2, row2, col2 in observed_data:
        if mz1 != mz2 and abs(rt1 - rt2) <= 2:
            for adduct, expected_mz in positive_adducts.items():
                if check_adduct(mz2 - mz1, expected_mz, tolerance=1):
                    print(f"Potential adduct found: {adduct}")
                    print(f"Reference data: m/z difference {expected_mz}, retention time {rt1}")
                    print("Matching data:")
                    print(f" - m/z {mz1}, retention time {rt1}, row {row1}, column {col1}")
                    print(f" - m/z {mz2}, retention time {rt2}, row {row2}, column {col2}")
                    print()
                    potential_adducts_count += 1
                    if col1 == col2:
                        within_column_count[adduct] += 1
                        column_counts[f"Within Column {col1}"][adduct] += 1
                    else:
                        between_columns_count[adduct] += 1

# Print summary table
print("\nSummary Table:")
print("Adduct          | Total | Within Column | Between Columns")
print("---------------------------------------------------------")
for adduct in positive_adducts:
    total_count = within_column_count[adduct] + between_columns_count[adduct]
    print(f"{adduct.ljust(15)} | {total_count:<5} | {within_column_count[adduct]:<13} | {between_columns_count[adduct]:<15}")
print("\nColumn-wise Counts:")
for column, counts in column_counts.items():
    print(column)
    for adduct, count in counts.items():
        print(f" - {adduct}: {count}")
