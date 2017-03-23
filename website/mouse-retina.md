## Macosko
* [Macosko, E. Z. et al. Highly Parallel Genome-wide Expression Profiling of Individual Cells Using Nanoliter Droplets. Cell 161, 1202–1214 (2015)](http://dx.doi.org/10.1016/j.cell.2015.05.002)

* [Supporting data](http://mccarrolllab.com/dropseq/)
* [Manual data](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html?prefix=manual-data/macosko/)

!!! note
    Proper gene names were downloaded from Ensembl Biomart on 01/03/2017 and are stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/macosko/mart_export.txt). Cell labels were downloaded from [here](http://mccarrolllab.com/dropseq/) on 22/02/2017 and are stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/macosko/retina_clusteridentities.txt).

|Accession|Protocol|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE63473](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63473)|[Drop-seq](http://dx.doi.org/10.1016/j.cell.2015.05.002)|23288 features<br>44808 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/macosko.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/macosko.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/macosko.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/macosko.html)|

<hr>
## Shekhar
* [Shekhar, K. et al. Comprehensive Classification of Retinal Bipolar Neurons by Single-Cell Transcriptomics. Cell 166, 1308–1323.e30 (2016)](http://dx.doi.org/10.1016/j.cell.2016.07.054)

* [Supporting data](https://portals.broadinstitute.org/single_cell/study/retinal-bipolar-neuron-drop-seq)
* [Manual data](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html?prefix=manual-data/shekhar/)

!!! note
    To create a scater object we followed instructions from [BCanalysis.pdf](https://github.com/broadinstitute/BipolarCell2016) file. We did <b>NOT</b> perform the batch correction. Cell labels were downloaded from [here](https://portals.broadinstitute.org/single_cell/study/retinal-bipolar-neuron-drop-seq) on 22/02/2017 and are stored [here](https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/shekhar/clust_retinal_bipolar.txt).

|Accession|Protocol|Size|Scripts|scater|Report|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[GSE81904](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE81904)|[Drop-seq](http://dx.doi.org/10.1016/j.cell.2015.05.002)|13166 features<br>27499 samples|[bash](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/bash/shekhar.sh)<br>[R](https://github.com/hemberg-lab/scRNA.seq.datasets/blob/master/R/shekhar.R)|[SCESet](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/shekhar.rds)|[html](https://scrnaseq-public-datasets.s3.amazonaws.com/scater-reports/shekhar.html)|
