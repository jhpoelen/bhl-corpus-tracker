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

cat "${SCRIPT_DIR}/bhl-blr-titles.txt"\
 > titles.txt

# track this script
preston track "file://${THIS_SCRIPT}"

${SCRIPT_DIR}/index.sh

cat titles.txt\
 | parallel ../../ls-parts.sh {1}\
 | tee parts.txt

preston track -f <(cat parts.txt | sed "s/part/partpdf/g")

${SCRIPT_DIR}/ls-zenodo.sh\
 | tee zenodo.json
