#!/bin/bash
set -e
set -x

outputdir="output"
tmpdir="tmp-collater"

mkdir -p $outputdir
mkdir -p $tmpdir/

for pdffile in "$@"
do
    # 2 pages on one
    pdfjam --nup 2x1 --suffix 2up --landscape --outfile $tmpdir/out-nup.pdf "$pdffile"

    # # rotate by 180°
    pdftk $tmpdir/out-nup.pdf cat 1-endwest output $tmpdir/out-rotated.pdf

    # # this is not working:
    /usr/bin/pdfjam --booklet 'true' --landscape --suffix book --signature '4' --landscape --preamble '\usepackage{everyshi}
            \makeatletter
            \EveryShipout{\ifodd\c@page\pdfpageattr{/Rotate 180}\fi}
            \makeatother
            ' -o $tmpdir/out-booklet.pdf $tmpdir/out-rotated.pdf

    # rotate every other page by 180 degrees
    pdftk $tmpdir/out-booklet.pdf cat 1 2-endsouth output $tmpdir/out-reversed.pdf

    # rotate by 90° so it is not a landscape but portrait
    pdftk $tmpdir/out-reversed.pdf cat 1-endwest output "$outputdir/$pdffile"

done

rm -r $tmpdir
