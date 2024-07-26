#!/bin/bash
#
# Publishes the packaged BHL container content as Zenodo deposits.
#
# Assumes that a BHL parts index is already available in the Preston archive.
# Also, the associated pdfs are assumed to be tracked in the same Preston archive.
#

communities=${1:-bhl-plazi-test-20240725}


set -x

>&2 echo "converting RIS stream into Zenodo record metadata"

preston ls\
 | grep hasVersion\
 | grep "bhlpart.ris.zip"\
 | head -1\
 | preston ris-stream --communities $communities
