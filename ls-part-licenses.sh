#!/bin/bash
#
# lists part id and rights/license pairs
#

parts() {
  preston cat --remote https://zenodo.org,https://linker.bio hash://md5/f235166f8cb094f56063680af4d1328a
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
 <(part-pairs LicenseUrl)
}
 

join -t $'\t'\
 <(part-pairs-concat | tail -n+2 | sort -t $'\t' -s -k 1b,1)\
 <(cat license-map.tsv | tail -n+2 | sort -t $'\t' -s -k 1b,1)\
 | cut -f2,3\
 | sed 's+^+<urn:lsid:biodiversitylibrary.org:part:+g'\
 | sed 's+\t+> <http://purl.org/dc/elements/1.1/license> <+g'\
 | sed 's+$+> .+g'\
 | grep -v "<https://spdx.org/licenses/NA>"\
 | grep -v "<https://spdx.org/licenses/>"
