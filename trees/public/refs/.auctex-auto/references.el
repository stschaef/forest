;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "references"
 (lambda ()
   (LaTeX-add-bibitems
    "LuoSatBasedQuantifiedSymmetric"))
 '(or :bibtex :latex))

