(TeX-add-style-hook
 "chapter1"
 (lambda ()
   (LaTeX-add-labels
    "cap1"
    "sec:objectives"
    "sec:motivation"
    "sec:state_of_the_art"))
 :latex)

