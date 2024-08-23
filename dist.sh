#!/bin/bash
#
# first BHL items their citations are tracked. 
# then pdfs associated with the provided titles
# are tracked and appended to the provenance log
# per title.
# 
#
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
 | xargs -L1 -I{} ${SCRIPT_DIR}/track-pdfs.sh "{}"

#${SCRIPT_DIR}/ls-zenodo.sh\
# | tee zenodo.json
