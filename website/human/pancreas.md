## Baron
* [Baron, M. et al. A Single-Cell Transcriptomic Map of the Human and Mouse Pancreas Reveals Inter- and Intra-cell Population Structure. Cell Syst 3, 346–360.e4 (2016)](http://dx.doi.org/10.1016/j.cels.2016.08.011)

|Accession|Protocol|Size|Scripts|Download|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE84133](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE84133)|[inDrop](http://dx.doi.org/10.1016/j.cell.2015.04.044)|20125 features<br>8569 samples |[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/baron.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/baron.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/baron-human.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/baron-human.html)|

<hr>
## Muraro
* [Muraro, M. J. et al. A Single-Cell Transcriptome Atlas of the Human Pancreas. Cell Syst 3, 385–394.e3 (2016)](http://dx.doi.org/10.1016/j.cels.2016.09.002)

!!! note
    Cell type annotations were obtained from Mauro Muraro on 02/03/17 and are stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/muraro/cell_type_annotation_Cels2016.csv).

|Accession|Protocol|Size|Scripts|Download|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE85241](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE85241)|[CEL-Seq2](http://dx.doi.org/10.1186/s13059-016-0938-8)|19140 features<br>2126 samples |[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/muraro.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/muraro.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/muraro.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/muraro.html)|

<hr>
## Segerstolpe
* [Segerstolpe, Å. et al. Single-Cell Transcriptome Profiling of Human Pancreatic Islets in Health and Type 2 Diabetes. Cell Metab. 24, 593–607 (2016)](http://dx.doi.org/10.1016/j.cmet.2016.08.020)

|Accession|Protocol|Size|Scripts|Download|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[E-MTAB-5061](https://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-5061/)|[Smart-Seq2](http://dx.doi.org/10.1038/nprot.2014.006)|25525 features<br>3514 samples |[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/segerstolpe.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/segerstolpe.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/segerstolpe.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/segerstolpe.html)|

<hr>
## Wang
* [Wang, Y. J. et al. Single-Cell Transcriptomics of the Human Endocrine Pancreas. Diabetes 65, 3028–3038 (2016)](http://dx.doi.org/10.2337/db16-0405)

!!! warning
    Read alignment and gene expression quantification in this data were performed using [RNA-seq unified mapper (RUM)](https://doi.org/10.1093/bioinformatics/btr427). There are no zeros in the expression matrix (`fpkm` values) and the expression values are really large. Please take extra care when working with this dataset.

|Accession|Protocol|Size|Scripts|Download|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE83139](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE83139)|[SMARTer](http://www.clontech.com/US/Products/cDNA_Synthesis_and_Library_Construction/Next_Gen_Sequencing_Kits/Total_RNA-Seq/Universal_RNA_Seq_Random_Primed)|19950 features<br>635 samples |[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/wang.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/wang.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/wang.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/wang.html)|

<hr>
## Xin
* [Xin, Y. et al. RNA Sequencing of Single Human Islet Cells Reveals Type 2 Diabetes Genes. Cell Metab. 24, 608–615 (2016)](http://dx.doi.org/10.1016/j.cmet.2016.08.018)

!!! note
    Cell type and genes annotations were obtained from Yurong Xin on 28/03/17 and are stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/xin/human_islet_cell_identity.txt) and [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/xin/human_gene_annotation.csv) .

|Accession|Protocol|Size|Scripts|Download|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE81608](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE81608)|[SMARTer](http://www.clontech.com/US/Products/cDNA_Synthesis_and_Library_Construction/Next_Gen_Sequencing_Kits/Total_RNA-Seq/Universal_RNA_Seq_Random_Primed)|39851 features<br>1600 samples |[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/xin.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/xin.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/xin.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/xin.html)|
