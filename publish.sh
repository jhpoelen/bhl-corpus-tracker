#!/bin/bash
#
# Publishes the packaged BHL container content as Zenodo deposits.
#
# Assumes that a BHL parts index is already available in the Preston archive.
#

set -x

title=${1:-Revue suisse de zoologie}

echo "generate zenodo metadata content associated with BHL container with title [${title}]"

preston ls\
 | grep "bhlpart.ris.zip"\
 | grep hasVersion\
 | head -1\
 | preston ris-stream --community bhl-plazi-test\
 | tee zenodo-meta.json\
 | preston zenodo --community bhl-plazi-test
