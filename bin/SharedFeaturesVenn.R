# # Set the CRAN mirror directly in R
# options(repos = 'http://cran.us.r-project.org')

# # Install the venn package if you haven't already
# install.packages("venn")

# Load the venn library
library(ggplot2)
library(ggvenn)


# Read the TSV file
setwd("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/VennDiagrams")
data <- read.table("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/VennDiagrams/Shared-sig_features_0.05.csv", header = T, sep = ",")

# Convert data to a format suitable for ggvenn
ggvenn_data <- list(
  T1 = data$T1,
  T2 = data$T2,
  T3 = data$T3
)

# Create the Venn diagram using ggplot2 and ggvenn
ggvenn_plot <- ggvenn(ggvenn_data, fill_color = c("#0073C2FF", "#EFC000FF", "#CD534CFF"),
  stroke_size = 0.5 ) +
  coord_fixed() +
  theme_void()

# Save the Venn diagram
ggsave("SharedFeaturesVenn.png", plot = ggvenn_plot, width = 8, height = 6, units = "in")
