# Example Analyses of ValPal valency data using R

Michael Cysouw, <cysouw@mac.com>

30 September 2015

Data downloaded from <http://valpal.info> into `sources` (Hartmann, Haspelmath & Taylor 2013)

The source data is in UTF16LE with CRLF line endings (unfortunately), so I have recoded the data with the bash script `code/recode.sh` to UTF8 with LF line endings. The recoded data is found in `data`

The data is used to make plots that are basically the same as in the paper Hartmann, Haspelmath & Cysouw (2014). The actual code used is different, so the current results are not exactly alike to the plots in that paper. 

Check code in `manual.R` using ad-hoc functions described in `code/adhocfunctions.R`. The result of the code is in `manual.html` and can be remade by using `rmarkdown::render("manual.R")`. Session info is added to the end of `manual.html`.

## References

Hartmann, Iren, Martin Haspelmath & Michael Cysouw. 2014. Identifying semantic role clusters and alignment types via microrole coexpression tendencies. *Studies in Language* 38(3). 463–484.

Hartmann, Iren & Haspelmath, Martin & Taylor, Bradley (eds.) 2013. *Valency Patterns Leipzig*. Leipzig: Max Planck Institute for Evolutionary Anthropology. (Available online at http://valpal.info, Accessed on 2015-09-17)