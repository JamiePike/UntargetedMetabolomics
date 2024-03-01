# Progress with NovDec data analysis

For all analysis I followed the protocol outlined in the [Processing Metabolomics Data protocol](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/docs/ProcessingData.md).

## Overview of symptom development

Been as though we are looking at different features between treatment groups, and trying to attribute these to treatment, it is useful to have symptom development as context. Figures were generated using [`SymptomDevStats.R`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/SymptomDevStats.R).

External symptom development | Internal symptom development
:---------------------------:|:------------------:
![External Symptom development](/docs/figures/External_plot.png) | ![Internal Symptom development](/docs/figures/Internal_plot.png)

## IPO Runs

IPO was run twice for positive mode data;

- First with all samples (minus blanks)
- Then without the samples C12-2 and X12-4 (minus blanks)

Outputs can be found here:

Positive mode -> `Metabolomics/NovDec22/IPO/Pos`.

Negative mode -> `Metabolomics/NovDec22/IPO/Neg`

## XCMS Runs

### Positive mode

XCMS was run multiple times, first using the parameters from IPO, followed by changes to adjust the outputs. A summary file (displayed below) of these changes and outputs can be found; `/Metabolomics/NovDec22/XCMS/Pos/XCMS_Params.xlsx`

 Date | Directory Name | Param Summary | Treatment grouping | Feature No.| Feature No - no peaks in blanks| Features after filtering | Notes | XCMS Params ||||||||||||||||||||||||||||
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---
||||||||| method | peakwidth    | ppm   | noise | snthresh | mzdiff   | prefilter | mzCenterFun | integrate | fitgauss | verbose.columns | method  | plottype | distFunc | profStep | center   | response | gapInit | gapExtend | factorDiag | factorGap | localAlignment | method  | bw      | mzwid  | minfrac | minsamp | max |
| 04/10/2023 | 01_IPO_Basic_041023 | IPO deafult output for this data set| Separated by time and treatment | 1895        | 378         |      | A lot of features also identified in the Blank samples      | centWave    | c(40, 84.5), | 47    | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 47       | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 1       | 1       | 50  |
| 05/10/2023 | 02_IPO_Basic_DG_051023        | Changed centre sample     | Separated by time and treatment | 1902        | 383         |      | A lot of features also identified in the Blank samples      | centWave    | c(40, 84.5), | 47    | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 52 (QC1) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 1       | 1       | 50  |
| 06/10/2023 | 03_MinFrac_061023   | Changed min frac| Separated by time and treatment | 2781        | 886         |      | Minfrac reduction increases number of features (ofc)        | centWave    | c(40, 84.5), | 47    | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 52 (QC1) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 0.75    | 1       | 50  |
| 07/10/2023 | 04_Noise800_071023  | Changed noise   | Separated by time and treatment | 3528        | 1179        |      | Lowered the Noise threshold   | centWave    | c(40, 84.5), | 47    | 800   | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 52 (QC1) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 0.75    | 1       | 50  |
| 12/10/2023 | 05_EarlySamplesRemoved_121023 | Removed samples | Separated by time and treatment | 3857        | 1755        |      | Early Samples removed (Blamnk_1, C12-2, X12-4: contamination appears to be present).      | centWave    | c(40, 84.5), | 47    | 800   | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 50 (QC2) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 0.75    | 1       | 50  |
| 01/11/2023 | 06_EarlySamplesRemoved_011123 | Removed samples | Separated by time and treatment | 3010        | 1331        |      | Early Samples removed (Blank_1, C12-2: contamination appears to be present, but when you filtere based on "Blanks" column, X12-4 does not appear as much of an outlier).  | centWave    | c(40, 84.5), | 47    | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 51 (QC2) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 0.75    | 1       | 50  |
| 02/11/2023 | 07_MinSampThree_021123        | Removed samples | Separated by time and treatment | 2725        | 1333        | 524  | Early Samples removed (Blank_1, C12-2: contamination appears to be present, but when you filtere based on "Blanks" column, X12-4 does not appear as much of an outlier).  | centWave    | c(40, 84.5), | 47    | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 51 (QC2) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 0.879999999999999 | 0.0265 | 0.75    | 3       | 50  |
|  | |       |   |   |   |      | Ran IPO again with Blanks, C12-2 and X12-4 removed|   |    |       |       ||| |   | ||       |         ||||||         | |  | |      |         |         |        |         |         |     |
| 06/11/2023 | 08_NewIPO_161123    | Changed settings based on new ipo outout      | Separated by time and treatment | 2095        | 435         |      | Ran  again with new IPO params and  Blanks, C12-2 and X12-4 removed   | centWave    | c(40, 84.5), | 46.25 | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 50 (QC2) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 14.32   | 0.003  | 0.94    | 1       | 50  |
| 06/11/2023 | 09_BlankWithQCs_161123        | Changed where blank is stored       | Separated by time and treatment |   |   |      | | centWave    | c(40, 84.5), | 46.25 | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 50 (QC2) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 14.32   | 0.003  | 0.94    | 1       | 50  |
| 06/11/2023 | 10_BlankGrou_171123 | Created separate folder full of Blank_2 dupes | Separated by time and treatment | 3016        | 1358        | 695  | | centWave    | c(40, 84.5), | 46.25 | 1000  | 10       | -0.00815 | c(3,100)  | wMean       | 1         | FALSE    | FLASE | obiwarp | none     | cor_opt  | 1        | 54 (QC2) | 1        | 0.32    | 2.7       | 2| 1         | 0    | density | 14.32   | 0.003  | 0.75    | 1       | 50  |

### Negtaive mode

 Date       | Directory Name      | Param Summary   | Treatment grouping    | Feature No. | Feature No - no peaks in blanks | features after filtering | Notes | XCMS Params |      |       |      |    |        ||       |   |       |       |         |      |         |      |    |   |      |     |   |   |   |         |      |       |      |   |    |
------------|---------------------|-----------------------------------------------------------------------------------------------------------|---------------------------------|-------------|---------------------------------|--------------------------|---------------------------------------------------------|-------------|----------------|-------|------|----|--------|----------|-------|---|-------|-------|---------|------|---------|------|------------------------|---|------|-----|---|---|---|---------|------|-------|------|---|----|
| 15/01/2023 | 01_IPO_Basic_150124 | IPO deafult output for this data set, but ProfStep adjusted to 0.91 to account for profile matrix error.  | Separated by time and treatment | 1896        | 747         | 310  | A lot of features also identified in the Blank samples  | centWave    | c(15.84, 75.5) | 43.25 | 1000 | 10 | -0.012 | c(3,100) | wMean | 1 | FALSE | FLASE | obiwarp | none | cor_opt | 0.91 | 7 - Sample 48_D9-3_neg | 1 | 0.48 | 2.7 | 2 | 1 | 0 | density | 12.4 | 0.047 | 0.94 | 1 | 50

---

All the features I was identifying using this method were from the first minute, which is usually discarded. Changing the XCMS parameters to counter this took a very long time to process. As a result, I switched to [XCMS online](https://xcmsonline.scripps.edu).

I tired different XMCS parameter sets. [XCMS online](https://xcmsonline.scripps.edu) 

| **Folder   name** | **Number of features** | **Number of features with n peaks   > n samples** | **Number of features with n peaks   > double n samples** | **Features within 30 second rtmed   filter** | **Features without peaks in blank   samples** | **Used features as a % of all   features identified** | **Polarity** | **RT format** | **method (feature identification)** | **ppm** | **snthr** | **peakwidth** | **mzdiff** | **prefilter peaks** | **prefilter intensity** | **noise** | **method (rt correction)** | **profStep** | **method (grouping)** | **bw** | **mzwid** | **minfrac** | **minsamp** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| XCMSOnline_BrukerQTOFDefault | 2302 | 293 | 3 | 19 | 14 | 0.83% | pos | minutes | centWave | 10 | 6 | 5,20 | 0.01 | 3 | 100 | 100 | obiwarp | 1 | density | 5 | 0.015 | 0.5 | 1 |
| XCMSOnline_CustomSettings | 832 | 0 | 0 | 135 | 86 | 16.23% | pos | seconds | centWave | 10 | 10 | 5,80 | 0.005 | 3 | 100 | 1000 | obiwarp | 1 | density | 5 | 0.015 | 0.5 | 1 |
| XCMSOnline_NovDecUpdatedSettings | 9248 | 1039 | 0 | 1325 | 466 | 14.33% | pos | minutes | centWave | 47 | 6 | 40,85 | -0.0081 | 3 | 100 | 100 | obiwarp | 1 | density | 1 | 0.026 | 0.75 | 1 |
| XCMSOnline_NovDecUpdatedSettingsV2 | 3289 | 373 | 0 | 155 | 74 | 4.71% | pos | minutes | centWave | 47 | 10 | 35,90 | -0.0081 | 3 | 100 | 800 | obiwarp | 1 | density | 1 | 0.026 | 0.75 | 1 |
| XCMSOnline_NovDecUpdatesSettingsV3 | 16664 | 1145 | 2 | 2458 | 1759 | 14.75% | pos | minutes | centWave | 47 | 10 | 35,90 | -0.0081 | 3 | 100 | 100 | obiwarp | 1 | density | 1 | 0.026 | 0.5 | 1 |
| XCMSOnline_NovDec_withAprMaySettings | 1429 | 200 | 2 | 75 | 45 | 5.25% | pos | seconds | centWave | 10 | 10 | 16.8,50 | -0.001 | 3 | 100 | 1000 | obiwarp | 1 | density | 5 | 0.019 | 0.4 | 1 |
| XCMSOnline_NovDecSecondTimePoint_AprMay21Settings | 1180 | 157 | 1 | 65 | 35 | 5.51% | pos | seconds | centWave | 10 | 10 | 16.8,50 | -0.001 | 3 | 100 | 1000 | obiwarp | 1 | density | 5 | 0.019 | 0.4 | 1 |
| XCMSOnline_NovDec22_CombinedAprMayAndNovDecParameters | 1725 | 249 | 0 | 102 | 80 | 5.91% | pos | seconds | centWave | 10 | 10 | 16.8,84.5 | -0.001 | 3 | 100 | 800 | obiwarp | 1 | density | 5 | 0.019 | 0.4 | 2 |
| XCMSOnline_NovDec22_CombinedSettings_NoiseLower | 2286 | 301 | 0 | 169 | 147 | 7.39% | pos | seconds | centWave | 10 | 6 | 16.8,84.5 | -0.001 | 3 | 100 | 400 | obiwarp | 1 | density | 5 | 0.019 | 0.4 | 2 |
| XCMSOnline_NovDec22_CombinedSettings_NoiseLower_v2 | 1622 | 3 | 0 | 189 | 131 | 11.65% | pos | seconds | centWave | 10 | 6 | 10,90 | 0.005 | 3 | 100 | 400 | obiwarp | 1 | density | 5 | 0.019 | 0.5 | 1 |
| XCMSOnline_NovDec22_CombinedSettings_NoiseLower_V3 | 699 | 0 | 0 | 241 | 121 | 34.48% | pos | seconds | centWave | 10 | 10 | 5,90 | -0.0081 | 3 | 100 | 400 | obiwarp | 1 | density | 5 | 0.019 | 0.4 | 1 |
| XCMSOnline_NovDec22_CombinedSettings_NoiseLower_V4 | 3564 | 0 | 0 | 794 | 538 | 22.28% | pos | seconds | centWave | 47 | 6 | 5,90 | -0.0081 | 3 | 100 | 400 | obiwarp | 1 | density | 5 | 0.026 | 0.4 | 1 |
| XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25 | 9901 | 0 | 0 | 4206 | 3931 | 42.48% | pos | seconds | centWave | 47 | 6 | 5,90 | -0.0081 | 3 | 100 | 400 | obiwarp | 1 | density | 5 | 0.026 | 0.25 | 1 |

The features were filtered using the custom R script, `/Metabolomics/bin/ProcessingXCMSOutput-Automated.R`.

Individual graphs and datasets can be found in the corresponding XCMS Online output folder:`/Metabolomics/NovDec22/XCMS/Online`

I used the XCMS parameters in `/Metabolomics/NovDec22/XCMS/Online/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25` for the +ve mode analysis, as this identified the most features without a significant number identified within the first 60 seconds. Features then identified in the Blank group were removed from the dataset (to remove contaminants).

I have previously tried other XCMS results in MetaboAnalyst, but the number of features dropped off and were often from the first 60 seconds. The results from the metaboanalyst analysis can be found here:

-> `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis`

-> `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/10_BlankGroup_171123_Analysis`.

## MetaboAnalyst

Once processed using the filtering R script, data were uploaded to MetaboAnalyst, normalised (using the Sodium formate peak), log transformed and scaled (pareto scaling).

### Positive mode Preliminary Analysis

All results saved here: `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25`.

First, I just took the MetaboAnalyst_Input.csv, where all groups and timepoints were separated and loaded it in MetaboAnalyst. I then normalised the data to the sodium_formate peaks, pareto scaled and log transformed. Next, I performed an ANOVA, with raw p value <0.05, FDR adjusted p value = 0.18457. This generated 618 significant features out of 2291 features.

I generated heatmaps from these to see how the samples grouped:

Clustered using all features | Clustered using sig 618 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesAllSamplesAllGroups/AllFeaturesAllSamples_Clustered.svg) | ![clustered using sig 618 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesAllSamplesAllGroups/Sig618FeaturesAllSamples_Clustered.svg)

Interestingly a lot of the significant features with the same profile, they also have similar masses and retention times... likely adducts?

All results were saved here: `/Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/NoGrouping-AllSamples`

I noticed a group of outlier samples:

- F9.4
- BLANK_2
- C12.1
- F12.3
- D15.1
- D15.3
- D15.4
- F15.1
- F15.3

As a result, and considering the symptom development in plants by the third time point. I will exclude these samples from the analysis (except BLANK_2), and will remove the third time point entirely.

Further, I can see that the samples dont follow a normal distribution. I tried a few different apporoaches and none worked. I think this is due to the group of outlier samples.

Normalised distribution of features | Normalised distribution of samples
:-------:|:-------:
![Normalised distribution of features](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesAllSamplesAllGroups/norm_0_dpi72.png) | ![Normalised distribution of samples](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesAllSamplesAllGroups/snorm_0_dpi72.png)

---

#### Removing outliers

I removed the outliers and processed the data again. This time I identified 657 significant features (p <0.05, FDR Adjusted = 0.17364).

Clustered using all features | Clustered using sig 657 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroups/AllFeaturesRedSamplesRedGroups.svg) | ![clustered using sig 657 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroups/Sig657FeaturesRedSamplesRedGroups..svg)

Now looking at the clustering, samples mostly cluster by time. There are some outliers, especially among the controls,  but there is an overall trend to time points.

Normalised distribution of features | Normalised distribution of reduced samples
:-------:|:-------:
![Normalised distribution of features](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroups/norm_0_dpi72.png) | ![Normalised distribution of reduced samples](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroups/snorm_0_dpi72.png)

The output can be found here: `/Users/u1983390/Downloads/AllFeaturesRedSamplesRedGroups`.

This "improved" the overall clustering and reduced the second peak in the distribution of samples, but a few outliers remain. I'm going to leave these in. I can explain them in the text and I don't want to have 1 sample groups.  

### Grouping by time point

As clustering the reduced sample set produces a general clustering pattern based on time point, I'm going to focus on each time point individually and then look at whats shared.
I'm not going to include the third time point due to the number of outliers and severity of symptoms.

For each analysis, I ensured that data were normally distributed (followed appropriate normalisation steps). I then Performed an ANOVA to identify sig. features (raw p <0.05), and generated a PCA using all features using the following input file: `/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesAllSamplesAllGroups/MetaboAnalyst_Input-TimeOnly.csv`. Following this, I generated heatmaps for each different grouping:
I removed the outliers and third time point from this set.

- Default
- Samples not clustered
- Only sig features

Data were normalised and scaled as previously, and ANOVA perfromed to identify significant features (p < 0.05). Number of significant features is 251 (FDR adjusted p value = 0.44499).

Clustered using all features | Clustered using sig 251 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesByTimePoint/AllFeaturesRedSamplesByTimePoint.svg) | ![clustered using sig 251 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesByTimePoint/Sig251FeaturesRedSamplesByTimePoint.svg)

Output was saved: `/Metabolomics/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesByTimePoint`

Next, I wanted to look at how the samples are distributed using this feature set among treatments at each specific time point.

To separate by timepoint, I duplicated the `MetaboAnalyst_Input.csv` three times, and deleted the rows which were not from that timepoint. I kept the QC and Blank group, `Other`.

- MetaboAnalyst_Input-FirstTimePoint.csv  
- MetaboAnalyst_Input-SecondTimePoint.csv

I think I will have to narrow down at a particular time point of interest, find features there, and see if they appear over time.

#### First Time point only

---

Data were normalised and scaled as previously, and ANOVA perfromed to identify significant features (p < 0.05). Number of significant features is 336 (FDR adjusted p value = 0.33183).

Clustered using all features | Clustered using sig 336 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint/AllFeaturesRedSamplesFirstTimePoint.svg) | ![clustered using sig 251 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint/Sig336FeaturesRedSamplesFirstTimePoint.svg)

Output was saved: `/Metabolomics/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint`.

#### Second Time point only

---

I identified 178 significant features with P = 0.05, FDR adjusted = 0.58178.

Clustered using all features | Clustered using sig 178 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedGroupsSecondTimePoint/AllFeaturesRedGroupsSecondTimePoint.png) | ![clustered using sig 178 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedGroupsSecondTimePoint/Sig178FeaturesRedGroupsSecondTimePoint.svg)

Output was saved: `Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/SecondTimePoint-AllSamples`.

There are fewer significant features at this time point. I'm wondering if this is due to the similarity of symptoms? Interestingly Control clusters separately, and Fusarium and drought does too - xvm seems to be spread among drought and Fusarium.

---

### Venn Diagram of shared sig features over time

A list of significant features was used to generate a Venn Diagram to identify which of these significant features are shared over time. After copying and pasting a list of the significant features into a `csv` file, I used [`SharedFeaturesVenn.R`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/SharedFeaturesVenn.R) to build the Venn diagram.

![venn of shared features](/docs/figures/SharedFeaturesVenn_Time.png)

*Figure 1: Venn of the shared features between timepoints when using p<0.05 for each timepoint individually. T1 = first time point, T2 = second time point, T3 = third time point.*

22 of the significant features identified were shared between all time points.

- M367.15T410.425
- M567.43T1421.35
- M832.307T992.353
- M449.365T1540.699
- M668.509T1456.373
- M898.349T936.403
- M519.225T1025.439
- M438.146T926.75
- M618.492T1624.789
- M956.379T959.199
- M660.517T1423.005
- M564.206T918.312
- M817.32T1025.439
- M593.49T1539.529
- M593.49T1490.213
- M593.485T1401.37
- M555.454T1439.586
- M869.334T919.017
- M564.208T942.149
- M592.477T1439.652
- M547.402T1437.709
- M593.49T1557.453

### Features of interest

I was mindful of the shared features which were identified in using the [Venn diagram](#venn-diagram-of-shared-sig-features-over-time). Its better to look for features which appear over a longer time period as targets for biomarkers. No point having a marker that can only be used for a day or so, and it narrows down the number of features to process! Below is a table of the significant features that are shared between two time points.

**A lot of these features have really early retention times...?**


I plugged the `.mzXML` files into XCMS online to see whats going on with the data and see if the online version is better at identifying more features with later retenetion times.

### MetaboAnalyst Secondary Analysis

Once the significant features were identified (raw p <0.05), I separated these from the original input file using the [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py). This reduced the set of features that can be uploaded to MetaboAnaylst.

For this, I symlinked the original MetaboAnalyst input file to the MetaboAnalyst output directory for each timepoint, I manually generated a csv file listing the columns to extract for that timepoint (significant (p <0.05) features identified by preliminary anova)(including sodium_formate and text), and used them as input for [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py).

```bash
# generate csv of features to extract
touch  SecondTimePointSigFeaturesList.csv
# I then pasted the data manually for them the MetaboAnalyst anova_posthoc.csv file. 

# extract columns command
ExtractColumns.py SecondTimePointSigFeaturesList.csv MetaboAnalyst_Input-SecondTimePoint.csv > MetaboAnalyst_Input-SecondTimePoint_Sig71Features.csv
```

I then edited the csv file so only one time point (corresponding to the dir) were present in the csv.

####  MetaboAnalyst thresholds

I think it would now be interesting to look at pairwise comparisons of these significant features, how do we distinguish Foc from Con or Dro at T1, T2, and T3; or Foc from Xvm at T2 - considering symptom scores overlap?

To do this I performed a pairwise comparison of each group to control at T2, then built a Venn diagram to see what is sig compared to control at T2 in each treatment. I chose T2 because of symptom score overlap for Xvm and Foc.

- Normalised  by reference feature (Sodium Formate) and log transformed (base 10).
- FC threshold > 1.0 and always Treatment/Control
- For t-test, group variance was set to `Unequal` for Dro v Con and Foc v Con, as one of the Con and one of the Xvm samples was removed pre IPO, and i used raw P value of 0.05
- For volcano plots I used the same FC and statistical significance tests and thresholds.
- Also generated a PCA and labeled the samples, as well as a dendrogram and heatmap  (euclidean dist and ward clustering)

Time | Pairwise | Fold change   | No. of Sig features
:---:|:--------:|:-------------:|:-------------------:
T2   |Dro v Con | 12 up, 20 down| 3
T2   |Foc v Con | 10 up, 22 down| 10
T2   |Xvm v Con | 15 up, 17 down| 3

#### Venn Diagram of shared features from control vs treatment pairwise comparisons T2

![venn of shared features from con v treatment pairwise comparisons](figures/Pairwise_SharedFeaturesVenn.png)

*Figure 2: Venn of the shared significant (p<0.05) features between treatments T2. Using the significant features from the previous ANOVA, each treatment was compared to the control for a pairwise analysis. Significant features were extracted and then shared features were identified using `SharedFeaturesVenn.R`. Dro = significant features (p <0.05) from drought vs control pairwise analysis; Foc = significant features (p <0.05) from Fusarium vs control pairwise analysis; Xvm = significant features (p <0.05) from Xanthomonas vs control pairwise analysis.*

Of these features, **M830.837T11.111** was identified a significantly different from the control in every treatment (shared feature in centre of Venn), and may be a marker of wilting/water stress. **But, it has a retention time of 11.111?**

**M883.492T15.092** was identified a significantly different from the control in the drought and Fusarium treatments and has a similar mass and retention time to **M831.338T16.12**, which was identified as [a feature of interest](#features-of-interest) from the comparison of significant features over time.

---

### Time as a factor
