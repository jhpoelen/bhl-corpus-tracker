[![SWH](https://archive.softwareheritage.org/badge/origin/https://github.com/jhpoelen/bhl-corpus-tracker/)](https://archive.softwareheritage.org/browse/origin/?origin_url=https://github.com/jhpoelen/bhl-corpus-tracker)

Automated workflows to programmatically list, track, and publish pdf corpora made available through Biodiversity Heritage Library.

The Biodiversity Heritage Library (BHL) contains hundreds of thousands of open access works related to biodiversity, ecology, taxonomy and other fields related to biology.

In addition to interactive web pages like https://biodiversitylibrary.org, BHL offers data products that help navigate their catalog of works, as well as their associated content in the form of PDFs or structured text files.

This repository contains *tools* (e.g., bash scripts) to help list and track works in biodiversity that that a common BHL container. These BHL contains group so-called "parts" of content that were part of the same journal, proceedings, or other kind of organizing principle.

These tools include:

1. [```index.sh```](index.sh) - track, download and version a copy of the BHL parts index as a Preston archive

2. [```ls-titles.sh```](ls-titles.sh) - uses a versioned copy of the BHL parts index to list titles of BHL containers from large to small. 

3. [```ls-parts.sh```](ls-parts.sh) - uses a versioned copy of the BHL parts index to all parts associated with titles in BHL containers. 

4. [```track-pdfs.sh```](track-pdfs.sh) - uses a versioned copy of the BHL parts index to package the content (e.g. PDFs) of a BHL container into a Preston archive.

5. [```publish.sh```](publish.sh) - publishes a packaged BHL container as a collection of Zenodo

## Example Data Publications

For an example of resulting versioned bhl corpus see:

> Poelen, J. H., & Agosti, D. (2025). A Versioned Literature Corpus derived from Biodiversity Heritage Library hash://md5/b3cd9de0685deeebf57a5d225e59c10f (Version 0.3) [Dataset]. Zenodo. https://doi.org/10.5281/zenodo.16616872

with abstract:

> Biodiversity Heritage Library (BHL, https://biodiversitylibrary.org) contains hundreds of thousands of digital works related to biodiversity. This publications contains a versioned snapshot of work metadata and the digital signatures of their associated pdfs as seen in period 2025-03-26/2025-06-25 . 

Also, if available, please see https://github.com/bhl-blr/bhl-blr.github.io and https://bhl-blr.github.io for example on how to present metadata associated with versioned bhl corpora in markdown or html respectively.
