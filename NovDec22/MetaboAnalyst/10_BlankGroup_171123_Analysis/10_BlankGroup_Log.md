# MetaboAnalyst analysis of the 10_BlankGroup_171123 dataset.

_So far only positive mode analysed._

Once processed using the filtering R script, data were uploaded to MetaboAnalyst, normalised (using the approach which produced the best normal distribution - typically this included normalizing by the Sodium Formate peak).

---

### MetaboAnalyst Preliminary Analysis

All results saved here: `/Metabolomics/NovDec22/MetaboAnalyst`. For each analysis, I ensured that data were normally distributed (followed appropriate normalisation steps), then generated heatmaps for each different grouping:

- Default
- Samples not clustered
- only significant features

Performed an ANOVA to identify sig. features (raw p <0.05), and generated a PCA using all features using the following input file: `/Metabolomics/NovDec22/XCMS/10_BlankGroup_171123/MetaboAnalyst_Input-TimeGroups.csv`.

I used the `edit groups` feature  in MetaboAnalyst to separate each group and process them all individually.

Most XCMS outputs produced heatmaps which did not cluster by default sample groups. Some samples commonly displayed a different feature profile from most other samples within that treatment/time group. The samples are;

- C9-4
- D9-3
- F9-1
- X15-3
- C12-1
- F9-4
- D12-2

I have found that the best way to ensure that the heatmap clusters into groups, is to separate by time and remove blanks and QCs. In this way, significant features group the samples by treatment.

**The first time point separates treatment groups best, by the second and third time points feature profiles between the samples can vary a lot within a treatment group**. But the symptoms overlap between between Foc and Xvm best at second time point.

I think I will have to narrow down at a particular time point of interest, find features there, and see if they appear over time.

[Going to also look at time as a factor and not treatment](#time-as-a-factor).

---

### Venn Diagram of shared sig features over time

A list of significant features was used to generate a Venn Diagram to identify which of these significant features are shared over time.

![venn of shared features](/docs/figures/Time_SharedFeaturesVenn.png)

*Figure 1: Venn of the shared features between timepoints when using p<0.05 for each timepoint individually. T1 = first time point, T2 = second time point, T3 = third time point.*

None of the significant features identified were shared between all time points. More significant features are shared between the first time point and the third timepoint, than between the second and first and second and third. The majority of the significant features were not shared between timepoints.

---

### MetaboAnalyst Secondary Analysis

Once the significant features were identified (raw p <0.05), I separated these from the original input file using the [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py). This reduced the set of features that can be uploaded to MetaboAnaylst. I normalised and generated heatmaps, dendrograms, feature plots and PCAs for only the significant features, so analysis such as PCA will not be skewed by features that are not significant (p <0.05).

For this, I symlinked the original MetaboAnalyst input file to the MetaboAnalyst output directory for each timepoint, I manually generated a csv file listing the columns to extract for that timepoint (significant (p <0.05) features identified by preliminary anova)(including Sodium_formate and text), and used them as input for [`ExtractColumns.py`](https://github.com/JamiePike/UntargetedMetabolomics/blob/main/bin/ExtractColumns.py).

```bash
# example of command line for previous step - this shows the first time point.
# symlink file
ln -s /Metabolomics/NovDec22/XCMS/10_BlankGroup_171123/MetaboAnalyst_Input.csv ./

# generate csv of features to extract
touch Extract-sig_features_0.05.csv
# I then pasted the data manually for them the MetaboAnalyst anova_posthoc.csv file. 

# extract columns command
python ../../../bin/ExtractColumns.py Extract-sig_features_0.05.csv MetaboAnalyst_Input.csv > MetaboAnalyst_sig_features_0.05.csv
```

I then edited the csv file so only one time point (corresponding to the dir) were present in the csv.

I then uploaded the new csv which contains only the significant features for that time point to MetaboAnalyst, and repeated the initial analysis.

### Features of interest

I was mindful of the shared features which were identified in using the [Venn diagram](#venn-diagram-of-shared-sig-features-over-time). Its better to look for features which appear over a longer time period as targets for biomarkers. No point having a marker that can only be used for a day or so, and it narrows down the number of features to process!

>I think the features which are shared between T1 and T3 are curious, why are they not identified as sig. in the middle timepoint? It appears to be all the same metabolite whose adducts have not been automatically identified using CAMERA and XCMS and filtered out. They all; similar retention time, similar mass, same profile in heatmap.

| Feature             |Share | Viability | Tukey's HSD | Notes
|:-------------------:|:----:|:---------:|:-----------:|:-----
|**M1279.087T13.111** |T1-T2 | low       |      -      |Shared as a significant feature between T1 and T2, and is reduced in Xvm and Foc treatments (average), but increased in Con and  Dro.
|**M882.812T18.125**  |T1-T2 | high      |T1: dro_9-con_9; foc_9-dro_9| Also shared between T1 and T2 and is reduced in Xvm and Foc, but increased in Dro and Con.
|**M1239.758T16.118** |T1-T2 | low       |T1: foc_9-dro_9| The 3 Foc samples varied in peak intensity for this feature dramatically (F9_1 = -1.13; F9_2 = 1.72; F9_3 = 1.92), so this does not appear to be a stable feature to use as a biomarker.
|**M632.472T1474.795**|T1-T3 |   mid     |      -      | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M633.474T1424.866**|T1-T3 |   mid     |      -      | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M634.485T1424.862**|T1-T3 |   mid     |T1: xvm_9-foc_9  | Elutes at same time with similar mass and same profile in heatmap at T1. Probably adducts of same feature. Why this one detected in Tukey's HSD but not others?
**M648.465T1441.075**|T1-T3 |    mid     |      -      | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M649.479T1424.057**|T1-T3 |    mid     |      -     | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M650.482T1423.88** |T1-T3 |    mid     |      -     | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M573.464T1458.338**|T1-T3 |    mid     |      -     | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M575.48T1424.867** |T1-T3 |    mid     |      -     | Elutes at same time with very similar mass and same profile in heatmap at T1. Probably adducts of same feature.
|**M367.151T397.982** |T2-T3 |    low       |T3: xvm_15-con_15| Increased in Xvm and one Dro sample but appears to be reduced in all other treatments.
|**M831.338T16.12**   |T2-T3 |   low      |      -     | This is a sig feature shared between T1 and T3, but appears to be an adduct of M835.826T17.121, which is a sig feature at T3 and separates Xvm for all other treatments.

---

I think it would now be interesting to look at pairwise comparisons of these significant features, how do we distinguish Foc from Con or Dro at T1, T2, and T3; or Foc from Xvm at T2 - considering symptom scores overlap?

To do this I performed a pairwise comparison of each group to control at T2, then built a Venn diagram to see what is sig compared to control at T2 in each treatment. I chose T2 because of symptom score overlap for Xvm and Foc.

####  MetaboAnalyst thresholds

- Normalised  by reference feature (Sodium Formate) and log transformed (base 10).
- FC threshold > 1.0 and always Treatment/Control
- For t-test, group variance was set to `Unequal` for Dro v Con and Foc v Con, as one of the Con and one of the Xvm samples was removed pre IPO, and i used raw P value of 0.05
- For volcano plots I used the same FC and statistical significance tests and thresholds.
- Also generated a PCA and labeled the samples, as well as a dendrogram and heatmap  (euclidean dist and ward clustering)

|Time | Pairwise | Fold change   | No. of Sig features |
|:---:|:--------:|:-------------:|:-------------------:|
|T2   |Dro v Con | 12 up, 20 down| 3                   |
|T2   |Foc v Con | 10 up, 22 down| 10                  |
|T2   |Xvm v Con | 15 up, 17 down| 3                   |

#### Venn Diagram of shared features from control vs treatment pairwise comparisons T2

![venn of shared features from con v treatment pairwise comparisons](figures/Pairwise_SharedFeaturesVenn.png)

*Figure 2: Venn of the shared significant (p<0.05) features between treatments T2. Using the significant features from the previous ANOVA, each treatment was compared to the control for a pairwise analysis. Significant features were extracted and then shared features were identified using `SharedFeaturesVenn.R`. Dro = significant features (p <0.05) from drought vs control pairwise analysis; Foc = significant features (p <0.05) from Fusarium vs control pairwise analysis; Xvm = significant features (p <0.05) from Xanthomonas vs control pairwise analysis.*

Of these features, **M830.837T11.111** was identified a significantly different from the control in every treatment (shared feature in centre of Venn), and may be a marker of wilting/water stress. **But, it has a retention time of 11.111?**

**M883.492T15.092** was identified a significantly different from the control in the drought and Fusarium treatments and has a similar mass and retention time to **M831.338T16.12**, which was identified as [a feature of interest](#features-of-interest) from the comparison of significant features over time.

---

### Time as a factor
