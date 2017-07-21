# Human cerebral organoids + fetal neocortex
# SMARTer
# Camp JG, Badsha F, Florio M, Kanton S et al. Human cerebral organoids recapitulate gene expression programs of fetal neocortex development. Proc Natl Acad Sci U S A 2015 Dec 22;112(51):15672-7. PMID: 26644564
# GSE75140

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE75nnn/GSE75140/suppl/GSE75140_hOrg.fetal.master.data.frame.txt.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE75nnn/GSE75140/matrix/GSE75140_series_matrix.txt.gz

gunzip GSE75140_hOrg.fetal.master.data.frame.txt.gz
gunzip GSE75140_series_matrix.txt.gz

perl ~/Data_Processing_Scripts/parse_series_matrix.pl GSE75140_series_matrix.txt > Camp_Neurons_Series_Matrix.txt
