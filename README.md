List, track, and publish pdf corpora made available through Biodiversity Heritage Library.

The Biodiversity Heritage Library (BHL) contains hundreds of thousands of open access works related to biodiversity, ecology, taxonomy and other fields related to biology.

In addition to interactive web pages like https://biodiversitylibrary.org, BHL offers data products that help navigate their catalog of works, as well as their associated content in the form of PDFs or structured text files.

This repository contains tools to help list and track works in biodiversity that that a common BHL container. These BHL contains group so-called "parts" of content that were part of the same journal, proceedings, or other kind of organizing principle.

These tools include:

1. [```index.sh```](index.sh) - track, download and version a copy of the BHL parts index as a Preston archive

2. [```ls.sh```](ls.sh) - uses a versioned copy of the BHL parts index to list titles of BHL containers from large to small. 

3. [```ls-parts.sh```](ls-parts.sh) - uses a versioned copy of the BHL parts index to all parts associated with titles in BHL containers. 

4. [```package.sh```](package.sh) - uses a versioned copy of the BHL parts index to package the content (e.g. PDFs) of a BHL container into a Preston archive.

5. [```publish.sh```](publish.sh) - publishes a packaged BHL container as a collection of Zenodo
