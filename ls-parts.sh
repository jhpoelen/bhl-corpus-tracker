#!/bin/bash
#
# Track amd package pdfs related to a container title in the BHL "part" index
#
# assumes that a BHL parts index is already available in the Preston archive.
#

#set -x


>&2 echo "list parts of indexed BHL container"

list_parts() {
  preston ls\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite cut -f PartID\
   | sed 's+^+https://www.biodiversitylibrary.org/part/+g'
}

list_parts
