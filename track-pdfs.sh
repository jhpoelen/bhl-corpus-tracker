#!/bin/bash
#
# Track amd package pdfs related to a container title in the BHL "part" index
#
# assumes that a BHL parts index is already available in the Preston archive.
#

set -x

title=${1:-Revue suisse de zoologie}

>&2 echo "track and package BHL container with title [${title}]"

track_part_pdfs() {
  preston track --algo md5 -f <(preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f PartID\
   | sed 's+^+https://www.biodiversitylibrary.org/partpdf/+g'\
   | tail -n+2)
}

track_part_pdfs
