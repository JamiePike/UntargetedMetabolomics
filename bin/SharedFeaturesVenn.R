# # Set the CRAN mirror directly in R
# options(repos = 'http://cran.us.r-project.org')

# # Install the venn package if you haven't already
# install.packages("venn")

# --------- Setup the script --------- #

# Load the venn library
library(ggplot2)
library(ggvenn)
library(tidyverse)
library(openxlsx)

# Read the TSV file
setwd("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/VennDiagrams")
data <- read.table("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/VennDiagrams/Shared-sig_features_0.05.csv", header = T, sep = ",")

# the data are laid out in columns, with features in a list under each header. ggvenn will identify the shared and unique features.
# Convert data to a format suitable for ggvenn
ggvenn_data <- list(
  T1 = data$T1,
  T2 = data$T2,
  T3 = data$T3
)

# added to drop empty elements from my data
ggvenn_data <- ggvenn_data |> 
  lapply(\(x) x[!x == ""]) 

# --------- Build the plot --------- #
# Create the Venn diagram using ggplot2 and ggvenn
ggvenn_plot <- ggvenn(ggvenn_data, fill_color = c("#0073C2FF", "#EFC000FF", "#CD534CFF"),
  stroke_size = 0.5, show_percentage = F, show_elements = F) +
  theme_void()

# Save the Venn diagram
ggsave("SharedFeaturesVenn.png", plot = ggvenn_plot, width = 8, height = 6, units = "in")

# --------- Output Groups --------- #
# generate csv files of shared features.
# a list to store results
shared_items <- list()

# loop through all of the pairwise combinations ggvenn_data list.
for (i in 2:length(ggvenn_data)) {
  cols_combinations <- combn(names(ggvenn_data), i, simplify = FALSE)
  for (cols in cols_combinations) {
    sheet_name <- paste(cols, collapse = "_and_")
    shared_items[[sheet_name]] <- Reduce(intersect, ggvenn_data[cols])
  }
}

# calculate groups unique to each column
for (col_name in names(ggvenn_data)) {
  unique_to_col <- ggvenn_data[[col_name]]
  for (shared_col in names(ggvenn_data)) {
    if (shared_col != col_name) {
      unique_to_col <- setdiff(unique_to_col, ggvenn_data[[shared_col]])
    }
  }
  sheet_name <- paste("Unique_to_", col_name)
  
  # add the group even if it's empty
  shared_items[[sheet_name]] <- unique_to_col
  }


# write shared items to a CSV with separate sheets
write.xlsx(shared_items, "Shared_Items_Sheets.xlsx")
