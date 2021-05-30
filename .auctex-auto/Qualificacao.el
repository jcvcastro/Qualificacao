(TeX-add-style-hook
 "Qualificacao"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("book" "12pt" "a4paper" "titlepage" "final")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "left=2.5cm" "right=2.5cm" "top=4cm" "bottom=2.5cm") ("inputenc" "utf8") ("fontenc" "T1") ("algorithm2e" "ruled" "vlined") ("hyperref" "colorlinks" "citecolor=blue") ("placeins" "below") ("footmisc" "symbol") ("todonotes" "textsize=scriptsize" "colorinlistoftodos" "color=yellow" "backgroundcolor=yellow" "obeyFinal")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "novoscomandos"
    "cover"
    "resumo"
    "abstract"
    "symbols"
    "abreviations"
    "docs/chapter1"
    "docs/chapter2"
    "docs/chapter3"
    "docs/chapter5"
    "docs/chapter6"
    "appendix"
    "book"
    "bk12"
    "geometry"
    "inputenc"
    "fontenc"
    "amsmath"
    "amssymb"
    "amsfonts"
    "amstext"
    "textcomp"
    "bm"
    "mathrsfs"
    "amsthm"
    "pgf"
    "graphicx"
    "float"
    "color"
    "xcolor"
    "booktabs"
    "indentfirst"
    "rotating"
    "braket"
    "algorithm2e"
    "multirow"
    "fancyhdr"
    "makeidx"
    "setspace"
    "hyperref"
    "mathtools"
    "ae"
    "placeins"
    "flafter"
    "pxfonts"
    "listings"
    "footmisc"
    "tikz"
    "pgfplots"
    "soul"
    "natbib"
    "subfig"
    "grffile"
    "todonotes")
   (TeX-add-symbols
    '("reviewtimetoday" 2)
    '("C" 1)
    '("comment" 1)
    "veq"
    "x"
    "blacksolidlinethin"
    "blacksolidline"
    "blackdottedline"
    "blackdashdotline"
    "bluesolidline"
    "bluedashedline"
    "bluedashdotedline"
    "reddashedline"
    "redsolidline"
    "reddottedline"
    "greendashdottedline"
    "magentadottedline"
    "thickhrulefill")
   (LaTeX-add-bibliographies
    "refs.bib")
   (LaTeX-add-amsthm-newtheorems
    "theorem"
    "corollary"
    "lemma"
    "teo"
    "defin"
    "nota")
   (LaTeX-add-xcolor-definecolors
    "myOrange"))
 :latex)

