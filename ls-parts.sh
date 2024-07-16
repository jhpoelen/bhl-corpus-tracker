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
  preston ls\
   | grep "part.txt"\
   | grep hasVersion\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'
}

list_parts
