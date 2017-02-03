wget -O data.tar \
'http://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE45719&format=file'
mkdir data
tar -C data -xvf data.tar
gunzip data/*

## raw reads
paste data/GSM111*_zy* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_zy.txt
sed -i '1s/reads/zy/g' reads_zy.txt
paste data/GSM111*_early2cell_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_early2cell.txt
sed -i '1s/reads/early2cell/g' reads_early2cell.txt
paste data/GSM111*_mid2cell_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_mid2cell.txt
sed -i '1s/reads/mid2cell/g' reads_mid2cell.txt
paste data/GSM111*_late2cell_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_late2cell.txt
sed -i '1s/reads/late2cell/g' reads_late2cell.txt
paste data/GSM111*_4cell_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_4cell.txt
sed -i '1s/reads/4cell/g' reads_4cell.txt
# 8cell files have a bit different notation
paste data/*_8cell_*-* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_8cell.txt
sed -i '1s/reads/8cell/g' reads_8cell.txt
paste data/GSM111*_16cell_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_16cell.txt
sed -i '1s/reads/16cell/g' reads_16cell.txt
paste data/GSM111*_earlyblast_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_earlyblast.txt
sed -i '1s/reads/earlyblast/g' reads_earlyblast.txt
paste data/GSM111*_midblast_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_midblast.txt
sed -i '1s/reads/midblast/g' reads_midblast.txt
paste data/GSM111*_lateblast_* | \
awk '{for (i = 4; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
reads_lateblast.txt
sed -i '1s/reads/lateblast/g' reads_lateblast.txt

awk -F"\t" '{if ($1) print $1}' data/GSM1112767_zy2_expression.txt > gene-names.txt

paste reads_*.txt > deng.txt
paste gene-names.txt deng.txt > deng-reads.txt
sed -i '1s/^#//' deng-reads.txt

## RPKMs
paste data/GSM111*_zy* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_zy.txt
sed -i '1s/RPKM/zy/g' rpkms_zy.txt
paste data/GSM111*_early2cell_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_early2cell.txt
sed -i '1s/RPKM/early2cell/g' rpkms_early2cell.txt
paste data/GSM111*_mid2cell_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_mid2cell.txt
sed -i '1s/RPKM/mid2cell/g' rpkms_mid2cell.txt
paste data/GSM111*_late2cell_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_late2cell.txt
sed -i '1s/RPKM/late2cell/g' rpkms_late2cell.txt
paste data/GSM111*_4cell_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_4cell.txt
sed -i '1s/RPKM/4cell/g' rpkms_4cell.txt
# 8cell files have a bit different notation
paste data/*_8cell_*-* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_8cell.txt
sed -i '1s/RPKM/8cell/g' rpkms_8cell.txt
paste data/GSM111*_16cell_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_16cell.txt
sed -i '1s/RPKM/16cell/g' rpkms_16cell.txt
paste data/GSM111*_earlyblast_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_earlyblast.txt
sed -i '1s/RPKM/earlyblast/g' rpkms_earlyblast.txt
paste data/GSM111*_midblast_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_midblast.txt
sed -i '1s/RPKM/midblast/g' rpkms_midblast.txt
paste data/GSM111*_lateblast_* | \
awk '{for (i = 3; i <= NF; i += 6) printf ("%s%c", $i, i + 6 <= NF ? "\t" : "\n");}' > \
rpkms_lateblast.txt
sed -i '1s/RPKM/lateblast/g' rpkms_lateblast.txt

paste rpkms_*.txt > deng.txt
paste gene-names.txt deng.txt > deng-rpkms.txt
sed -i '1s/^#//' deng-rpkms.txt
