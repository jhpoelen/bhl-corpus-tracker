#!/bin/bash
#
# takes a random sample from 5 bhl-blr-titles 
# and tracks 10 randomly selected pdfs for each of them,
# totalling 50 prospective zenodo records.

set -xe

SAMPLE_DIR=target/$(uuidgen)
SCRIPT_DIR="../.."
THIS_SCRIPT="${PWD}/$0"

mkdir -p "${SAMPLE_DIR}"

cd "${SAMPLE_DIR}"

# track this script
#preston track "file://${THIS_SCRIPT}"

cat "${SCRIPT_DIR}/titles.txt"\
 > titles.txt

${SCRIPT_DIR}/index.sh

cat titles.txt\
 | xargs -I '{}' ../../ls-parts.sh '{}'\
 | tail -n+2\
 | tee parts.txt

preston track --algo md5 -f <(cat parts.txt | sed "s/part/partpdf/g")

#${SCRIPT_DIR}/ls-zenodo.sh\
# | tee zenodo.json
