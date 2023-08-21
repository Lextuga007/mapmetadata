# About 

This repo contains a demo R package, written to help the initial process of mapping domains of interest (latent concepts) used in research, onto variables found in SAIL databank. As in, if a researcher has access to datasets within SAIL databank, how do they know which variables will be represent the concepts they care about for their research question? There is a lot of meta data already publically available on the [Health Data Research Gateway](https://web.www.healthdatagateway.org/search?search=&datasetSort=latest&tab=Datasets) and the connected [Metadata Catalogue](https://modelcatalogue.cs.ox.ac.uk/hdruk_live/). This demo package uses this meta data.

## Install 

Download/clone this repository to your computer.

Install required packages: `devtools`, `gridExtra`, `grid`, `tidyverse`, `insight`

Then in the R console run:

`library(devtools)`

`load_all("/path-to-repo/browse-SAIL/browseSAIL")`

`library(browseSAIL)`

## Example run through 
Run `?domain_mapping` in the R console to find the documentation.

Follow the example in the documentation!

Remember to browse through the Plots tab during this example. There are 3 plots that will give you necessary information & context for the categorisations. 
<img width="886" alt="plots_tab" src="https://github.com/aim-rsf/browse-SAIL/assets/50215726/82cff34b-6afa-471a-8b5c-47a27cc76d5c">

## The log file output

Running the function will output a log file with your decisions. An example log file output is shown below. The name of the log file will contain the date and time stamp. The log file will contain initials of the person making the catergorisations. For each Data Element (variable) in the DataAsset/Class, the log file will contain a 'Domain_code' which labels this variable as mapping onto one or more of the domains of interest. The idea would be that this log file could be loaded up, compared across users, and used as an input in later analysis steps when working out which variables can be used to represent which domains. 

<img width="949" alt="log_file_example" src="https://github.com/aim-rsf/browse-SAIL/assets/50215726/e6edc46c-f3ab-4447-aab9-222b95f91dd9">
