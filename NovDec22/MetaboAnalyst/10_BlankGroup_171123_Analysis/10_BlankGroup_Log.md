# MetaboAnalyst analysis of the 10_BlankGroup_171123 dataset.

_So far only positive mode analysed._

Once processed using the filtering R script, data were uploaded to MetaboAnalyst, normalised (using the approach which produced the best normal distribution - typically this included normalizing by the Sodium Formate peak).

---

Once processed using the filtering R script, data were uploaded to MetaboAnalyst, normalised (using the Sodium formate peak), log transformed and scaled (pareto scaling).

### Positive mode

### MetaboAnalyst Preliminary Analysis

All results saved here: `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis`.

First, I just took the MetaboAnalyst_Input.csv, where all groups and timepoints were separated and loaded it in MetaboAnalyst. I then normalised the data to the sodium_formate peaks, pareto scaled and log transformed. Next, I performed an ANOVA, with raw p value <0.05, FDR adjusted p value = 0.39688. This generated 143 significant features out of 1137 features.

I generated heatmaps from these to see how the samples grouped:

Clustered using all features | Clustered using sig 143 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/NoGrouping-AllSamples/AllSamplesClustered.svg) | ![clustered using sig 143 features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/NoGrouping-AllSamples/Sig143FeaturesClustered.svg)

Interestingly a lot of the significant features with the same profile, they also have similar masses and retention times... likely adducts?

All results were saved here: `/Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/NoGrouping-AllSamples`

### Grouping by time point

Taking all samples and timepoint groups does not produce any clear clustering. There is a lot of variation between samples within the same groups. In order to simplify the data analysis, I first wanted to look at time, and see if samples separate by time.

For each analysis, I ensured that data were normally distributed (followed appropriate normalisation steps). I then Performed an ANOVA to identify sig. features (raw p <0.05), and generated a PCA using all features using the following input file: `/Metabolomics/NovDec22/XCMS/10_BlankGroup_171123/MetaboAnalyst_Input-TimeGroups.csv`. Following this, I generated heatmaps for each different grouping:

- Default
- Samples not clustered
- only significant features (n=125, p <0.05, FDR adjustsed p = 0.43232)

Clustered using all features | Clustered using sig 125 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/Time-AllSamples/Heatmap_AllFeaturesClustered-Time.svg) | ![clustered using sig 143 features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/Time-AllSamples/Heatmap_Sig125FeaturesClustered-time.svg)

Most XCMS outputs produced heatmaps which did not cluster by default time groups. Some samples commonly displayed a different feature profile from most other samples within that treatment/time group, even when clustering only significant features.

I'm going to focus soley on time point going forward and remove blanks and QCs. In this way, significant features group the samples by treatment.

To separate by timepoint, I duplicated the `MetaboAnalyst_Input.csv` three times, and deleted the rows which were not from that timepoint. I kept the QC and Blank group, `Other`.

- MetaboAnalyst_Input-FirstTimePoint.csv  
- MetaboAnalyst_Input-ThirdTimePoint.csv
- MetaboAnalyst_Input-SecondTimePoint.csv

I think I will have to narrow down at a particular time point of interest, find features there, and see if they appear over time.

#### First Time point only

---

Data were normalised and scaled as previously, and ANOVA perfromed to identify significant features (p < 0.05). Number of significant features is 100 (FDR adjusted p value = 0.56393).

Clustered using all features | Clustered using sig 100 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/FirstTimePoint-AllSamples/AllFeatures-ClusteredFirstTimePoint.svg) | ![clustered using sig 100 features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/FirstTimePoint-AllSamples/Sig100Features-ClusteredFirstTimePoint.svg)

Output was saved: `Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/FirstTimePoint-AllSamples`.

#### Second Time point only

---

I identified 71 significant features with P = 0.05, FDR adjusted = 0.68135.

Clustered using all features | Clustered using sig 71 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/SecondTimePoint-AllSamples/AllFeatures-ClusteredSecondTimePoint.svg) | ![clustered using sig 71 features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/SecondTimePoint-AllSamples/Sig72Features-ClusteredSecondTimePoint.svg)

Output was saved: `Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/SecondTimePoint-AllSamples`.

There are a lot fewer significant features at this time point. Why? And how do I pull out more? I wanted to focus on this time point due to the symptom score overlap.

#### Third Time point only

---

I identified 146 significant features with P = 0.05, FDR adjusted = 0.39259.

Clustered using all features | Clustered using sig 146 features
:-------:|:-------:
![Clustered using all features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/ThirdTimePoint-AllSamples/AllFeatures-ClusteredAllSamples.svg) | ![Clustered using sig 146 features ](/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/ThirdTimePoint-AllSamples/Sig149Features-ClusteredAllSamples.svg)

Output was saved: `Metabolomics/NovDec22/MetaboAnalyst/05_EarlySamplesRemoved_121023_Analysis/ThirdTimePoint-AllSamples`.

Samples don't separate into treatment as well at this timepoint. I think it may be becuase some Plants were dead by now, especially in the drought treatment.

---

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

### Venn Diagram of shared sig features over time

A list of significant features was used to generate a Venn Diagram to identify which of these significant features are shared over time. After copying and pasting a list of the significant features into a `csv` file, I used [`SharedFeaturesVenn.R`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/SharedFeaturesVenn.R) to build the Venn diagram.

![venn of shared features](/docs/figures/Time-SharedFeaturesVenn.png)

*Figure 1: Venn of the shared features between timepoints when using p<0.05 for each timepoint individually. T1 = first time point, T2 = second time point, T3 = third time point.*

13 of the significant features identified were shared between all time points. More significant features are shared between the first time point and the third timepoint, than between the second and first and second and third,  but this is probbaly becuase the total number of siginifant features at each time point. The first time point had 100 sig features, the second had 71, and the third had 143. The majority of the significant features were not shared between timepoints.

### Features of interest

I was mindful of the shared features which were identified in using the [Venn diagram](#venn-diagram-of-shared-sig-features-over-time). Its better to look for features which appear over a longer time period as targets for biomarkers. No point having a marker that can only be used for a day or so, and it narrows down the number of features to process! Below is a table of the significant features that are shared between two or more time points.

**A lot of these features have really early retention times...?**

| **Shared all time points** | **First and second** | **First and third** | **Second and third** |
|---|---|---|---|
| M996.14T12.55 | M996.14T12.55 | M996.14T12.55 | M922.81T11.54 |
| M922.81T11.54 | M922.81T11.54 | M922.81T11.54 | M996.14T12.55 |
| M694.85T18.56 | M694.85T18.56 | M1183.77T11.73 | M1361.41T13.55 |
| M1199.76T12.55 | M1394.72T17.56 | M694.85T18.56 | M800.83T18.56 |
| M854.18T12.55 | M1121.45T12.55 | M1036.13T12.55 | M1199.76T12.55 |
| M953.15T13.55 | M680.86T11.54 | M1031.79T17.56 | M1092.78T17.56 |
| M834.82T18.56 | M1343.06T12.55 | M990.29T17.56 | M854.18T12.55 |
| M1361.41T13.55 | M1889.14T13.55 | M1206.44T13.04 | M1068.29T16.56 |
| M1068.29T16.56 | M1199.76T12.55 | M1199.76T12.55 | M989.8T17.56 |
| M1206.09T17.56 | M854.18T12.55 | M854.18T12.55 | M1814.39T13.55 |
| M989.8T17.56 | M1031.8T12.47 | M1108.78T17.55 | M694.85T18.56 |
| M1814.39T13.55 | M1137.11T17.55 | M953.15T13.55 | M1189.76T17.56 |
| M1092.78T17.56 | M1282.25T13.55 | M943.31T17.56 | M1206.09T17.56 |
|  | M953.15T13.55 | M1146.77T17.56 | M953.15T13.55 |
|  | M1334.74T12.55 | M1045.29T17.55 | M788.84T18.56 |
|  | M834.82T18.56 | M834.82T18.56 | M1310.08T13.55 |
|  | M392.9T19.57 | M1361.41T13.55 | M1220.5T13.6 |
|  | M1361.41T13.55 | M1312.74T17.56 | M834.82T18.56 |
|  | M1068.29T16.56 | M1068.29T16.56 | M1206.76T17.55 |
|  | M1206.09T17.56 | M938.31T16.56 |  |
|  | M536.9T12.55 | M1206.09T17.56 |  |
|  | M842.82T11.54 | M1034.29T16.62 |  |
|  | M989.8T17.56 | M1034.8T17.55 |  |
|  | M1008.13T17.48 | M989.8T17.56 |  |
|  | M1814.39T13.55 | M1510.46T13.05 |  |
|  | M831.83T17.56 | M1814.39T13.55 |  |
|  | M854.82T11.54 | M360.93T17.56 |  |
|  | M1363.73T17.55 | M956.3T17.56 |  |
|  | M1033.8T17.55 | M1048.79T12.55 |  |
|  | M1092.78T17.56 | M1463.45T13.55 |  |
|  |  | M745.85T17.56 |  |
|  |  | M1092.78T17.56 |  |

I plugged the `.mzXML` files into XCMS online to see whats going on with the data and see if the online version is better at identifying more features with later retenetion times. 