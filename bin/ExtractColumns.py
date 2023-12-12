#Jamie Pike

#Python script to extract a specific set of feature columns from MetaboAnalyst .csv input. 
# Command usage; python ./ExtractColumns.py [columns_to_extract.csv] [data_file.csv] > pipe to output file. 

# Import required libraries. 
import csv
import sys

def extract_columns(columns_file, data_file):
    try:
        # Open the columns file and the data file for reading
        with open(columns_file, 'r') as cols, open(data_file, 'r') as data:
            # Read the column names to extract from columns_file.csv
            columns_to_extract = set(next(csv.reader(cols, delimiter=',')))

            # Read the data file using CSV reader
            data_reader = csv.reader(data, delimiter=',')

            # Get the header from the data file
            header = next(data_reader)

            # Include the first two columns by default
            columns_to_extract.update(header[:2])

            # Get indices of columns to extract
            indices_to_extract = [i for i, col in enumerate(header) if col in columns_to_extract]

            # Extracted header for columns to be printed
            extracted_header = [header[i] for i in indices_to_extract]

            # Print the header for the extracted columns
            print(','.join(extracted_header))

            # Iterate through each row in the data file
            for row in data_reader:
                # Extract values for columns to be printed in each row
                extracted_row = [row[i] for i in indices_to_extract]

                # Print the extracted values as a comma-separated string
                print(','.join(extracted_row))
    except FileNotFoundError as e:
        print(f"File not found: {e.filename}")
    except StopIteration:
        print("File is empty or does not contain header information.")

if __name__ == "__main__":
    # Check if correct number of arguments provided
    if len(sys.argv) != 3:
        print("Usage: python ExtractColumns.py [columns_to_extract.csv] [data_file.csv] > pipe to output file")
        sys.exit(1)
    
    # Call the extract_columns function with the provided arguments
    extract_columns(sys.argv[1], sys.argv[2])
