EPUB_CONV_OPTS := --no-default-epub-cover --remove-paragraph-spacing --no-chapters-in-toc

%.pdf : %.tex
	pdflatex $^

%.html : %.tex
	htlatex $^
	sed -i 's/\&#x2026;\([^\.\?\!]\)/\&#x2026; \1/g' $@ #Fix missing ldots spacing

%.epub : %.html
	sed -i 's/Text copyright/<h1><\/h1>Text copyright/' $^ #Force ebook-convert to page break
	sed -i 's/class="tableofcontents">/class="tableofcontents"><br \/>/' $^ #Add a break before Preface
	sed -i 's/chapterToc\" > <a/chapterToc\" >\&nbsp;\&nbsp\&nbsp<a/' $^ #Align number-less chapters in TOC
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
	@rm -f *.aux *.pdf *.log *.toc *.out *.4ct *.4tc *.css *.dvi *.epub *.html *.idv *.lg *.tmp *.xref 2>/dev/null
	@rm -fr converted-* 2>/dev/null
