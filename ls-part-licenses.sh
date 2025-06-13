#!/bin/bash
#
# ls-part-licenses.sh - lists BHL part id and rights/license pairs
#
# uses a versioned copy of https://biodiversitylibrary.org/data/part.txt as made available in:
#
# Poelen, J. H. (2025). A Versioned Literature Corpus derived from Biodiversity Heritage Library hash://md5/581141d3f4d1847c833d9e2aa64656f2 [Data set]. Zenodo. https://doi.org/10.5281/zenodo.15269300
#
#

set -x

SCRIPT_PATH="$(readlink -f $0)"
SCRIPT_DIR="$(dirname ${SCRIPT_PATH})"

parts() {
  # a versioned copy of https://biodiversitylibrary.org/data/part.txt
  preston cat --remote https://zenodo.org,https://linker.bio hash://md5/f235166f8cb094f56063680af4d1328a
}

license-map() {
  # see also
  # cat ${SCRIPT_DIR}/bhl-part-license-map.tsv 
  # as well as
  # https://codeberg.org/jhpoelen/bhl-corpus-tracker/raw/branch/main/bhl-part-license-map.tsv
  #
  preston cat --remote https://softwareheritage.org,https://linker.bio hash://sha256/5704812923bb422d3907580df5d530c1fdcd9bd2c5ed3cee181ab29c0afcf3ba
}  

part-pairs() {
  parts\
    | mlr --tsvlite cut -f PartID,"$1"\
    | mlr --tsvlite reorder -e -f PartID\
    | tail -n+2
}

part-pairs-concat() {
cat <(echo -e "verbatim\tPartID")\
 <(part-pairs RightsStatement)\
 <(part-pairs RightsStatus)\
 <(part-pairs LicenseName)\
 <(part-pairs LicenseUrl)\
 <(part-pairs ContributorName)
}
 

# first cache the bhl parts index
parts > /dev/null

join -t $'\t'\
 <(part-pairs-concat | tail -n+2 | sort -t $'\t' -s -k 1b,1)\
 <(license-map | tail -n+2 | sort -t $'\t' -s -k 1b,1)\
 | cut -f2,3\
 | sed 's+^+<urn:lsid:biodiversitylibrary.org:part:+g'\
 | sed 's+\t+> <http://purl.org/dc/elements/1.1/license> <+g'\
 | sed 's+$+> .+g'\
 | grep -v "<https://spdx.org/licenses/NA>"\
 | grep -v "<https://spdx.org/licenses/>"
