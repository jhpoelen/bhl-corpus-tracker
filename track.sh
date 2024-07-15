#!/bin/bash
#
# Tracks pdf content associated with 
# provided container title as indexed by the 
# Biodiversity Heritage Library
#

# track pdfs related to a container title in the BHL "part" index

set -x

title=${1:-Revue suisse de zoologie}

track_part_index() {
  local partIndex="https://biodiversitylibrary.org/data/part.txt"
  preston track "${partIndex}"
}

track_part_pdfs() {
  preston track -f <(preston ls\
   | grep "part.txt"\
   | grep hasVersion\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f PartID\
   | sed 's+^+https://www.biodiversitylibrary.org/partpdf/+g'\
   | tail -n+2\
   | head)
}

#track_part_index
track_part_pdfs
