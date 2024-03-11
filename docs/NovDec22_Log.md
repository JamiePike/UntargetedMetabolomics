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

Interestingly a lot of the significant features with the same profile, they also have similar masses and retention times. They could be adducts missed by CAMERA. 

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
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroups-IncludingQCs/AllFeaturesRedSamplesRedGroups.svg) | ![clustered using sig 657 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroups-IncludingQCs/Sig657FeaturesRedSamplesRedGroups..svg)

Now looking at the clustering, samples mostly cluster by time. There are some outliers, especially among the controls,  but there is an overall trend to time points.

The same is observed when I remove the `others` group and cluster using the remianing 633 significant features.

![significant 633 features](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/SigFeaturesRedSamplesRedGroups/heatmap_4_dpi72.pdf)

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

Data were normalised and scaled as previously, and ANOVA perfromed to identify significant features (p < 0.05).

*Including QCs*

Number of significant features is 336.

Clustered using all features | Clustered using sig 336 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint-IncludingQCs/AllFeaturesRedSamplesFirstTimePoint.svg) | ![clustered using sig 336 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint-IncludingQCs/Sig336FeaturesRedSamplesFirstTimePoint.svg)

*Excluding QCs*

Number of significant features is 232 (FDR adjusted p value = 0.477059).

Clustered using all features | Clustered using sig 233 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint/AllFeaturesRedSamplesFirstTimePoint.svg) | ![clustered using sig 232 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint/Sig232Features_heatmap_9_dpi72-ForThesis.pdf)

Output was saved: `/Metabolomics/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesFirstTimePoint`.

#### Second Time point only

---

*Including QCs*

I identified 178 significant features with P = 0.05, FDR adjusted = 0.58178.

Clustered using all features | Clustered using sig 178 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedGroupsSecondTimePoint-IncludingQCs/AllFeaturesRedGroupsSecondTimePoint.png) | ![clustered using sig 178 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedGroupsSecondTimePoint-IncludingQCs/Sig178FeaturesRedGroupsSecondTimePoint.svg)

*Excluding QCs*

I identified 171 significant features with P = 0.05, FDR adjusted = 0.58178.

![clustered using sig 171 features ](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroupsSecondTimePoint/Sig171FeaturesRedSamplesRedGroups-SecondTimePoint.png)

Output was saved: `Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/SecondTimePoint-AllSamples`.

There are fewer significant features at this time point. I'm wondering if this is due to the similarity of symptoms? Interestingly Control clusters separately, and Fusarium and drought does too - xvm seems to be spread among drought and Fusarium.

---

### Venn Diagram of shared sig features over time

A list of significant features was used to generate a Venn Diagram to identify which of these significant features are shared over time. After copying and pasting a list of the significant features into a `csv` file, I used [`SharedFeaturesVenn.R`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/SharedFeaturesVenn.R) to build the Venn diagram.

![venn of shared features](/docs/figures/SharedFeaturesVenn_Time.png)

*Figure 1: Venn of the shared features between timepoints when using p<0.05 for each timepoint individually. T1 = first time point, T2 = second time point, T3 = third time point.*

6 of the significant features identified were shared between both time points - which is really low. I don't think i can focus on these, as they are within the margin of error.

- M449.365T1540.699
- M438.146T926.75
- M832.307T992.353
- M956.379T959.199
- M869.334T919.017
- M433.152T909.874

It aligns well with the initial observation, that time was more of a distinguishing factor than treatment. I think, for that reason, I need to focus on a specifc time point - I chose the second time point. This is due to the overlap in external symptom score between Xvm and Foc.

Folder: `/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroupsSecondTimePoint`

### MetaboAnalyst Secondary Analysis

I separated the significant 171 features from the original input file using the [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py). This reduced the set of features that can be uploaded to MetaboAnaylst.

For this, I symlinked the original MetaboAnalyst input file to the MetaboAnalyst output directory for each timepoint, I manually generated a csv file listing the columns to extract for that timepoint (significant (p <0.05) features identified by preliminary anova)(including sodium_formate and text), and used them as input for [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py).

```bash
#move into the directory
cd /NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/AllFeaturesRedSamplesRedGroupsSecondTimePoint

# generate csv of features to extract
touch  Sig171FeaturesList.csv
open Sig171FeaturesList.csv
# I then pasted the data manually for them the MetaboAnalyst anova_posthoc.csv file. 

# extract columns command
python /Metabolomics/bin/ExtractColumns.py Sig171FeaturesList.csv MetaboAnalyst_Input-SecondTimePoint.csv > MetaboAnalyst_Input-SecondTimePoint-Sig171Features.csv 
```

Using the significant features at the second time point, where symptom score overlap for Foc and  Xvm, samples separate using the PCA.

![PCA of second time point sig features](/NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/Sig178FeaturesRedSamplesSecondTimePoint/Sig178FeaturesRedSamplesSecondTimePoint/pca_score2d_2_dpi72.png)

####  MetaboAnalyst thresholds

I think it would now be interesting to look at pairwise comparisons of these significant features and distinguish the different stresses when compared to the control.

To do this I performed a pairwise comparison of each group to control at T2, then built a Venn diagram to see what is significant compared to control at T2 in each treatment. I chose T2 because of symptom score overlap for Xvm and Foc.

- Normalised  by reference feature (Sodium Formate) and log transformed (base 10).
- FC threshold > 2.0 and always Treatment/Control
- For t-test, group variance was set to `Unequal` for as, unfortunetly, there was only two samples for the control group at this time point. I used raw P value of 0.05
- For volcano plots I used the same FC (2.0) and statistical significance tests (p <0.1).
- Also generated a PLSDA, as well as a dendrogram and heatmap  (euclidean dist and ward clustering)

Time | Pairwise | Fold change (treatment/control)   | No. of Sig features | Sig Up   | Sig Down
:---:|:--------:|:---------------------------------:|:-------------------:|:--------:|:--------:
T2   |Dro v Con | 15 up, 18 down| 48    |6      | 8
T2   |Foc v Con | 38 up, 30 down| 63    |23     | 19
T2   |Xvm v Con | 17 up, 22 down| 48    |10     | 13

#### Venn Diagram of shared features from control vs treatment pairwise comparisons T2

![venn of shared features from con v treatment pairwise comparisons](/docs/figures/Pairwise_SharedFeaturesVenn_SecondTimePoint.png)

*Figure 2: Venn of the shared significant (p<0.05) features between treatments T2. Using the significant features from the previous ANOVA, each treatment was compared to the control for a pairwise analysis. Significant features were extracted and then shared features were identified using `SharedFeaturesVenn.R`. Dro = significant features (p <0.05) from drought vs control pairwise analysis; Foc = significant features (p <0.05) from Fusarium vs control pairwise analysis; Xvm = significant features (p <0.05) from Xanthomonas vs control pairwise analysis.*

Next, I pulled out the significant features from each group to place in a Venn Diagram and look for shared/unique features. I used the [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py) script again.

```bash
# EXAMPLE:

#move into the directory
cd /NovDec22/MetaboAnalyst/XCMSOnline_NovDec22_CombinedSettingsETC_plus_MinFrac_0.25/Sig171FeaturesRedSamplesConVsDroSecondTimePoint-Pairwise

# generate csv of features to extract
touch  Sig48-ConVsDroPairwiseFeaturesList.csv
open  Sig48-ConVsDroPairwiseFeaturesList.csv
# I then pasted the data manually for them the MetaboAnalyst t_test.csv file. 

# extract columns command
python /Metabolomics/bin/ExtractColumns.py Sig48-ConVsDroPairwiseFeaturesList.csv MetaboAnalyst_Input-SecondTimePoint-Sig171Features.csv > MetaboAnalyst_Input-Sig48-ConVsDroPairwiseFeatures.csv 
```

#### Looking at features of interest

Potentially unique (n=18) Fusarium vs control features

*M585.283T918.479*
Feature that is significantly different from Foc vs mock and not identified as sig in the other datasets. It was significantly differerent in Foc vs all other second time point treatments when conduciting Tukeys pairwise on ANOVA data.
It had a log2FC of -1.1469 when compared to control.
Its a very small peak in the other samples however, with no obvious adducts to help with annotations... come back to this.

*M569.292T994.771*
Feature that is significantly different from Foc vs mock and not identified as sig in the other datasets. It was significantly differerent in Foc vs all other second time point treatments when conduciting Tukeys pairwise on ANOVA data.
It had a log2FC of -1.0769 when compared to control.
Again, peaks are vary small for this feature and finding adducts in the noise is a challenge.

*M331.187T1104.601*
Feature of interest but does not meet the FC thresholds.

*M629.464T1456.367*
Feature of interest but does not meet the FC thresholds.

*rt=1473*
Includes Features with 4 features with rt of around 1473, 3 features with the same rt have a FC >2.0 - However, there are features identified in DroVsFoc Venn set that also share the same rt, and have similar FC values to the features from rt=1473 that were identified as unique to Foc.

m/z of features that elute at 1473:

unique to Foc | unique to Xvm | Unique to dro | shared | xvm and foc | dro and foc| dro and xvm
:------------:|:-------------:|:-------------:|:------:|:-----------:|:----------:|:----------:
423.321       | 576.484       | none          | none   | 628.514     | 330.261    | -
629.459       | -             |   -           | -      | -           | 575.479    | -
605.416       | -             |   -           | -      | -           | -          | -
629.463       | -             |   -           | -      | -           | -          | -

628.514 had log2FC of 1.0525 in Xvm compared to control. M628.514T1473.756 was also found in the FC data for Foc compared to control, recording a log2FC of 1.2184.

Further, all the features of interest at this rt that are supposed to be unique to foc have very low peak intesities (~1000).

*M449.347T1490.033*
log2FC in Foc compared to mock of 1.0439, sig dif from Foc vs Mock and distinguishes Foc in the ANOVA - Tukeys. Lots of features at this rt in the ANOVA...
Again, intentity is low ~1000. I'll keep looking for larger peaks.

*M669.531T1507.08*
A feature with a m/z difference of 120 from feature M549.431T1507.08 669->549, which is the equivalent to the m/z of DMSO (dimethyl sulfoxide) + ACN ([M+CH3CN+H]+), included in elcetrospray solvents. M549.431T1507.08 was included in the shared group of features.

*M535.447T1540.43*
M575.481T1540.694 shared between drought and Foc. 575->535 loss of 40, which I cant find as a common adduct or contaminant. Identified as sig different in Foc compared to all other treatments in one-way ANOVA.
Log2FC of 1.2125 compared to the mock inoculated plants.
Another features identified at the same rt (1540.699) with m/z of 449. The difference is 86 (535->449), which doesn't appear as the m/z of anything on any common adducts or contaminants lists.
There is a further feature at rt=1540, which has a m/z of 468. 468- 449 = 19. m/z of 19 correspondes to M+H+K.
Otherwise, its just too low a peak intensity to really pull anything out. There's a lot of noise around it too.

*M516.411T1568.021*
Didn't have a log2FC recorded, so no sig fold change indicates it is not as good a biomarker.
Again, the peak intensity is 800, just above the noise.

*M578.503T1590.788*
Didn't have a log2FC recorded, so no sig fold change indicates it is not as good a biomarker.
Again, the peak intensity is 800, just above the noise. Its very challenging to predict what the feature might be and separate it (and adducts/fragments) from the noise effectively.

*M295.151T1624.873*
359-> 295 = 64. +64 is obvs weight of M+ACN+Na.
