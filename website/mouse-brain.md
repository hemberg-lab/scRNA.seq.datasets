## Usoskin
* [Usoskin, D. et al. Unbiased classification of sensory neuron types by large-scale single-cell RNA sequencing. Nat. Neurosci. 18, 145–153 (2015)](http://dx.doi.org/10.1038/nn.3881)

* [Supporting data](http://linnarssonlab.org/drg/)

!!! note
    [Excel file](https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/drg/Usoskin%20et%20al.%20External%20resources%20Table%201.xlsx) was downloaded from the [Supporting data](http://linnarssonlab.org/drg/) and converted to `csv` format on 07/02/2017. The resulting `csv` file is stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/Usoskin+et+al.+External+resources+Table+1.csv) and is used to generate the `scater` object and the report.

|Accession|Units|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE59739](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE59739)|RPMs|25334 features<br>622 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/process-data/usoskin.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/create-scater/usoskin.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/usoskin.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/usoskin.html)|

<hr>
## Zeisel
* [Zeisel, A. et al. Brain structure. Cell types in the mouse cortex and hippocampus revealed by single-cell RNA-seq. Science 347, 1138–1142 (2015)](http://dx.doi.org/10.1126/science.aaa1934)

* [Supporting data](http://linnarssonlab.org/cortex/)

|Accession|Units|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE60361](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60361)|UMIs|19972 features<br>3005 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/process-data/zeisel.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/create-scater/zeisel.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/zeisel.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/zeisel.html)|
