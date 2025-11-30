#!/bin/bash
#
# Publishes the packaged BHL container content as Zenodo deposits.
#
# Assumes that a BHL parts index is already available in the Preston archive.
# Also, the associated pdfs are assumed to be tracked in the same Preston archive.
#

communities=${1:-bhl-plazi-test-20250613}


set -x

>&2 echo "converting RIS stream into Zenodo record metadata"

preston ls --algo md5\
 | grep hasVersion\
 | grep "bhlpart.ris.zip"\
 | head -1\
 | preston ris-stream --algo md5 --communities $communities
