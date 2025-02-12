# mapmetadata

 *Mapping from variables to concepts*

<a href="https://aim-rsf.github.io/mapmetadata/"><img src="man/figures/logo.png" align="right" height="121" alt="mapmetadata website" /></a>

<!-- badges: start -->
[![All Contributors](https://img.shields.io/badge/all_contributors-6-orange.svg?style=flat-square)](#contributors-) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10581500.svg)](https://zenodo.org/records/14605021)

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![R-CMD-check](https://github.com/aim-rsf/mapmetadata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aim-rsf/mapmetadata/actions/workflows/R-CMD-check.yaml)
[![pkgcheck](https://github.com/aim-rsf/mapmetadata/workflows/pkgcheck/badge.svg)](https://github.com/aim-rsf/mapmetadata/actions?query=workflow%3Apkgcheck) [![codecov](https://codecov.io/gh/aim-rsf/mapmetadata/graph/badge.svg?token=59S2QVG7CQ)](https://codecov.io/gh/aim-rsf/mapmetadata) [![Status at rOpenSci Software Peer Review](https://badges.ropensci.org/674_status.svg)](https://github.com/ropensci/software-review/issues/674)
<!-- badges: end -->

## What is the `mapmetadata` package?

For researchers working with health datasets, there are many great resources that summarise features about these datasets (often termed metadata) and how to access them. Access to metadata can help researchers plan projects prior to gaining full access to health datasets. Learn more about health metadata in our [Health Metadata article hosted on the package website](https://aim-rsf.github.io/mapmetadata/articles/HealthMetadata.html).

One comprehensive open resource is the [Health Data Research Gateway](https://healthdatagateway.org/search?search=&datasetSort=latest&tab=Datasets), managed by [Health Data Research UK](https://www.hdruk.ac.uk/) in collaboration with the [UK Health Data Research Alliance](https://ukhealthdata.org/). The gateway can help a researcher address questions such as: *What datasets are available? What are the features of these datasets? Which datasets fit my research? How do I access these datasets? How have these datasets been used by the community before, and do they link to others? What publications, or other resources exist, using these datasets?* 

This `mapmetadata` package uses structural metadata files, downloaded from the Health Data Research Gateway. In theory, any metadata file with the same structure as the the files downloaded from this gateway can be used with this package. The `mapmetadata` package goes beyond just browsing structural metadata, and helps a researcher interact with this metadata and map it to their research domains/concepts. Firstly, it creates a plot (see example below) displaying number of variables in each table, number of tables, and the completeness of the metadata (i.e. whether the description for each variable in a table exists). 

Secondly, it helps the researcher address the question *Which variables map onto with my research domains?*  (e.g. socioeconomic, childhood adverse events, diagnoses, culture and community). The package guides users in mapping each variable into predefined research domains. Research domains could otherwise be called concepts or latent variables. To speed up this manual mapping process, the package automatically categorises variables that frequently occur in health datasets (e.g. ID, Sex, Age). The package also accounts for variables that appear across multiple tables within a dataset and allows users to copy their categorisations to ensure consistency. The output files can be used in later analyses to filter and visualise variables by category.

## Getting started with `mapmetadata`

### Installation and set-up

Run in the R console:

``` r
install.packages("pak")
pak::pak("aim-rsf/mapmetadata")
```

Load the library:

``` r
library(mapmetadata)
```

### Demo (using the `R Studio` IDE)

For a longer more detailed demo, see the [mapmetadata tutorial](https://aim-rsf.github.io/mapmetadata/articles/mapmetadata.html) page on the package website. 

There are three main functions you can interact with: `metadata_map()`, `map_compare()`, and `map_convert()`. For more information on any function, type `?function_name`. 

Run it in demo mode using the files located in the [inst/inputs](https://github.com/aim-rsf/mapmetadata/tree/main/inst/inputs) directory:

``` r
metadata_map()
``` 
In the R console you should see:

```
ℹ Running demo mode using package data files
ℹ Using the default look-up table in data/look-up.rda
ℹ Processing dataset '360_NCCHD' containing 13 tables

ℹ A bar plot should have opened in your browser (also saved to your project directory).
Use this bar plot, and the information on the HDRUK Gateway, to guide your mapping approach.

Enter the table number you want to process: 
```

You can exit here (with Clt-C or Esc) to just get this summary plot, which is saved to your project directory. All outputs from this `metadata_map` function are saved to your project directory. You can change the save location by adjusting the `output_dir` argument (an argument means the information given to a function, to alter how it runs). For example `metadata_map(output_dir = 'username/sub_directory)`.

<img src="https://raw.githubusercontent.com/aim-rsf/mapmetadata/main/inst/outputs/BAR_360_NCCHD_2024-12-19-14-11-55.png" alt="example bar plot showing number of variables for each table alongside counts of whether variables have missing descriptions">

If you continue, the function will ask you to pick a table in the dataset. In demo mode, the function processes only the first 20 variables from the selected table. Follow the on-screen instructions, and categorise variables into research domains, using the Plot tab as your reference. The demo will simplify domains for ease of use; in a real scenario, you can define more specific domains. For more tips on these mapping steps, see the [mapmetadata tutorial](https://aim-rsf.github.io/mapmetadata/articles/mapmetadata.html) page on the package website. 

## Using a custom metadata input (recommended)

You can run `metadata_map()` with a custom metadata file instead of the demo input file, to map metadata from a different dataset. Currently, the recommended way of retrieving these metadata files is to download them from [Health Data Research Gateway](https://healthdatagateway.org/en/search?type=datasets). Browse for the dataset you want, click on it to move to its main page, click on 'Download data' and select 'Structural Metadata' - this file is your metadata file input. 

To use this download with `metadata_map()`, the metadata file name is expected to be 'ID_Name_Metadata.csv' with 'ID' and 'Name' being changed depending on the specific dataset download. For example, the demo metadata file used in this package is [360_NCCHD_Metadata.csv](inst/inputs/360_NCCHD_Metadata.csv), with 360 being the ID given by HDRUK Gateway and NCCHD being the abbreviation for the dataset name (National Community Child Health Database).

```r
new_file <- "path/ID_Name_Metadata.csv"
demo_domains_file <- system.file("inputs/domain_list_demo.csv", package = "mapmetadata")

metadata_map(metadata_file = new_file, domain_file = demo_domains_file)
```

## Using a custom domain list input (recommended)

You can replace the default demo domains with research-specific domains. Remember any domain file input will have Codes 0, 1, 2 and 3 automatically appended to the start of the domain list, so do not include these in your domain list. 

## Using a custom lookup table input (advanced)

The lookup table governs the automatic categorisations. If you modify the [default lookup file](https://github.com/aim-rsf/mapmetadata/blob/main/inst/inputs/look_up.csv), ensure that all domain codes in the lookup file are also included in your domain file for valid outputs.

## Tips and future steps

- If you're processing multiple tables, save all outputs in the same directory to enable table copying. This feature will speed up categorisation and ensure consistency.
- You can compare categorisations across researchers using the `map_compare()` function.
- Use the output file from the `metadata_map()` function as input for subsequent analysis to filter and visualise variables by research domain.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](https://github.com/aim-rsf/mapmetadata/blob/main/LICENSE.md) file for details.  
For more information, refer to [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Citation

To cite `mapmetadata` in publications:

> Stickland R (2025). mapmetadata: map health metadata onto predefined research domains. R package version 3.0.0.

A BibTeX entry for LaTeX users:

```r         
  @Manual{,
    title = {mapmetadata: map health metadata onto predefined research domains},
    author = {Rachael Stickland},
    year = {2025},
    note = {R package version 3.0.0},
    doi = {https://doi.org/10.5281/zenodo.10581499}, 
  }
```

## Contributing

We welcome contributions to `mapmetadata`. Please read our [Contribution Guidelines](https://github.com/aim-rsf/mapmetadata/blob/main/CONTRIBUTING.md) for details on how to contribute.

-   **Report Issues**: Found a bug? Have a feature request? Report it on [GitHub Issues](https://github.com/aim-rsf/mapmetadata/issues).
-   **Submit Pull Requests**: Follow our [Contribution Guidelines](https://github.com/aim-rsf/mapmetadata/blob/main/CONTRIBUTING.md) for pull requests.
-   **Feedback**: Share your thoughts by opening an issue.

### Contributors ✨

Thanks go to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://linkedin.com/in/rstickland-phd"><img src="https://avatars.githubusercontent.com/u/50215726?v=4?s=100" width="100px;" alt="Rachael Stickland"/><br /><sub><b>Rachael Stickland</b></sub></a><br /><a href="#content-RayStick" title="Content">🖋</a> <a href="https://github.com/aim-rsf/mapmetadata/commits?author=RayStick" title="Documentation">📖</a> <a href="#maintenance-RayStick" title="Maintenance">🚧</a> <a href="#ideas-RayStick" title="Ideas, Planning, & Feedback">🤔</a> <a href="#projectManagement-RayStick" title="Project Management">📆</a> <a href="https://github.com/aim-rsf/mapmetadata/pulls?q=is%3Apr+reviewed-by%3ARayStick" title="Reviewed Pull Requests">👀</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://batool-almarzouq.netlify.app/"><img src="https://avatars.githubusercontent.com/u/53487593?v=4?s=100" width="100px;" alt="Batool Almarzouq"/><br /><sub><b>Batool Almarzouq</b></sub></a><br /><a href="#userTesting-BatoolMM" title="User Testing">📓</a> <a href="https://github.com/aim-rsf/mapmetadata/pulls?q=is%3Apr+reviewed-by%3ABatoolMM" title="Reviewed Pull Requests">👀</a> <a href="#ideas-BatoolMM" title="Ideas, Planning, & Feedback">🤔</a> <a href="#projectManagement-BatoolMM" title="Project Management">📆</a> <a href="https://github.com/aim-rsf/mapmetadata/commits?author=BatoolMM" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Rainiefantasy"><img src="https://avatars.githubusercontent.com/u/43926907?v=4?s=100" width="100px;" alt="Mahwish Mohammad"/><br /><sub><b>Mahwish Mohammad</b></sub></a><br /><a href="#userTesting-Rainiefantasy" title="User Testing">📓</a> <a href="https://github.com/aim-rsf/mapmetadata/pulls?q=is%3Apr+reviewed-by%3ARainiefantasy" title="Reviewed Pull Requests">👀</a> <a href="#ideas-Rainiefantasy" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/DDelbarre"><img src="https://avatars.githubusercontent.com/u/108824056?v=4?s=100" width="100px;" alt="Daniel Delbarre"/><br /><sub><b>Daniel Delbarre</b></sub></a><br /><a href="#ideas-DDelbarre" title="Ideas, Planning, & Feedback">🤔</a> <a href="#userTesting-DDelbarre" title="User Testing">📓</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/NidaZiaS"><img src="https://avatars.githubusercontent.com/u/142920412?v=4?s=100" width="100px;" alt="NidaZiaS"/><br /><sub><b>NidaZiaS</b></sub></a><br /><a href="#ideas-NidaZiaS" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://masalmon.eu/"><img src="https://avatars.githubusercontent.com/u/8360597?v=4?s=100" width="100px;" alt="Maëlle Salmon"/><br /><sub><b>Maëlle Salmon</b></sub></a><br /><a href="#ideas-maelle" title="Ideas, Planning, & Feedback">🤔</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://allcontributors.org/) specification. Contributions of any kind are welcome!

## Acknowledgements ✨

Thanks to the [MELD-B research project](https://www.southampton.ac.uk/publicpolicy/support-for-policymakers/policy-projects/Current%20projects/meld-b.page) and the [SAIL Databank](https://saildatabank.com/) team for ideas and feedback. Thanks to the [Health Data Research Gateway](https://healthdatagateway.org/en), and the participating data providers, for hosting open metadata.

This project is funded by the NIHR Artificial Intelligence for Multiple Long-Term Conditions (AIM) programme (NIHR202647). The views expressed are those of the author(s) and not necessarily those of the NIHR or the Department of Health and Social Care.

