#!/bin/bash
#
# version/track a versioned copy of the 
# Biodiversity Heritage Library (BHL)
# parts index and associated RIS formatted 
# references 
#

set -x

preston track\
 "https://biodiversitylibrary.org/data/part.txt"\
 "https://www.biodiversitylibrary.org/data/RIS/bhlpart.ris.zip"
