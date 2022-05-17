.PHONY: all clean keep-going

# Main source file and possible bibliography
MAIN=main.tex
BIB=

# Filter pdflatex output through color filter, if available
ifeq (, $(shell which rehl))
LATEXMK_FILTER=cat
else
LATEXMK_FILTER=rehl -r '[Ee]rrors?:?' -y '[Ww]arnings?:?' -p '[\w\d_\-\.]+\.((pdf)|(tex)|(png)|(svg))'
endif

all: main.pdf

keep-going:
	latexmk -pdf -pvc -pdflatex="pdflatex -synctex=1 -halt-on-error" -use-make $(MAIN) | ${LATEXMK_FILTER}

main.pdf: $(MAIN) $(BIB)
	latexmk -pdf -pdflatex="pdflatex -synctex=1 -halt-on-error" -use-make $(MAIN) | ${LATEXMK_FILTER}

clean:
	@rm -vf *.aux *.log *.out *.toc *.synctex.gz *.blg *.bbl *.fdb_latexmk *.dvi *.fls *.ps
	@rm -vf main.pdf

