#!/bin/bash
#
# lists unique license / rights strings appearing in parts.txt 
#

preston cat --remote https://zenodo.org,https://linker.bio hash://md5/f235166f8cb094f56063680af4d1328a\
 | mlr --tsvlite cut -r -f RightsSt*,License*\
 | tail -n+2\
 | tr '\t' '\n'\
 | sort\
 | uniq 
