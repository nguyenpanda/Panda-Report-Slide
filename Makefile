MAIN_TEX	:= main
OUTDIR		:= build
PDFDIR		:= pdf
VERBOSE		= 

.PHONY: compile full remove clear clean

compile:
	$(VERBOSE)latexmk \
		$(MAIN_TEX).tex \
		-lualatex \
		-interaction=nonstopmode \
		-synctex=1 \
		-outdir=$(OUTDIR)

full: compile
	$(VERBOSE)mkdir -p pdf
	$(VERBOSE)cp $(OUTDIR)/$(MAIN_TEX).pdf $(PDFDIR)

remove:
	rm -rf $(OUTDIR)
	rm -rf $(PDFDIR)

clear:
	$(VERBOSE)latexmk -c -outdir=$(OUTDIR)

clean: clear
