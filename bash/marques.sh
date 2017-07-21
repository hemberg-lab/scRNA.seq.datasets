# mouse juvenile & adult oligodendrocytes
# Marques et al. (2016) Oligodendrocyte heterogeneity in the mouse juvenile and adult central nervous system. 352(6291) 1326-1329 DOI: 10.1126/science.aaf6463

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE75nnn/GSE75330/suppl/GSE75330_Marques_et_al_mol_counts2.tab.gz
gunzip GSE75330_Marques_et_al_mol_counts2.tab.gz

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE75nnn/GSE75330/matrix/GSE75330_series_matrix.txt.gz
gunzip GSE75330_series_matrix.txt.gz
perl ~/Data_Processing_Scripts/parse_series_matrix.pl GSE75330_series_matrix.txt > Marq_Ann.txt
