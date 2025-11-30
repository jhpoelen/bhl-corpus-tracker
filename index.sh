#!/bin/bash
#
# version/track a versioned copy of the 
# Biodiversity Heritage Library (BHL)
# item and part indeces and associated RIS formatted 
# references 
#

set -x

preston track --algo md5\
 "https://biodiversitylibrary.org/data/part.txt"\
 "https://biodiversitylibrary.org/data/item.txt"\
 "https://www.biodiversitylibrary.org/data/RIS/bhlitem.ris.zip"\
 "https://www.biodiversitylibrary.org/data/RIS/bhlpart.ris.zip"
