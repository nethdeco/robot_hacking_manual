BUILDDIR := $(CURDIR)/build
# Content

## Index ##################
SOURCE_FILES := \
				INDEX.md \
				DISCLAIMER.md \
				MOTIVATION.md \
				CONTRIBUTE.md

## Introduction ############
SOURCE_FILES := $(SOURCE_FILES) \
				$(CURDIR)/0_introduction/README.md \

## Case studies ############
SOURCE_FILES := $(SOURCE_FILES) \
				$(CURDIR)/1_case_studies/README.md \
				$(CURDIR)/1_case_studies/0_cobot/README.md \
				$(CURDIR)/1_case_studies/1_amr/README.md \
				$(CURDIR)/1_case_studies/OTHER.md

# ## Reconnaissance ##########
# SOURCE_FILES := $(SOURCE_FILES) \
# 				$(CURDIR)/1_reconnaissance/README.md \
# 				$(CURDIR)/1_reconnaissance/robot_footprinting/tutorial1/README.md \
# 				$(CURDIR)/1_reconnaissance/robot_footprinting/tutorial2/README.md
#
# ## Vulnerabilities #########
# SOURCE_FILES := $(SOURCE_FILES) \
# 				$(CURDIR)/2_robot_vulnerabilities/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial1/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial2/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial3/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial4/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial5/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial6/README.md \
# 				$(CURDIR)/2_robot_vulnerabilities/tutorial7/README.md
#
# ## Exploitation #############
# SOURCE_FILES := $(SOURCE_FILES) \
# 				$(CURDIR)/3_robot_exploitation/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial1/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial2/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial3/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial4/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial5/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial6/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial7/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial8/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial9/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial10/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial11/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial12/README.md \
# 				$(CURDIR)/3_robot_exploitation/tutorial13/README.md

# ## Other ####################
# SOURCE_FILES := $(SOURCE_FILES) \
# 				$(CURDIR)/4_other/README.md \
# 				$(CURDIR)/4_other/web/tutorial2/README.md \

## Findings ############
SOURCE_FILES := $(SOURCE_FILES) \
				$(CURDIR)/FINDINGS.md \

## Bibliography #############
SOURCE_FILES := $(SOURCE_FILES) \
				$(CURDIR)/BIBLIOGRAPHY.md

EXTENSION := .pdf
EXTENSION_TEX := .tex
EXTENSION_MD := .md
OUT_FILE := RHM
PANDOC_TEMPLATE := $(CURDIR)/pandoc-latex-template/eisvogel.tex
PANDOC_OPTIONS := \
					--variable fontsize=10pt \
					--from markdown \
					--pdf-engine=xelatex \
					--bibliography=bibliography.bib \
					--filter pandoc-latex-fontsize \
					--citeproc \
					--template=$(PANDOC_TEMPLATE) \
					$(SOURCE_FILES)
define exec_pandoc
	@echo "Building..."
	@pandoc $(PANDOC_OPTIONS) -o $(1)
	@echo "Build finished for $(1)"
endef

.PHONY: clean all debug

all: $(OUT_FILE)$(EXTENSION)
$(OUT_FILE)$(EXTENSION) : $(SOURCE_FILES) $(BUILDDIR) $(PANDOC_TEMPLATE)
	$(call exec_pandoc, $(OUT_FILE)$(EXTENSION))
$(BUILDDIR):
	@mkdir $(BUILDDIR)

tex:
	$(call exec_pandoc, $(OUT_FILE)$(EXTENSION_TEX))

md:
	$(call exec_pandoc, $(OUT_FILE)$(EXTENSION_MD))

debug: EXTENSION := .tex
debug: $(OUT_FILE)$(EXTENSION)
clean:
	@rm -rfv $(BUILDDIR)
	@rm -fv $(OUT_FILE)$(EXTENSION) $(eval EXTENSION := .md)
	@rm -fv $(OUT_FILE)$(EXTENSION) $(eval EXTENSION := .tex)
	@rm -fv $(OUT_FILE)$(EXTENSION) $(eval EXTENSION := .aux)
	@rm -fv $(OUT_FILE)$(EXTENSION) $(eval EXTENSION := .toc)
	@rm -fv $(OUT_FILE)$(EXTENSION) $(eval EXTENSION := .log)
	@rm -fv $(OUT_FILE)$(EXTENSION) $(eval EXTENSION := .synctex.gz)
	@rm -fv $(OUT_FILE)$(EXTENSION)
