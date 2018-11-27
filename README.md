---
title: "readme: convert_tei-to-mods"
author: Till Grallert
date: 2018-11-27 09:05:52 +0200
ORCID: orcid.org/0000-0002-5739-8094
---

This repository contains XSLT stylesheets to extract bibliographic information in TEI files validating against the [OpenArabicPE schema](https://github.com/OpenArabicPE/OpenArabicPE_ODD) and convert convert this data into MODS.

The [MODS (Metadata Object Description Schema) standard](http://www.loc.gov/standards/mods/) is expressed in XML and maintained by the [Network Development and MARC Standards Office](http://www.loc.gov/marc/ndmso.html) of the Library of Congress with input from users. Compared to BibTeX MODS has he advantage of being properly standardised, human and machine readable, and much better suited to include all the needed bibliographic information.

OpenArabicPE maintains a number of [XSLT stylesheets to automatically generate MODS XML files](https://github.com/OpenArabicPE/convert_tei-to-mods) from TEI sources:

1. `Tei2Mods-articles.xsl`: generates one MODS file for each article and section of a periodical issue.
2. `Tei2Mods-issues.xsl`: generates one MODS file per periodical issue, comprising entries for every article and section.

# MODS as intermediary format

MODS also serves as the intermediary format for the free [bibutils suite](https://sourceforge.net/projects/bibutils/) of conversions between bibliographic metadata formats (including BibTeX) which is under constant development and released under a GNU/GPL (General Public License). `Tei2Mods-issues.xsl` and `bibutils` provide a means to automatically generate a large number of bibliographic formats to suit the reference manager one is working with; e.g.: 

- to generate EndNote (refer-format) one only needs the following terminal command: `$ xml2end MODS.xml > output_file.end`
- to generate BibTex: `$ xml2bib MODS.xml > output_file.bib`

# Compatibility with Zotero

Zotero has solid support for MODS import and export. However, there are a number of caveats one should be aware of:

1. Zotero has a limited number of "Item Types" and does not currently support periodical issues or volumes. Bibliographic data of `<genre authority="local">journal</genre><genre authority="marcgt">journal</genre>` is mapped to "Journal Article" and the journal title will end up as article title with the journal title empty.
2. Zotero does not support multi-language MODS. If information is present in more than one language, i.e. `<title xml:lang="ar">الجنان</title><title xml:lang="ar-Latn-x-ijmes">al-Jinān</title>`, Zotero will always pick the first entry.

