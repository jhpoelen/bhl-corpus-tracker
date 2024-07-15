#!/bin/bash
#
# make a list BHL container titles (e.g., journal, proceeding) ordered by descending number of parts (e.g., articles) they contain
#
# assumes that a BHL part index has previously been tracked.
#

preston ls\
 | grep part.txt\
 | grep hasVersion\
 | head -1\
 | preston cat\
 | mlr --tsvlite count -g ContainerTitle\
 | mlr --tsvlite sort -nr 'count'
