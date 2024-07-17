#!/bin/bash
#
# Track amd package pdfs related to a container title in the BHL "part" index
#
# assumes that a BHL parts index is already available in the Preston archive.
#

set -x

title=${1:-Revue suisse de zoologie}

echo "track and package BHL container with title [${title}]"

track_part_pdfs() {
  preston track -f <(preston ls\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f PartID\
   | sed 's+^+https://www.biodiversitylibrary.org/partpdf/+g'\
   | tail -n+2\
   | head)
}

track_part_pdfs
