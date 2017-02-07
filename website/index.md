## Introduction

This website contains a collection of publicly available datasets used by the [Hemberg Group](http://www.sanger.ac.uk/science/groups/hemberg-group) at the [Sanger Institute](http://www.sanger.ac.uk/).

## scater

We use [scater toolkit](http://bioconductor.org/packages/scater/) for quality control of scRNA-Seq data. For each dataset you can find both a scater object and a scater report.

## Contributions

We welcome contributions to our collection. Please create a pull request to our [GitHub repository](https://github.com/hemberg-lab/public-scrnaseq-datasets) providing the following information:

* `bash` script with downloading and processing instructions (should be put to `process-data` folder) with a corresponding name (we use the first author surname by default).
* `R` script file with the instruction on how to create a scater object (should be put to `create-scater` folder) with a corresponding name (we use the first author surname by default).

!!! note
    For the cell type information please use a column in the annotation table with the name `cell_type1`. If there are more than one cell type hierarchy please use `cell_type2`, `cell_type3` etc.

* Annotation information about the dataset, i.e. publication reference, units and size of the dataset. These should be added to `markdown` files in the website folder. As an example, please use existing entries. The annotation information will appear on this website.


