# Visualisation of Correspondence Sets

## Introduction

Multi-alignments of sounds between cognates is a modern incarnation of traditional sound correspondences. Using a large set of multi-alignements, the next step towards reconstruction is to make correspondence sets.

Correspondence sets are actually nothing else but a partitioning of the columns of the multi-alignments. There are dozens of algorithms to make partitions, but nothing is (of course) really perfect for the linguist. I devised a visualisation to check the results of such partitioning.

## Data

Shown here are the data from the _Benchmark Database for Phonetic Alignments_ <http://alignments.lingpy.org> (List & Prokić 2014). The complete data is downloaded to `sources`

The R-script `manual.R` explains the steps taken to make the visualisation, which are available in the directory `image`. When executed, the script will only recreate the plots for Bai. The other groups work identically, only the settings for the font size in the plots have to be determined manually.

## References

List, Johann-Mattis and Jelena Prokić. (2014). A benchmark database of phonetic alignments in historical linguistics and dialectology. In: Proceedings of the International Conference on Language Resources and Evaluation (LREC), 26 — 31 May 2014, Reykjavik. 288-294.
