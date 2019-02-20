## Welcome

This repo will hold **data definitions and preprocessing steps** that are necessary for analyses regarding Flemish Natura 2000 habitats and regionally important biotopes (RIBs).
The repo is set up with a special interest in the design, review and analysis of Natura 2000 habitat monitoring programmes at the Flemish scale.

**The repo is under construction.**

## Principles and guidelines

The repo is meant to fit the draft principles and setup in [this gsheet](https://docs.google.com/spreadsheets/d/18U4AmiMnnApbgQTnfWbeZ3dAH3_4ISxUob_SX-maKV8), for long-term N2K-HAB projects.

Regarding binary or text-format data: see [this list (under construction)](https://docs.google.com/spreadsheets/d/1E8ERlfYwP3OjluL8d7_4rR1W34ka4LRCE35JTxf3WMI) for metadata on dataset versions and for their source location.

The data, or the results of dataset-specific reading functions, are as much as possible internationalized:

- English names for types, environmental pressures, ...;
- English names for table headings (dataframe variables).

All functions in this repo read data from local folders:

- binary data sources are present in `../n2khab-binarydata` (this means that a folder `n2khab-binarydata` exists _next to this repository_).
These may also include _large_ text-format files, such as large rasters.
For the sake and ease of reproducibility, this folder may be uploaded to Zenodo as a whole once in a while (a few, yet unpublished datasets may also be published separately.)
Perhaps some datasets will receive a versioning system in the future, such as git LFS, if there is reason to suspect that the used versions will not be maintained in the source location in the long term.
The sources are supposed to be divided as:
    - `../n2khab-binarydata/10_input`: local copies of binary inputdata versions are to be put here;
    - `../n2khab-binarydata/20_generated`: generated binary data are put here by the code;
- data sources in text-format (not too large) are _versioned_ within this repository, in two folders:
    - `10_inputdata_textformat`: local copies of text-format inputdata versions are to be put here. Most of them come over from another repository;
    - `20_generateddata_textformat`: generated text-format data are put here by the code.
    
Each dataset is to be put in its *own subfolder* within one of the above folders.
The name of the subfolder is a fixed code (ID) according to the aforementioned [list](https://docs.google.com/spreadsheets/d/1E8ERlfYwP3OjluL8d7_4rR1W34ka4LRCE35JTxf3WMI).
As far as possible, the corresponding file(s) get the same name.

    
    
