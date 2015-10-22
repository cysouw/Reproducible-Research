# Syntactic analysis of Wenker data from Jürg Fleischer

Michael Cysouw <cysouw@uni-marburg.de>

30 September 2015

The data as prepared by Jürg Fleischer in the from of an Excel file is available in the directory `sources`. The data was transferred into two text files in the directory `data` with only minimal changes:

* Empty cells in WS3::Blankoannotation were treated as NA
* Novi-Vrbas occurs twice. I slightly changed the coordinates of the second to obtain unique coordinates
* FROHNLEITEN WS3::Infinitiv was corrected from "88 88" to "88"

Processing of data into dialect maps is exemplified in `manual.R`. Output (including Session info) is available in `manual.html`.