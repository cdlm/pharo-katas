# base names of individual tutorials, pillar sources, included images
KATAS := lan-simulator
SOURCES := index $(KATAS)
IMAGES := lan-star lan-routes

#
# Important places and file sets
#

DESTDIR := output
BUILDIR := build

HTML_SUPPORT := $(addprefix $(DESTDIR)/, \
	css/remarkdown.css \
	css/custom.css \
	$(IMAGES:%=images/%.svg) \
)

HTML_OUTPUTS := $(SOURCES:%=$(DESTDIR)/%.html)
PDF_OUTPUTS := $(KATAS:%=$(DESTDIR)/%.pdf)
TEX_OUTPUTS := $(KATAS:%=$(BUILDIR)/%.tex)

ALL = $(HTML_OUTPUTS) $(HTML_SUPPORT) $(PDF_OUTPUTS)

#
# Build rules
#

$(DESTDIR) :
	git worktree prune
	git worktree add $(DESTDIR) gh-pages

$(HTML_OUTPUTS) $(PDF_OUTPUTS) : $(DESTDIR)/% : $(BUILDIR)/% | $(DESTDIR)
	cp $< $@

$(HTML_SUPPORT) : $(DESTDIR)/% : % | $(DESTDIR)
	mkdir -p $(@D) && cp $< $@

$(BUILDIR) :
	mkdir $(BUILDIR)

$(BUILDIR)/%.pdf %(BUILDIR)/%.d : $(BUILDIR)/%.tex
	cd $(BUILDIR); \
		TEXINPUTS=../:../latex/sbabook/: \
		texfot latexmk -r ../.latexmkrc -deps -deps-out=$*.d $*

$(BUILDIR)/*.html : template.html.mustache
$(BUILDIR)/*.tex : template.latex.mustache
$(BUILDIR)/%.html $(BUILDIR)/%.tex : %.pillar pillar.conf | $(BUILDIR)
	pillar/pillar export $<
	sed -ie '/^\\includegraphics/s/\.svg//' $(BUILDIR)/$*.tex

output-git = git -C output

#
# Build targets
#

.DEFAULT_GOAL := help
.phony : all watch clean clobber prune snapshot deploy help

all : $(ALL) ## Build output

watch : all ## Auto-rerun 'make all' on file changes
	@which watchman-make >/dev/null \
		|| { echo "Missing command 'watchman-make': brew install watchman >&2"; false; }
	watchman-make -p pillar.conf template.*.mustache 'css/*' 'latex/*' 'images/*' '*.pillar' -t all

clean : ## Delete intermediate build files
	rm -fr $(BUILDIR) pillarPostExport.sh

clobber : clean ## Delete all build files and products
	rm -fr $(DESTDIR)
	git worktree prune --verbose

prune :
	find $(DESTDIR) -mindepth 1 ! -name .git -delete

snapshot : prune all ## Commit a snapshot of the output
	$(output-git) add --all
	$(output-git) diff --quiet --exit-code --cached \
		|| $(output-git) commit --message "Pillar export on $(shell date '+%Y-%m-%d %H:%M:%S')"

deploy : snapshot ## Snapshot and publish to Github Pages
	$(output-git) push origin

# Some shell magic to auto-document the main targets
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help :
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-10s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)
