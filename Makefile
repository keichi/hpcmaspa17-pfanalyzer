MARKDOWNS=$(wildcard ./src/*.md)
MAIN=src/main.tex
SOURCES=$(MARKDOWNS:.md=.tex)
IMAGE_OBJS=$(wildcard ./img/*.obj)
IMAGES=$(IMAGE_OBJS:.obj=.pdf)
REFERENCES=references.bib
STYLES=

.PHONY: all clean open watch

all: main.pdf

%.tex: %.md
	pandoc --wrap=none --listings -f markdown+fenced_code_attributes --biblatex -S -o $@ $<
	sed -i -e "s/\\\\\\$$/\\$$/g" $@
	sed -i -e "s/\([A-Z]\)\\./\1\\\\@./g" $@
	sed -i -e "s/ *~ */~/g" $@

%.pdf-raw: %.obj
	tgif -color -print -pdf $<
	mv $(<:.obj=.pdf) $@

%.pdf-cropped: %.pdf-raw
	pdfcrop $< $@

%.pdf: %.pdf-cropped
	gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite -sOutputFile=$@ $<

main.pdf: $(MAIN) $(SOURCES) $(IMAGES) $(REFERENCES) $(STYLES)
	latexmk -pdf $(MAIN)

clean:
	latexmk -C $(MAIN)
	-$(RM) $(SOURCES)
	-$(RM) $(IMAGES)

open: main.pdf
	latexmk -pdf -pv $(MAIN)

watch: main.pdf
	latexmk -pdf -pvc $(MAIN)

archive:
	git archive --format tar.gz HEAD --output hpcmaspa.tar.gz

release: main.pdf
	gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/printer -sDEVICE=pdfwrite -dCompressFonts=true -dSubsetFonts=true -sOutputFile=hpcmaspa2017_takahashi.pdf main.pdf
