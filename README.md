## Welcome

To support _reproducible_ and _transparent_ analyses on Flemish Natura 2000 habitats and regionally important biotopes (RIBs), this repo provides **data-generating (preprocessing) workflows** as _scripts_ or _R markdown_.
More specifically, it generates _those_ processed data sources that are worth saving, consolidating and distributing as such -- these data sources are then defined with an ID for further use.
Providing readily processed datasets makes sense in the case of time-consuming calculations, despite the reproducibility given the availability of a preprocessing workflow.
Finally, the repo will also provide datachecks for the workflows (explicit checking of file integrity and version).

The repo is a companion to the R package **[n2khab](https://github.com/inbo/n2khab)**, which provides functions that return several datasets as standardized R-objects, as well as functions to do certain preprocessing steps.
So, if you're just looking for a standardized way of reading existing (raw or processed) data sources into R, look no further than the package!
That is, unless the data source is not yet covered there -> [contribute](#you-are-welcome-to-contribute) to this repo!

This repo is set up with a special interest in the design, review and analysis of Natura 2000 habitat monitoring programmes at the Flemish scale (each is a combination of multiple monitoring schemes).
But as defined in the beginning, the repo's scope is wider!
For more information, see the [n2khab-monitoring](https://github.com/inbo/n2khab-monitoring) repo (which centralizes planning and workflow documentation in N2KHAB monitoring).

The ultimate aim is to achieve open and reproducible data workflows. That is a prerequisite for qualifiable science, for sharing and for broad cooperation.



### Find your way: repository structure

This is the structure of the repo:

```
├── data                        <- Binary or large data! Copy needed data here. IGNORED by git.
    ├── 10_raw
    └── 20_processed            <- Either copy from a source location, or generate with code in src.
├── src                         <- Put scripts / R markdown files here.
    ├── generate_XXX            <- Put files together that focus on a common result.
    ├── generate_YYY
    └── miscellaneous           <- For your own preparatory scripts and notebooks.
├── n2khab-preprocessing.Rproj  <- RStudio project file
├── LICENSE
└── README.md
```

### You are welcome to contribute!

#### Managing data

Data sources evolve, and hence, data source versions succeed one another.
To ease reproducibility, the workflows in this and in associated repositories therefore work with _locally stored_ data sources.

For this repository, strictly follow the separate [document](https://github.com/inbo/n2khab-monitoring/blob/master/datamanagement.md) on data management, which also serves as an advice to N2KHAB project repositories.
A graphical scheme of data storage and versioning workflows is found [here](https://drive.google.com/open?id=1xZz9f9n8zSUxBJvW6WEFLyDK7Ya0u4iN).

Summarizing, this means:

- use the data source's default ID to name both the data source specific subfolder and the data source file(s) (before the extension).
This name is version-agnostic!
Versions can however be defined and checked for in a specific way.
- depending on the data source, its own folder is to be stored either under `n2khab_data/10_raw` or under `n2khab_data/20_processed`.
- the location of the `n2khab_data` folder is specific to your setup and always needs to be specified in workflows.

In a collaborative workflow (inside or outside of this repository, e.g. another N2KHAB project) it is recommended to **define a variable `datapath`** in a separate, user-specific script, 
e.g.:

```
datapath <- "my/absolute-or-relative/path/to/n2khab_data"
```

and feed the `datapath` variable to functions in the actual collaborative workflow.

Note that the [n2khab](https://github.com/inbo/n2khab) package holds some textual reference data files itself.
The code to reproduce those is part of the [n2khab](https://github.com/inbo/n2khab) repository.


#### Coding tools: it's never too late for learning!

When writing workflows (in `src`):

- please use `tidyverse`, `sf` and `raster` packages for data reading.
Discover the human-friendly way of coding a data processing pipeline through the use of [pipes](https://r4ds.had.co.nz/pipes.html)!
Organise data in R in a [tidy](https://r4ds.had.co.nz/tidy-data.html#tidy-data-1) way in order to avoid troubles later on.
Recommended resources to get started are:
    - [R for Data Science](https://r4ds.had.co.nz/)
    - [Geocomputation with R](https://geocompr.robinlovelace.net)
- have a quick look at the [tidyverse style guide](https://style.tidyverse.org/).
There you see how to style object, variable and function names, as well as the documentation.
At least keep in mind: **use lower case and 'snake_case'** for object, variable and function names.
- preferrably use `git2rdata::write_vc()` when an R _dataframe_ needs to be written to disk for later use (see <https://inbo.github.io/git2rdata/>).
Define the sorting order well (avoid ties) by using the `sorting` argument, in order to get meaningful _diffs_ when data are updated later.
The function stores the object in a version-control + R friendly format (tab separated values (.tsv) plus metadata on sorting order and variables (.yml)).
The R object can then be 100% recreated using `git2rdata::read_vc()`!!
- if your function returns a dataframe, use `dplyr::as_tibble()` to return it as a tibble instead.
A tibble is a dataframe that makes working in the tidyverse a little [easier](https://r4ds.had.co.nz/tibbles.html).


#### How can I contribute code?

More detailed info on git workflows at INBO: <https://inbo.github.io/tutorials/tags/git/>.
See also [these git workshop materials](https://inbo.github.io/git-course/index.html).

1. Make commits (in your local clone of the remote repo on Github) _in your own git branch_, branched off from the `master` branch.
(But see this in a relative manner: exactly the same process can be repeated by someone else in turn, relative to your branch.
So '`master`' in this protocol can be replaced by another branch name!)
You can push your branch to the remote as often as you like, as it will not influence other branches (first time: do `git push -u origin yourbranchname`; afterwards `git push` suffices). It serves as a backup and enables others to work with you on that branch.
1. Meanwhile, make sure that your branch stays up to date with evolutions in `master` (i.e. in your local repo, update `master` with `git checkout master && git pull` and then, with your own branch checked out again, do `git merge --no-ff master`), in order to prevent merge conflicts with `master` later on.
At this stage, you need to resolve any merge conflicts that may arise in your own branch.
1. Propose to merge your commits into `master`: this starts with making a 'pull request' (PR; actually this is a merge request) and assign at least one reviewer before a merge can be decided. At that moment, open online discussion in the repo is possible on your changes (for other open discussion that you want to start, make an _issue_). As long as no merge is performed, more commits can be added to this PR with `git push`, e.g. to implement requested changes by others.
    - note that, if you branched off another (reference) branch than `master`, make sure to change the reference branch in the pull request (the default reference is `master`).
1. After your PR is merged, pull the reference branch (usually `master`) and clean up your local repo in order to keep up with the remote.



### Repository history

Previous to commit `8990c23`, the code was part of the [n2khab-monitoring](https://github.com/inbo/n2khab-monitoring) repo (formerly 'n2khab-inputs'), where the original version history remains stored (and complete reproducibility is guaranteed).
As a convenience, the **n2khab-preprocessing** repo still holds the rewritten (shrinked) version history from before commit `8990c23`, as defined by the related files and folders.
See [this](https://github.com/inbo/n2khab-monitoring/issues/28) issue in the 'n2khab-monitoring' repo, where the migration is documented.


