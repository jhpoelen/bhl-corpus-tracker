#!/bin/bash
#
# Track amd package pdfs related to a container title in the BHL "part" index
#
# assumes that a BHL parts index is already available in the Preston archive.
#

#set -x

title=${1:-Revue suisse de zoologie}

>&2 echo "list parts of BHL container with title [${title}]"

list_parts() {
  preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f PartID\
   | sed 's+^+https://www.biodiversitylibrary.org/part/+g'
}

list_parts
