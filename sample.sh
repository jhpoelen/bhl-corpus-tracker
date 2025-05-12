#!/bin/bash
#
# takes a random sample from 5 bhl-blr-titles 
# and tracks 10 randomly selected pdfs for each of them,
# totalling 50 prospective zenodo records.

set -xe

SAMPLE_DIR=target/$(uuidgen)
SCRIPT_DIR="../.."
THIS_SCRIPT="${PWD}/$0"
NUMBER_OF_SAMPLES="${1:-50}"

mkdir -p "${SAMPLE_DIR}"

cd "${SAMPLE_DIR}"

# track this script
preston track "file://${THIS_SCRIPT}"

${SCRIPT_DIR}/index.sh

${SCRIPT_DIR}/ls-parts.sh | shuf | head -n${NUMBER_OF_SAMPLES}\
 | tee parts.txt

preston track -f <(cat parts.txt | sed "s/part/partpdf/g")

${SCRIPT_DIR}/ls-zenodo.sh\
 | tee zenodo.json\
 | grep -f <(cat parts.txt | sed 's/$/"/g')\
 > zenodo-sample.json
