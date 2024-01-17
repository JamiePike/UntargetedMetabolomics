#IPO - Tool for determining the paramenters to use for XCMS
#############################################
# setRepositories()
# Select 1 2 3 4
# Packages - Install - XCMS, CAMERA, IPO

#############################################
##Install IPO

#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#
# BiocManager::install("IPO", dependencies = TRUE)
#install.packages("Hmisc") #Had an error loading Camera due to Hmisc. 

#############################################
#Call the IPO library
library("IPO")

#############################################
#set the working directory. 
setwd("/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/IPO")
# Change path to location of data files.
datafiles <- list.files("Input_outliers_removed", recursive = TRUE, full.names = TRUE)

############################################
#peakpickingParameters <- getDefaultXcmsSetStartingParams('matchedFilter')
peakpickingParameters <- getDefaultXcmsSetStartingParams('centWave')
#setting levels for step to 0.2 and 0.3 (hence 0.25 is the center point)
#peakpickingParameters$step <- c(0.2, 0.3)
#peakpickingParameters$fwhm <- c(40, 50)
##peakpickingParameters$sigma <- 0 
peakpickingParameters$noise <- 1000 # Set the noise threshold. Look at the raw data and use this as a guage. 
#peakpickingParameters$max <- 5
#peakpickingParameters$index <- FALSE 
#setting only one value for steps therefore this parameter is not optimized
#peakpickingParameters$steps <- 2

time.xcmsSet <- system.time({ # measuring time
  resultPeakpicking <- 
    optimizeXcmsSet(files = datafiles[1:49], # Enter the number of files. 
                    params = peakpickingParameters, 
                    nSlaves = 1, 
                    subdir = NULL)
})
resultPeakpicking$best_settings$result
optimizedXcmsSetObject <- resultPeakpicking$best_settings$xset

retcorGroupParameters <- getDefaultRetGroupStartingParams()
retcorGroupParameters$profStep <- 1
retcorGroupParameters$gapExtend <- 2.7
time.RetGroup <- system.time({ # measuring time
  resultRetcorGroup <-
    optimizeRetGroup(xset = optimizedXcmsSetObject, 
                     params = retcorGroupParameters, 
                     nSlaves = 1, 
                     subdir = NULL)
})
writeRScript(resultPeakpicking$best_settings$parameters, 
             resultRetcorGroup$best_settings)
