# Jamie Pike - Processing XCMS CSV files (instead of doing manually in excel!)
# Oct 2023
# This code has been written mostly by Jamie Pike, although I did  also use ChatGPT to test out its code writing abilities!

# This script will take the XCMS and CAMERA output csv file and process it for MetaboAnalyst, following steps normally performed manually in Excel 
# and used as part of the University of Warwick and University of Birmingham data processing steps. 

# Processing includes:
#   - count number of features & number of features when no peaks identified in blank group. [University of Warwick]
#   - count n peaks > n samples and n peaks > double n samples  [University of Warwick]
#   - count number of 0 values for each feature per sample, and express as a percentage. [University of Warwick]
#   - count the number of peaks per sample and produce scatter plot [University of Birmingham]
#   - sum the area of all peaks per sample  and produce scatter plot [University of Birmingham]
#   - calculate the mean, stdev, relative standard deviation (RSD) and count of given set of QC samples (PrecisionQCs) to calculate precision. [University of Birmingham]
#   - calculate the blank mean and percentage contribution of given set of blank samples (Blank_samples) to calculate blank contribution. [University of Birmingham]
#   - filter based on the RSD of QCs and % blank contribution: thresholds can be changed below. 
#   - filter out isotopes detected by CAMERA.
#   - add unique identifiers to each feature.
#   - convert the table to csv for MetaboAnalyst, inputting unique IDs and sample peaks, as well as creating an empty column for condition. 

##################################################################################################################
#Install packages if required. 

# #Install required packages:
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("knitr")
# install.packages("kableExtra")
# install.packages("openxlsx")

###################################
#Inputs
###################################
# Define the input file path and sample lists. 

# Set your working directory. 
setwd("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/XCMS/Pos/11_BlankGroup2_181123/")
# Replace with your data file. 
data_file <- "result_CAMERA_xcms_pos_Basic_Param.raw.csv"

# Replace with your sample list - (you can just copy and paste from the csv if you use terminal to cat the file!)
sample_list  <- c("C9-1","C9-2","C9-3","C9-4","D9-1","D9-2","D9-3","D9-4","F9-1","F9-2","F9-3","F9-4","X9-1","X9-2","X9-3","X9-4","C12-1","C12-3","C12-4","D12-1","D12-2","D12-3","D12-4","F12-1","F12-2","F12-3","F12-4","X12-1","X12-2","X12-3","C15-1","C15-2","C15-3","C15-4","D15-1","D15-2","D15-3","D15-4","F15-1","F15-2","F15-3","F15-4","X15-1","X15-2","X15-3","X15-4","BLANK_1","BLANK_2_Dup2","BLANK_2","QC-1_Dup","QC-1","QC-2","QC-3")
###################################
#Filtering
###################################

#Filtering Samples:
#Please list the QC samples you wish to pool to calculate precision.
PrecisionQCs <-  c("QC-1_Dup","QC-1","QC-2","QC-3")
#Please list the Blank samples you wish to pool to calculate the blank contribution. 
Blank_samples <-  c("BLANK_1","BLANK_2_Dup2","BLANK_2") 

#Filtering parameters:
RSD_Filter <- 100 #The Univeristy of Birmingham filter there data based on the relative standard deviation of their QC samples. They use a threshold of 30%, which is set here as deafult. You can change if you would like. Set too 100 if you do not want to use the RSD_Filter.  
Blank_contribution_filter <- 100 #The Univeristy of Birmingham filter there data based on the pecentage blank contribution. They use a threshold of 5%, which is set here as deafult. You can change if you would like. Set too 100 if you do not want to use the Blank_contribution_Filter  
filter_blank_samples <- F  # Set to TRUE if you want to filter by peaks in all Blank_samples (i.e., all blank column peak values == 0), set to FALSE if you want to skip this filtering
##############################################################################################################
##############################################################################################################

#You shouldn't need to edit the script below!

######################################
# Load libraries
library(ggplot2)
library(dplyr)
library(knitr)
library(kableExtra)
library(stringr)
library(openxlsx)
library(gridExtra)

#######################################################
#Sense check...
#######################################################

# Check if the sample list is provided
if (length(sample_list) == 0) {
  print("Sample list is not provided. Please define the 'sample_list' variable.")
} else {
  # Check if the file exists
  if (file.exists(data_file)) {
    # Read the CSV data
    data <- read.csv(data_file) #prevent it adding an X to the start of numbered headers
    colnames(data) <- gsub("[^[:alnum:].]", ".", colnames(data)) # fix errors caused by special characters.
    
    # Calculate the total number of sample columns based on the sample list
    total_samples <- length(sample_list)
    
    #Find the "Blanks" column 
    blanks_col_index <- which(names(data) == "Blanks")
    
    # Check if the blanks column exists
    if (length(blanks_col_index) == 0) {
      cat("The 'Blanks' column does not exist in the dataset. It is case sensetive.\n")
    } else {
      
      #######################################################
      #Identify the npeaks and number of features identified
      #######################################################
      # Find the column index for the "npeaks" column
      npeaks_col_index <- which(names(data) == "npeaks")
      
      # Check if the npeaks column exists
      if (length(npeaks_col_index) == 0) {
        cat("The 'npeaks' column does not exist in the dataset.\n")
      } else {
        
        #Print statement
        cat(format(Sys.time(), "\n\nDate: %A %d %B %Y\nTime: %X"))
        cat(paste0("\nInput file: ", data_file, ".\n", total_samples, " samples identified."))
        cat(paste0("\n-----------------\nProducing summary statistics..."))
        
        #Calculate the number of features. 
        num_features <- nrow(data)
        
        # Filter features without any peaks in the "Blank" column
        features_without_blank_peaks <- data %>%
          filter(Blanks == 0)
        
        # Calculate the number of features without peaks in the blanks.
        num_features_without_blank_peaks <- nrow(features_without_blank_peaks)
        
        cat(paste0("Done.\nThe total number of features is: ", num_features,". \n", num_features_without_blank_peaks, " do not have peaks identified in Blanks column from CAMERA. Proceeding with ", num_features_without_blank_peaks, " filtered features. "))
        
        # Filter rows where "npeaks" is greater than the total number of samples
        features_with_more_peaks <- data %>%
          filter(data[[npeaks_col_index]] > total_samples)
        # Count the remaining rows
        num_features_with_more_peaks <- nrow(features_with_more_peaks)
        # Count the number of rows where npeaks is greater than double the total number of samples
        num_features_double_peaks <- sum(data[[npeaks_col_index]] > (2 * total_samples))
        
        # Create a data frame for the results
        results <- data.frame(
          Metric = c("Number of features", "Features without peaks in blank samples", "Number of features with n peaks > n samples", "Number of features with n peaks > double n samples "),
          Value = c(num_features, num_features_without_blank_peaks, num_features_with_more_peaks, num_features_double_peaks)
        )
        
        ###########################################
        #Check if list starts with special characters
        ###########################################
        
        # Function to add 'X' to values starting with a number or special character, this will prevent errors when R processes the csv as R will add an X to tables which do not start with text.
        add_X <- function(my_list) {
          for (i in seq_along(my_list)) {
            if (grepl("^[0-9@#$%^&*]", my_list[i])) {
              my_list[i] <- paste0("X", my_list[i])
            }
          }
          return(my_list)
        }
        
        sample_list <- add_X(sample_list) # check sample list and add X to start of headers which start with a number special char
        PrecisionQCs <- add_X(PrecisionQCs) # repeat for precision qc list
        Blank_samples <-add_X(Blank_samples) # repeat for blanks list.
        ###########################################
        #Build Table
        ###########################################
        
        # Display the combined table of results
        results %>%
          kable("html") %>%
          kable_styling()
        
        ###########################################
        #Identify Outliers
        ###########################################
        #Used the number of 0 values approach from Dr. John Sidda as well as the Count and Sum approaches by Univeristy of Birmingham. 
        
        cat(paste0("\nIdentifying peak distribution across samples..."))
        # Perform sample-specific analysis and store the results in a data frame
        sample_analysis_results <- data.frame(
          Sample = sample_list,
          ZeroNum = numeric(length(sample_list)),
          Percentage_Zeros = numeric(length(sample_list)),
          Count_of_Peaks = numeric(length(sample_list)),
          Sum_of_Peaks = numeric(length(sample_list))
        )
        
        #Amend the names of the samples to match R formatting. R does not like the "-" special character!
        modified_sample_list <- unlist(lapply(sample_list, function(x) gsub("[^[:alnum:].]", ".", x)))
        
        for (i in 1:length(modified_sample_list)) {
          sample_col_name <- modified_sample_list[i]
          
          if (sample_col_name %in% names(data)) {
            sample_data <- data[[sample_col_name]]
            
            # Calculate the number of 0 values
            zeros_count <- sum(sample_data == 0)
            sample_analysis_results$ZeroNum[i] <- zeros_count
            
            # Calculate the percentage of 0 values
            percentage_zeros <- (zeros_count / length(modified_sample_list)) * 100
            sample_analysis_results$Percentage_Zeros[i] <- percentage_zeros
            
            # Calculate the count of peaks
            count_of_peaks_above_0 <- sum(sample_data > 0)
            sample_analysis_results$Count_of_Peaks[i] <- count_of_peaks_above_0
            
            # Calculate the sum of peaks
            sum_of_peaks <- sum(sample_data)
            sample_analysis_results$Sum_of_Peaks[i] <- sum_of_peaks
            
            ###########################################
            #Build Table
            ###########################################
            # Display the sample-specific analysis results
            sample_analysis_results %>%
              kable("html") %>%
              kable_styling()
          }
        }
        ###########################################
        #Build ScatterPlots
        ###########################################
        cat(paste0("Plotting..."))
        # Create a scatter plot for Count_of_Peaks
        count_plot <- ggplot(sample_analysis_results, aes(x = Sample, y = Count_of_Peaks)) +
          geom_point() +
          labs(title = "Scatter Plot: Count of all Peaks (unfiltered)", x = "", y = "Count of all Peaks (unfiltered)") +
          theme_minimal() +
          theme(axis.text.x = element_text(angle = 90, hjust = 1), 
                axis.title.y = element_text(hjust = 0.5)) +
          scale_y_continuous(limits = c(0, max(sample_analysis_results$Count_of_Peaks) + 10))
        
        # Create a scatter plot for Sum_of_Peaks
        sum_plot <- ggplot(sample_analysis_results, aes(x = Sample, y = Sum_of_Peaks)) +
          geom_point() +
          labs(title = "Scatter Plot: Sum of Peak Areas (unfiltered)", x = "", y = "Sum of Peaks (unfiltered)") +
          theme_minimal() +
          theme(axis.text.x = element_text(angle = 90, hjust = 1), 
                axis.title.y = element_text(hjust = 0.5)) +
          scale_y_continuous(limits = c(0, max(sample_analysis_results$Sum_of_Peaks) + 10))
        
        # Save the plots produced as PDFs. 
        ggsave("count_plot-unfiltered.pdf",count_plot, width=3, height=3, units="in", scale=3)
        ggsave("sum_plot-unfiltered.pdf",sum_plot, width=3, height=3, units="in", scale=3)
        ###########################################
        #Calculate Precision
        ###########################################
        
        cat(paste0("Done.\nCalculating precision..."))
        #Adapted from Univeristy of Birmingham data filtering document. 

        ## Ensure PrecisionQCs is a character vector of the modified column names
        PrecisionQCs <- unlist(lapply(PrecisionQCs, function(x) gsub("[^[:alnum:].]", ".", x)))
        Blank_samples <- unlist(lapply(Blank_samples, function(x) gsub("[^[:alnum:].]", ".", x)))

        # Calculate the row mean, standard deviation, and count for each row
        features_without_blank_peaks_stat <- features_without_blank_peaks %>%
          rowwise() %>%
          mutate(
            QCRowMean = mean(c_across(all_of(PrecisionQCs)), na.rm = TRUE),
            QCRowStdDev = sd(c_across(all_of(PrecisionQCs)), na.rm = TRUE),
            QCRelStandDev = (QCRowStdDev / QCRowMean) * 100,
            QCRowCount = sum(!is.na(c_across(all_of(PrecisionQCs)))),
            BlankMean = mean(c_across(all_of(Blank_samples)), na.rm = TRUE),
            PercentBlankContribution = (BlankMean/QCRowMean) * 100,
          )
        
        ###########################################
        #Filter Dataset
        ###########################################
        cat(paste0("Done.\n\nFiltering the dataset...\nRemoving features with peaks in Blank samples...\nFiltering by RSD value and Blank Contribution filter...\n"))
        filtered_features <- features_without_blank_peaks_stat %>%
          filter(QCRelStandDev <= RSD_Filter) %>%
          filter(PercentBlankContribution <= Blank_contribution_filter)
        
        
        # Filter the data frame to remove rows with any text in the 'Isotopes' column
        filtered_data <- filtered_features %>%
          filter(!grepl("[A-Za-z]+", isotopes))
        
        
        AfterIsosRemoved <- nrow(filtered_data)
        
        # filter out rows where columns in "Blank_samples" have a value greater than 0
        if (filter_blank_samples) {
          filtered_data <- filtered_data %>%
            filter(across(all_of(Blank_samples), ~. <= 0))
        }
        
        AfterFilters <- nrow(filtered_data) 

        
        ###########################################
        #Report Results
        ###########################################
        
        cat(paste0("Done.\n-> RSD filter: ", RSD_Filter, "%.\n-> Blank Contribution filter: ", Blank_contribution_filter, "%.\nTotal features after filters: ", AfterFilters, ".\nAfter isotopes removed: ", AfterIsosRemoved, ".\n"))
        
        
        #Used the number of 0 values approach from Dr. John Sidda as well as the Count and Sum approaches by Univeristy of Birmingham. 
        
        
        ###########################################
        #Build updated plots
        ###########################################
        
        cat(paste0("\nIdentifying peak distribution across filtered samples..."))
        # Perform sample-specific analysis and store the results in a data frame
        filtered_sample_analysis_results <- data.frame(
          Sample = sample_list,
          ZeroNum = numeric(length(modified_sample_list)),
          Percentage_Zeros = numeric(length(modified_sample_list)),
          Count_of_Peaks = numeric(length(modified_sample_list)),
          Sum_of_Peaks = numeric(length(modified_sample_list))
        )
        
        for (i in 1:length(modified_sample_list)) {
          sample_col_name <- modified_sample_list[i]
          
          if (sample_col_name %in% names(data)) {
             filtered_sample_data <- filtered_data[[sample_col_name]]
          #   
          # Calculate the number of 0 values
          zeros_count <- sum(filtered_sample_data == 0)
          filtered_sample_analysis_results$ZeroNum[i] <- zeros_count
          
          # Calculate the percentage of 0 values
          percentage_zeros <- (zeros_count / length(modified_sample_list)) * 100
          sample_analysis_results$Percentage_Zeros[i] <- percentage_zeros
          
          # Calculate the count of peaks
          count_of_peaks_above_0 <- sum(filtered_sample_data > 0)
          filtered_sample_analysis_results$Count_of_Peaks[i] <- count_of_peaks_above_0
          
          # Calculate the sum of peaks
          sum_of_peaks <- sum(filtered_sample_data)
          filtered_sample_analysis_results$Sum_of_Peaks[i] <- sum_of_peaks
          
          ###########################################
          #Build Table
          ###########################################
          # Display the sample-specific analysis results
          filtered_sample_analysis_results %>%
            kable("html") %>%
            kable_styling()
        }
      }
      ###########################################
      #Build ScatterPlots
      ###########################################
      cat(paste0("Plotting..."))
      # Create a scatter plot for Count_of_Peaks
      count_plot <- ggplot(filtered_sample_analysis_results, aes(x = Sample, y = Count_of_Peaks)) +
        geom_point() +
        labs(title = "Scatter Plot: Count of all Peaks (filtered)", x = "", y = "Count of all Peaks (filtered)") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1), 
              axis.title.y = element_text(hjust = 0.5)) +
        scale_y_continuous(limits = c(0, max(sample_analysis_results$Count_of_Peaks) + 10))
      
      # Create a scatter plot for Sum_of_Peaks
      sum_plot <- ggplot(filtered_sample_analysis_results, aes(x = Sample, y = Sum_of_Peaks)) +
        geom_point() +
        labs(title = "Scatter Plot: Sum of Peak Areas (filtered)", x = "", y = "Sum of Peaks (filtered)") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1), 
              axis.title.y = element_text(hjust = 0.5)) +
        scale_y_continuous(limits = c(0, max(sample_analysis_results$Sum_of_Peaks) + 10))
      
      # Save the plots produced as PDFs. 
      ggsave("count_plot-filtered.pdf",count_plot, width=3, height=3, units="in", scale=3)
      ggsave("sum_plot-filtered.pdf",sum_plot, width=3, height=3, units="in", scale=3)
      
       ###########################################
      #Generate Unique IDs
      ###########################################
      cat(paste0("\n\nGenerating Unique Identifiers for each feature..."))
      # Create two new columns with rounded values
      filtered_data <- filtered_data %>%
        mutate(
          RoundMZ = round(mzmed, 3),
          RoundRT = round(rtmed, 3)
        )
      
      # Create the 'Unique Identifiers' column by concatenating values
      filtered_data <- filtered_data %>%
        mutate(
          `Unique Identifiers` = paste("M", RoundMZ, "T", RoundRT, sep = "")
        )
      
      # Convert the 'Unique Identifiers' column to character data type
      filtered_data$`Unique Identifiers` <- as.character(filtered_data$`Unique Identifiers`)
      
      # Remove duplicates with more decimal places
      filtered_data <- filtered_data %>%
        group_by(`Unique Identifiers`) %>%
        mutate(
          `Unique Identifiers` = ifelse(n() == 1, `Unique Identifiers`, row_number())
        ) %>%
        ungroup()
      
      # Sort the data frame by 'Unique Identifiers' (if needed)
      filtered_data <- filtered_data %>%
        select(`Unique Identifiers`, everything())
      
      ###########################################
      #Generate Ouptut XLSX File with all data
      ###########################################
      # Save the output into an xlxs, with a sheet for each dataset. 
      
      cat(paste0("Done.\nSaving to output xlsx file..."))
      
      dataset_names <- list('SummaryStats' = results, 'SampleDistrib' = sample_analysis_results, 'FilteredFeatures_preIsos' = filtered_features, 'FilteredFeatures_postIso' = filtered_data )
      write.xlsx(dataset_names, file = 'ProcessingXCMSOutput.xlsx')
      
      ###########################################
      #Modify the data for MetaboAnalyst
      ###########################################
      cat(paste0("Done.\nCreating csv for MetaboAnalyst..."))
      
      # Select the 'Unique Identifiers' and columns from the 'modified_sample_list'
      filtered_data <- filtered_data %>%
        select("Unique Identifiers", all_of(modified_sample_list))
      
      # Transpose the data frame
      transposed_data <- t(filtered_data)
      
      # Create a new data frame for MetaboAnalyst Input
      metabo_analyst_input <- as.data.frame(transposed_data)
      
      # Set column names based on the first row (unique identifiers)
      colnames(metabo_analyst_input) <- metabo_analyst_input[1, ]
      
      metabo_analyst_input <- cbind(sample = rownames(metabo_analyst_input), metabo_analyst_input)
      rownames(metabo_analyst_input) <- 1:nrow(metabo_analyst_input)
      
      # Remove the first row as it's now used for column names
      metabo_analyst_input <- metabo_analyst_input[-1, ]
      
      # Reset row names
      rownames(metabo_analyst_input) <- NULL
      
      # Add the 'condition' column as the second column
      metabo_analyst_input <- metabo_analyst_input %>%
        mutate(`condition` = NA) %>%
        select(1, condition, everything())
      
      ###########################################
      #Generate Ouptut CSV Files
      ###########################################
      # Save the data frame as a CSV file.
      write.csv(metabo_analyst_input, "MetaboAnalyst_Input.csv", row.names = F) #MetaboAnalyst Dataset.
      cat(paste0("Done.\n-----------------\nOutput files:\n-> count_plot.pdf\n-> sum_plot.pdf\n-> ProcessingXCMSOutput.xlsx\n-> MetaboAnalyst_Input.csv\nThey can be found here:\n", getwd(), "\n\nPlease be aware that any peaks you wish to normalise by, e.g. sodium formate, may have been filtered out. You will need to check for this in the MetaboAnalyst csv, and add it in manually if needed."))
    }
  }
} else {
  print("The specified file does not exist. Please check the file path.\n")
}
}





