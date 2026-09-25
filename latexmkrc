# Compile with XeLaTeX and biber.
$pdf_mode = 5;          # xelatex
$bibtex_use = 2;
$clean_ext = "bbl run.xml synctex.gz nav snm vrb";

# Overleaf, and anyone running "latexmk -pdf", asks for pdfLaTeX, which
# cannot compile this class. Run XeLaTeX in its place, so that the
# project compiles whatever compiler is selected.
$pdflatex = 'xelatex %O %S';
