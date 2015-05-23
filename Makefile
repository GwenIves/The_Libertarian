EPUB_CONV_OPTS := --no-default-epub-cover --remove-paragraph-spacing

%.pdf : %.tex
	pdflatex $^

%.html : %.tex
	htlatex $^

%.epub : %.html
	sed -i 's/Text copyright/<h1><\/h1>Text copyright/' $^ #Force ebook-convert to page break
	ebook-convert $^ $@ $(EPUB_CONV_OPTS)

preamble := preamble_kindle.tex
desktop: preamble := preamble_desktop.tex
kindle: preamble := preamble_kindle.tex

.INTERMEDIATE: the_libertarian.tex
.PHONY: the_libertarian.tex
the_libertarian.tex:
	cat ${preamble} > $@
	cat the_libertarian_body.tex >> $@

desktop: the_libertarian.pdf
kindle: the_libertarian.epub

.PHONY: clean
clean:
	@rm -f *.pdf *.aux *.log *.toc *.out *.aux *.pdf *.log *.toc *.out *.4ct *.4tc *.css *.dvi *.epub *.html *.idv *.lg *.tmp *.xref 2>/dev/null
