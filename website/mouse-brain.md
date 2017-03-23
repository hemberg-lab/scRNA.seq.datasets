## Tasic
* [Tasic, B. et al. Adult mouse cortical cell taxonomy revealed by single cell transcriptomics. Nat. Neurosci. 19, 335–346 (2016)](http://dx.doi.org/10.1038/nn.4216)

* [Supporting data](http://casestudies.brain-map.org/celltax)
* [Manual data](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html?prefix=manual-data/tasic/)

!!! note
    All processed files were downloaded from [brain map website](http://casestudies.brain-map.org/celltax) on 22/02/2017. These files are stored [here](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html?prefix=manual-data/tasic/) and are used to generate the `scater` object and the report.

### Read counts

|Accession|Protocol|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE71585](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE71585)|[SMARTer](http://www.clontech.com/US/Products/cDNA_Synthesis_and_Library_Construction/Next_Gen_Sequencing_Kits/Total_RNA-Seq/Universal_RNA_Seq_Random_Primed)|24150 features<br>1679 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/tasic.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/tasic.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/tasic-reads.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/tasic-reads.html)|

### RPKMs

|Accession|Protocol|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE71585](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE71585)|[SMARTer](http://www.clontech.com/US/Products/cDNA_Synthesis_and_Library_Construction/Next_Gen_Sequencing_Kits/Total_RNA-Seq/Universal_RNA_Seq_Random_Primed)|24150 features<br>1679 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/tasic.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/tasic.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/tasic-rpkms.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/tasic-rpkms.html)|

<hr>
## Usoskin
* [Usoskin, D. et al. Unbiased classification of sensory neuron types by large-scale single-cell RNA sequencing. Nat. Neurosci. 18, 145–153 (2015)](http://dx.doi.org/10.1038/nn.3881)

* [Supporting data](http://linnarssonlab.org/drg/)
* [Manual data](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html?prefix=manual-data/usoskin/)

!!! note
    [Excel file](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/usoskin/Usoskin+et+al.+External+resources+Table+1.xlsx) was downloaded from the [Supporting data](http://linnarssonlab.org/drg/) and converted to `csv` format on 07/02/2017. The resulting `csv` file is stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/usoskin/Usoskin+et+al.+External+resources+Table+1.csv) and is used to generate the `scater` object and the report.

|Accession|Protocol|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE59739](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE59739)|[STRT-Seq](http://dx.doi.org/10.1038/nprot.2012.022)|25334 features<br>622 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/usoskin.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/usoskin.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/usoskin.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/usoskin.html)|

<hr>
## Zeisel
* [Zeisel, A. et al. Brain structure. Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq. Science 347, 1138–1142 (2015)](http://dx.doi.org/10.1126/science.aaa1934)

* [Supporting data](http://linnarssonlab.org/cortex/)
* [Manual data](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html?prefix=manual-data/zeisel/)

!!! note
    [Txt file](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/zeisel/expression_mRNA_17-Aug-2014.txt) was downloaded from the [Supporting data](http://linnarssonlab.org/cortex/) and on 22/02/2017. This file is used to generate the `scater` object and the report.

|Accession|Protocl|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE60361](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60361)|[STRT-Seq UMI](http://dx.doi.org/10.1038/nmeth.2772)|19972 features<br>3005 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/zeisel.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/zeisel.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/zeisel.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/zeisel.html)|
