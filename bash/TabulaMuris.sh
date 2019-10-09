# TabulaMuris - Mouse mini-Atlas 20 tissues
# Smartseq2 data: https://figshare.com/articles/_/5715040
# droplet data: https://figshare.com/articles/_/5715025
# Paper : https://www.biorxiv.org/content/early/2017/12/20/237446
# Transcriptomic characterization of 20 organs and tissues from mouse at single cell resolution creates a Tabula Muris

# FACS sorted -> Smartseq2
wget https://ndownloader.figshare.com/files/10038307
unzip 10038307
wget https://ndownloader.figshare.com/files/10038310
mv 10038310 FACS_metadata.csv
wget https://ndownloader.figshare.com/files/10039267
mv 10039267 FACS_annotations.csv


wget https://ndownloader.figshare.com/files/10038325
unzip 10038325
wget https://ndownloader.figshare.com/files/10038328
mv 10038328 droplet_metadata.csv
wget https://ndownloader.figshare.com/files/10039264
mv 10039264 droplet_annotation.csv
