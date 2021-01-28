# LaTex Makefile

FILE = note

#all: pdf view vim clean

pdf: $(FILE).tex
	latexmk -xelatex $(FILE).tex

view: 
	evince $(FILE).pdf &

vim:
	apvlv $(FILE).pdf &

clean: 
	rm *.aux *.bbl *.blg *.bcf *.log *.nav *.out *.snm *.toc *.run.xml *.gp~ Makefile~ *.tex~ *.bib~
	latexmk -C
	@echo "all cleaned up"
