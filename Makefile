.phony : all clean snapshot deploy watch

FILES := index lan-simulator
IMAGES := lan-star lan-routes
DESTDIR := output
BUILDIR := build

HTML_OUTPUTS := $(FILES:%=$(DESTDIR)/%.html)
PDF_OUTPUTS := $(FILES:%=$(DESTDIR)/%.pdf)
TEX_OUTPUTS := $(FILES:%=$(BUILDIR)/%.tex)

HTML_SUPPORT := $(addprefix $(DESTDIR)/, \
	css/remarkdown.css \
	css/custom.css \
	$(IMAGES:%=images/%.svg) \
)
TEX_SUPPORT := $(IMAGES:%=$(BUILDIR)/images/%.pdf)

ALL = $(HTML_OUTPUTS) $(HTML_SUPPORT) $(PDF_OUTPUTS)

all : $(ALL)

clean :
	rm -fr $(DESTDIR) $(BUILDIR) pillarPostExport.sh
	git worktree prune --verbose

$(DESTDIR) :
	git worktree add $(DESTDIR) gh-pages
	rm -f $(ALL)

$(BUILDIR) :
	mkdir $(BUILDIR)

$(PDF_OUTPUTS) : $(DESTDIR)/%.pdf : $(BUILDIR)/%.tex $(TEX_SUPPORT)
	latexmk -cd $<
	ln -f $(BUILDIR)/$*.pdf $@

$(DESTDIR)/%.html : template.html.mustache
$(BUILDIR)/%.tex : template.latex.mustache
$(DESTDIR)/%.html $(BUILDIR)/%.tex : %.pillar pillar.conf | $(DESTDIR) $(BUILDIR)
	pillar/pillar export $<
	sed -ie '/^\\includegraphics/s/\.svg//' $(BUILDIR)/$*.tex

$(HTML_SUPPORT) : $(DESTDIR)/% : %
	mkdir -p $(@D)
	ln $< $@

$(TEX_SUPPORT) : $(BUILDIR)/% : %
	mkdir -p $(@D)
	ln $< $@

output-git = git -C output

snapshot : all
	$(output-git) add --all
	$(output-git) diff --quiet --exit-code --cached \
		|| $(output-git) commit --message "Pillar export on $(shell date '+%Y-%m-%d %H:%M:%S')"

deploy : snapshot
	$(output-git) push origin

watch : all
	@which watchman-make >/dev/null \
		|| { echo "Missing command 'watchman-make': brew install watchman >&2"; false; }
	watchman-make -p pillar.conf template.html.mustache 'css/*.css' '*.pillar' -t all
