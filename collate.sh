#!/bin/bash

# 2 pages on one
pdfjam --nup 2x1 --suffix 2up --landscape --outfile out2.pdf 1706.03741.pdf

# this is not working:
/usr/bin/pdfjam --booklet 'true' --landscape --suffix book --signature '4' --landscape --preamble '\usepackage{everyshi}
          \makeatletter
          \EveryShipout{\ifodd\c@page\pdfpageattr{/Rotate 180}\fi}
          \makeatother
          ' -- out2.pdf -


