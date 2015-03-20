%.pdf : %.tex
	pdflatex $^

desktop: preamble=preamble_desktop.tex
kindle: preamble=preamble_kindle.tex

.INTERMEDIATE: the_libertarian.tex
.PHONY: the_libertarian.tex
the_libertarian.tex:
	cat ${preamble} > $@
	cat the_libertarian_body.tex >> $@

desktop kindle: the_libertarian.pdf

.PHONY: clean
clean:
	@rm -f *.pdf *.aux *.log *.toc *.out 2>/dev/null
