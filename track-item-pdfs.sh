#!/bin/bash
#
# Track amd package pdfs related to a container title in the BHL "part" index
#
# assumes that a BHL parts index is already available in the Preston archive.
#

set -x

track_item_pdfs() {
  preston track --algo md5 -f <(preston ls --algo md5\
   | grep "item.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite cut -f ItemID\
   | sed 's+^+https://www.biodiversitylibrary.org/itempdf/+g'\
   | tail -n+2\
   | sort\
   | uniq)
}
