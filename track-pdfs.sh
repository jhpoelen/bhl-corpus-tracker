#!/bin/bash
#
# Track amd package pdfs related to a container title in the BHL "part" index
#
# assumes that a BHL parts index is already available in the Preston archive.
#

set -x

title=${1:-Revue suisse de zoologie}

>&2 echo "track and package BHL container with title [${title}]"

track_part_pdfs() {
  preston track --algo md5 -f <(preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f PartID\
   | sed 's+^+https://www.biodiversitylibrary.org/partpdf/+g'\
   | tail -n+2)
}

#
# Some BHL part item pdfs are not available via https://www.biodiversitylibrary.org/partpdf/[PartID]
# but through some url specified in ExternalUrl 
# This function tracks pdfs associated with ExternalUrls hosted by biodiversitylibrary.org 
#
# https://github.com/bio-guoda/preston/issues/331
#

track_part_pdf_biodiversitylibrary_alternates() {
  preston track --algo md5 -f <(preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f ExternalUrl\
   | tail -n+2\
   | sed 's/[ ]/%20/g'\
   | grep 'biodiversitylibrary.org')
}

register_part_pdf_biodiversitylibrary_alternates() {
  preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite filter '$ExternalUrl =~ ".*biodiversitylibrary.org.*"' then cut -f PartID,ExternalUrl\
   | tail -n+2\
   | sed 's/[ ]/%20/g'\
   | sed -E 's%^([0-9]+)%<https://www.biodiversitylibrary.org/partpdf/\1>%'\
   | sed -E "s+\t+ <http://www.w3.org/ns/prov#alternateOf> <+g"\
   | sed 's/$/> ./g'\
   | preston append --algo md5
}

track_part_pdf_scielo_alternates() {
  preston track --algo md5 -f <(preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite filter '$ExternalUrl =~ ".*scielo[.].*"' then cut -f ExternalUrl\
   | tail -n+2\
   | sed 's/sci_arttext/sci_pdf/g')
}

register_part_pdf_scielo_alternates() {
  preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite filter '$ExternalUrl =~ ".*scielo[.].*"' then cut -f PartID,ExternalUrl\
   | tail -n+2\
   | sed 's/sci_arttext/sci_pdf/g'\
   | sed -E 's%^([0-9]+)%<https://www.biodiversitylibrary.org/partpdf/\1>%'\
   | sed -E "s+\t+ <http://www.w3.org/ns/prov#alternateOf> <+g"\
   | sed 's/$/> ./g'\
   | preston append --algo md5
}


track_item_pdfs() {
  preston track --algo md5 -f <(preston ls --algo md5\
   | grep "part.txt"\
   | grep hasVersion\
   | head -1\
   | preston cat\
   | mlr --tsvlite filter -s title="${title}" '$ContainerTitle == @title'\
   | mlr --tsvlite cut -f ItemID\
   | sed 's+^+https://www.biodiversitylibrary.org/itempdf/+g'\
   | tail -n+2\
   | sort\
   | uniq)
}

#track_part_pdfs

register_part_pdf_biodiversitylibrary_alternates
track_part_pdf_biodiversitylibrary_alternates

register_part_pdf_scielo_alternates
track_part_pdf_scielo_alternates

#track_item_pdfs
