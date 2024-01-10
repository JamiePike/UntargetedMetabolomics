# Progress with NovDec data analysis

For all analysis I followed the protocol outlined in the Processing Metabolomics Data protocol: `/Volumes/Jamie_EXT/Projects/Metabolomics/docs`.

## IPO Runs

IPO was run twice;

- First with all samples (minus blanks)
- Then without the samples C12-2 and X12-4 (minus blanks)

Outputs can be found here, `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/IPO`.

## XCMS Runs

XCMS was run multiple times, first using the parameters from IPO, followed by changes to adjust the outputs. A summary file of these changes and outputs can be found; `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/XCMS/XCMS_Params.xlsx`.

### Filtering

The features were filtered using the custom R script, `/Volumes/Jamie_EXT/Projects/Metabolomics/bin/ProcessingXCMSOutput-Automated.R`.

Summary outputs were recorded in `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/XCMS/XCMS_Params.xlsx`.
Individual graphs and datasets can be found in the corresponding XCMS output folder.

## MetaboAnalyst

Once processed using the filtering R script, data were uploaded to MetaboAnalyst, normalise (using the approach which produced the best normal distribution - typically this included normalizing by the Sodium Formate peak).

Most XCMS outputs produced heatmaps which did not cluster by default sample groups. Some samples commonly displayed a different feature profile from most other samples within that treatment/time group. The samples are;

- C9-4
- D9-3
- F9-1
- X15-3
- C12-1
- F9-4
- D12-2

---

I have found that the best way to ensure that the heatmap clusters into groups, is to separate by time and remove blanks and QCs. In this way, significant features group the samples by treatment.

I think I will have to narrow down at a particular time point of interest, and find features there.

---

The first time point separates treatment groups best, by the second and third time points feature profiles between the samples can vary a lot within a treatment group. But the symptoms overlap between between Foc and Xvm best at second time point.

Going to also look at time as a factor and not treatment.

## MetaboAnalyst Preliminary Analysis

All results saved here: `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/MetaboAnalyst`. For each analysis, I ensured that data were normailly distributed (followed appropriate normalisation steps), then generated heatmaps for each different grouping:

- Deafult
- Samples not clustered
- only significant features

Performed an ANOVA to identify sig. features (raw p <0.05), and generated a PCA using all features using the following input file: `/Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/XCMS/10_BlankGroup_171123/MetaboAnalyst_Input-TimeGroups.csv`.

I used the `edit groups` feature  in MetaboAnalyst to separate each group and process them all individually.

## MetaboAnalyst Secondary Analysis

Once the significant features were identified (raw p <0.05), I separated these from the original input file using the [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py).

This reduced set of features can be uploaded to MetaboAnaylst again and normalised and we can generate heatmaps, dendograms, featuer plots and PCAs for only the signifcant features, so analysis such as PCA will not be skewed by features that are not significant (p <0.05).

For this, I symlinked the original MetaboAnalyst input file to the MetaboAnalyst output directory for each timepoint, I manually generated a csv file listing the columns to extract for that timepoint (significant (p <0.05) features identified by preliminary anova)(including Sodium_formate and text), and used them as input for [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py).

```bash
# example of command line for previous step - this shows the first time point.
# symlink file
ln -s /Volumes/Jamie_EXT/Projects/Metabolomics/NovDec22/XCMS/10_BlankGroup_171123/MetaboAnalyst_Input-TimeGroups.csv ./

# generate csv of features to extract
touch Extract-sig_features_0.05.csv
# I then pasted teh data manually for them the MetaboAnalyst anova_posthoc.csv file. 

# extact columns command
python ../../../bin/ExtractColumns.py Extract-sig_features_0.05.csv MetaboAnalyst_Input-TimeGroups.csv > MetaboAnalyst_sig_features_0.05.csv
```

I then uploaded the new csv which contains only the significant features for that time point to MetaboAnalyst, and repeated the initial anaylsis.

### Venn Diagram of shared sig features over time

The csv files generated for `ExtractColumns.py` contain a list of the signifcant features, we can use these lists to generate a Venn Diagramm of significant features which are shared over time.

![Figure 1: Venn of the shared features between timepoints when using p<0.05 for each timepoint individually. T1 = first time point, T2 = second time point, T3 = third time point](/docs/figures/SharedFeaturesVenn.png)

None of the significant features identified were shared between all time points. Interestingly, more signifcant features are shared between the first time point and the third timepoint, than between the second and first and second and third.
