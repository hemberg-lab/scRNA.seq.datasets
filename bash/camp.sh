# Liver Organoids - published
# Multilineage Communivation regulates human liver bud development from pluripotency - Camp et al. 2017
#GSE81252
#GSE40823

# scRNASeq
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81252/suppl/GSE81252_data.cast.log2.lineage.csv.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81252/suppl/GSE81252_data.cast.log2.liverbud.csv.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81252/matrix/GSE81252_series_matrix.txt.gz

gunzip GSE81252_data.cast.log2.lineage.csv.gz
gunzip GSE81252_data.cast.log2.liverbud.csv.gz
gunzip GSE81252_series_matrix.txt.gz
perl ../utils/parse_series_matrix.pl GSE81252_series_matrix.txt > GSE81252_Ann.txt

# bulk
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE40nnn/GSE40823/suppl/GSE40823_SpagnoliFM_RNASeq.FPKM.txt.gz
