
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-0%25-lightgrey.svg)

[![cran
checks](https://cranchecks.info/badges/worst/hyphenatr.png)](https://cranchecks.info/pkgs/hyphenatr)
[![CRAN
status](https://www.r-pkg.org/badges/version/hyphenatr.png)](https://www.r-pkg.org/pkg/hyphenatr)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.1.0-blue.svg)
![License](https://img.shields.io/badge/License-GPL-3%20+%20file%20LICENSE-blue.svg)

# hyphenatr

Tools to Hyphenate Strings Using the ‘Hunspell’ Hyphenation Library

## Description

Identifying hyphenation points in strings can be useful for both text
processing and display functions. The ‘Hunspell’ hyphenation library
<https://github.com/hunspell/hyphen> provides tools to perform
hyphenation using custom language rule dictionaries. Many hyphenation
rules dictionaries are included. Words can be hyphenated directly or
split into hyphenated component strings for further processing.

## Special thanks to

- @daroczig & @edwindj for language testing.

## What’s Inside The Tin

The following functions are implemented:

- `cleanup`: Cleanup after ourselves
- `curr_dict`: Identify current hyphen rules language
- `hyphenate`: Hyphenate a character vector of words
- `hyphendict_is_loaded`: Test to see if the hyphenation language rules
  dictionary is loaded
- `list_dicts`: List available hyphenation languages rules
- `switch_dict`: Switch hyphen rules language

## Installation

``` r
remotes::install_github("hrbrmstr/hyphenatr")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(hyphenatr)

# current version
packageVersion("hyphenatr")
## [1] '0.4.1'
```

``` r
library(jsonlite)
library(microbenchmark)

# current verison
packageVersion("hyphenatr")
## [1] '0.4.1'

list_dicts()
##  [1] "af_ZA"  "bg_BG"  "ca"     "cs_CZ"  "da_DK"  "de"     "de_AT"  "de_CH"  "de_DE"  "el_GR"  "en_GB"  "en_US" 
## [13] "es_ANY" "et_EE"  "fr"     "gl"     "hr_HR"  "hu_HU"  "id_ID"  "is"     "it_IT"  "lt"     "lt_LT"  "lv_LV" 
## [25] "nb_NO"  "nl_NL"  "nn_NO"  "pl_PL"  "pt_BR"  "pt_PT"  "ro_RO"  "ru_RU"  "sh"     "sk_SK"  "sl_SI"  "sr"    
## [37] "sv"     "te_IN"  "uk_UA"  "zu_ZA"

curr_dict()
## [1] "en_US"

# test word list (10K words)
dat <- readLines(system.file("extdata/top10000en.txt", package="hyphenatr"))

microbenchmark(out1 <- hyphenate(dat))
## Unit: milliseconds
##                    expr      min       lq     mean   median       uq      max neval
##  out1 <- hyphenate(dat) 9.553738 9.890184 9.910834 9.905088 9.927863 10.92806   100

out1[500:550]
##  [1] "got"            "fam=ily"        "pol=icy"        "in=vestors"     "record"         "loss"          
##  [7] "re=ceived"      "April"          "Ex=change"      "code"           "graph=ics"      "agency"        
## [13] "in=creased"     "man=ager"       "keep"           "look"           "of=ten"         "de=signed"     
## [19] "Euro=pean"      "earn=ings"      "en=vi=ron=ment" "July"           "job"            "third"         
## [25] "wa=ter"         "net"            "banks"          "an=a=lysts"     "strong"         "party"         
## [31] "econ=omy"       "away"           "dol=lar"        "taken"          "de=vel=oped"    "con=tinue"     
## [37] "al=low"         "Mi=crosoft"     "key"            "ei=ther"        "se=cu=rity"     "project"       
## [43] "agreed"         "though"         "Ja=pan"         "rather"         "coun=tries"     "plant"         
## [49] "along"          "Ap=ple"         "ac=tion"

microbenchmark(out2 <- hyphenate(dat, simplify=FALSE))
## Unit: milliseconds
##                                      expr      min       lq     mean   median     uq      max neval
##  out2 <- hyphenate(dat, simplify = FALSE) 11.45954 11.60546 11.93981 12.06023 12.146 13.68338   100

jsonlite::toJSON(out2[530:540], pretty=TRUE)
## [
##   ["econ", "omy"],
##   ["away"],
##   ["dol", "lar"],
##   ["taken"],
##   ["de", "vel", "oped"],
##   ["con", "tinue"],
##   ["al", "low"],
##   ["Mi", "crosoft"],
##   ["key"],
##   ["ei", "ther"],
##   ["se", "cu", "rity"]
## ]

microbenchmark(out3 <- hyphenate(dat, simplify="-"))
## Unit: milliseconds
##                                    expr      min       lq     mean   median       uq      max neval
##  out3 <- hyphenate(dat, simplify = "-") 12.12632 12.21974 12.33201 12.28194 12.34863 13.34341   100

out3[500:550]
##  [1] "got"            "fam-ily"        "pol-icy"        "in-vestors"     "record"         "loss"          
##  [7] "re-ceived"      "April"          "Ex-change"      "code"           "graph-ics"      "agency"        
## [13] "in-creased"     "man-ager"       "keep"           "look"           "of-ten"         "de-signed"     
## [19] "Euro-pean"      "earn-ings"      "en-vi-ron-ment" "July"           "job"            "third"         
## [25] "wa-ter"         "net"            "banks"          "an-a-lysts"     "strong"         "party"         
## [31] "econ-omy"       "away"           "dol-lar"        "taken"          "de-vel-oped"    "con-tinue"     
## [37] "al-low"         "Mi-crosoft"     "key"            "ei-ther"        "se-cu-rity"     "project"       
## [43] "agreed"         "though"         "Ja-pan"         "rather"         "coun-tries"     "plant"         
## [49] "along"          "Ap-ple"         "ac-tion"

microbenchmark(out4 <- hyphenate(dat, simplify="&shy;"))
## Unit: milliseconds
##                                        expr     min       lq    mean   median       uq      max neval
##  out4 <- hyphenate(dat, simplify = "&shy;") 12.3114 12.78394 12.9895 12.96935 13.05192 14.70904   100

out4[500:550]
##  [1] "got"                        "fam&shy;ily"                "pol&shy;icy"                "in&shy;vestors"            
##  [5] "record"                     "loss"                       "re&shy;ceived"              "April"                     
##  [9] "Ex&shy;change"              "code"                       "graph&shy;ics"              "agency"                    
## [13] "in&shy;creased"             "man&shy;ager"               "keep"                       "look"                      
## [17] "of&shy;ten"                 "de&shy;signed"              "Euro&shy;pean"              "earn&shy;ings"             
## [21] "en&shy;vi&shy;ron&shy;ment" "July"                       "job"                        "third"                     
## [25] "wa&shy;ter"                 "net"                        "banks"                      "an&shy;a&shy;lysts"        
## [29] "strong"                     "party"                      "econ&shy;omy"               "away"                      
## [33] "dol&shy;lar"                "taken"                      "de&shy;vel&shy;oped"        "con&shy;tinue"             
## [37] "al&shy;low"                 "Mi&shy;crosoft"             "key"                        "ei&shy;ther"               
## [41] "se&shy;cu&shy;rity"         "project"                    "agreed"                     "though"                    
## [45] "Ja&shy;pan"                 "rather"                     "coun&shy;tries"             "plant"                     
## [49] "along"                      "Ap&shy;ple"                 "ac&shy;tion"

switch_dict("de_DE")

hyphenate("tägelîch")
## [1] "tä=gelîch"
```

## hhhash Metrics

| Lang         | \# Files |  (%) |  LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
|:-------------|---------:|-----:|-----:|-----:|------------:|-----:|---------:|-----:|
| C            |        3 | 0.12 | 1147 | 0.42 |         151 | 0.33 |      188 | 0.22 |
| C++          |        2 | 0.08 |   92 | 0.03 |          23 | 0.05 |       21 | 0.03 |
| C/C++ Header |        2 | 0.08 |   60 | 0.02 |          33 | 0.07 |      128 | 0.15 |
| R            |        6 | 0.23 |   60 | 0.02 |          23 | 0.05 |       81 | 0.10 |
| SUM          |       13 | 0.50 | 1359 | 0.50 |         230 | 0.50 |      418 | 0.50 |

{cloc} 📦 metrics for hyphenatr

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
