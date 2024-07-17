#!/bin/bash
#
# Publishes the packaged BHL container content as Zenodo deposits.
#
# Assumes that a BHL parts index is already available in the Preston archive.
#

set -x

title=${1:-Revue suisse de zoologie}

echo "publish content associated with BHL container with title [${title}]"

#preston track "https://www.biodiversitylibrary.org/data/RIS/bhlpart.ris.zip"

#curl "https://www.biodiversitylibrary.org/data/RIS/bhlpart.ris"\
# | head -n100\
# | preston track

preston head\
 | preston cat\
 | grep hasVersion\
 | preston ris-stream
