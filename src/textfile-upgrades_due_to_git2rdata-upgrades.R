# This script allows the conversion of vc-formatted files because of specific
# upgrades of the git2rdata package that change the way files are written.
# Its repository is at https://github.com/inbo/git2rdata

# The used functions run from the root of the repo

getwd()


# 2019-06-11
# -------------------------------------------------------------------
# Previous state of git2rdata: commit df1ba32
# Conversion to new state of git2rdata: commit 796ba98 (tag 0.0.5)

git2rdata::upgrade_data(path = "src/generate_habitatmap_stdized/habmap_correction")

