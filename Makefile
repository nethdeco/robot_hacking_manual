BUILDDIR := $(CURDIR)/build
SOURCE_FILE := \
				README.md \
				$(CURDIR)/reconnaissance/robot_footprinting/tutorial1/README.md \
				$(CURDIR)/other/web/tutorial2/README.md \
				$(CURDIR)/BIBLIOGRAPHY.md
EXTENSION := .pdf
OUT_FILE := RHM
PANDOC_TEMPLATE := $(CURDIR)/templates/eisvogel.tex
PANDOC_OPTIONS := \
					--variable fontsize=10pt \
					--pdf-engine=xelatex \
					--bibliography=bibliography.bib \
					--filter pandoc-latex-fontsize \
					--filter pandoc-citeproc --template=$(PANDOC_TEMPLATE) $(SOURCE_FILE)					
define exec_pandoc
	@echo "Building..."
	@pandoc $(PANDOC_OPTIONS) -o $(1)
	@echo "Build finished for $(1)"
endef
.PHONY: clean all debug
all: $(OUT_FILE)$(EXTENSION) 
$(OUT_FILE)$(EXTENSION) : $(SOURCE_FILE) $(BUILDDIR) $(PANDOC_TEMPLATE)
	$(call exec_pandoc, $(OUT_FILE)$(EXTENSION))
$(BUILDDIR):
	@mkdir $(BUILDDIR)	
debug: EXTENSION := .tex
debug: $(OUT_FILE)$(EXTENSION)
clean:
	@rm -rfv $(BUILDDIR)
	@rm -fv $(OUT_FILE)$(EXTENSION)
	$(eval EXTENSION := .tex)
	@rm -fv $(OUT_FILE)$(EXTENSION)
