#!/bin/bash

#Tidy the files for UM. 


mkdir -p QCs Blanks 09_Control 09_Drought 09_Fusarium 09_Xanthomonas 12_Control 12_Drought 12_Fusarium 12_Xanthomonas 15_Control 15_Drought 15_Fusarium 15_Xanthomonas


mv *QC* ./QCs/
mv *Blank* ./Blanks/
mv *C9-* ./09_Control/
mv *D9-* ./09_Drought/
mv *F9-* ./09_Fusarium/
mv *X9-* ./09_Xanthomonas/
mv *C12-* ./12_Control/
mv *D12-* ./12_Drought/
mv *F12-* ./12_Fusarium/
mv *X12-* ./12_Xanthomonas/
mv *C15-* ./15_Control/
mv *D15-* ./15_Drought/
mv *F15-* ./15_Fusarium/
mv *X15-* ./15_Xanthomonas/