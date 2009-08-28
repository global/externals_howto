HOWTO_EN=HOWTO-externals-en
HOWTO_DE=HOWTO-externals-de
HOWTO_PT_BR=HOWTO-externals-pt_br

HOWTO_EXAMPLES=example1  example2  example3  example4

HTMLDIR_EN=HOWTO
HTMLDIR_DE=HOWTO-de
HTMLDIR_PT_BR=HOWTO-pt_br

LATEX=latex
DVIPS=dvips
DVIPDF=dvipdf
LATEX2HTML=latex2html

default: en_pdf

TARGETS: default \
	en_ps en_pdf en_html de_ps de_pdf de_html pt_br_ps pt_br_pdf pt_br_html ps pdf html \
	clean cleaner distclean \
	examples $(HOWTO_EXAMPLES)

.PHONY: $(TARGETS)

en_ps: $(HOWTO_EN).ps

en_pdf: $(HOWTO_EN).pdf

en_html: 
	mkdir -p ${HTMLDIR_EN}
	$(LATEX2HTML) -dir $(HTMLDIR_EN) -split 4 $(HOWTO_EN).tex

de_ps: $(HOWTO_DE).ps

de_pdf: $(HOWTO_DE).pdf

de_html: 
	mkdir -p ${HTMLDIR_DE}
	$(LATEX2HTML) -dir $(HTMLDIR_DE) -split 4 $(HOWTO_DE).tex

pt_br_ps: $(HOWTO_PT_BR).ps

pt_br_pdf: $(HOWTO_PT_BR).pdf

pt_br_html: 
	mkdir -p ${HTMLDIR_PT_BR}
	$(LATEX2HTML) -dir $(HTMLDIR_PT_BR) -split 4 $(HOWTO_PT_BR).tex


ps: en_ps de_ps

pdf: en_pdf de_pdf

html: en_html de_html

clean:
	-rm -f *.aux *.log *.toc *.dvi *~

cleaner: clean
	-rm -f *.ps *.pdf
	-rm -rf $(HTMLDIR_EN) $(HTMLDIR_DE) $(HTMLDIR_PT_BR)

distclean: cleaner
	@for d in ${HOWTO_EXAMPLES}; do ${MAKE} -C $$d clean; done

%.dvi:
	$(LATEX) $*.tex
	$(LATEX) $*.tex


%.ps: %.dvi
	$(DVIPS) $*.dvi


%.pdf: %.dvi
	$(DVIPDF) $*.dvi

examples: $(HOWTO_EXAMPLES)
	echo made examples

$(HOWTO_EXAMPLES):
	$(MAKE) -C $@
