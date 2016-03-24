.phony : all clean realclean snapshot deploy watch

KATAS := lan-simulator
FILES := index $(KATAS)
IMAGES := lan-star lan-routes
DESTDIR := output
BUILDIR := build

HTML_OUTPUTS := $(FILES:%=$(DESTDIR)/%.html)
PDF_OUTPUTS := $(KATAS:%=$(DESTDIR)/%.pdf)
TEX_OUTPUTS := $(KATAS:%=$(BUILDIR)/%.tex)

HTML_SUPPORT := $(addprefix $(DESTDIR)/, \
	css/remarkdown.css \
	css/custom.css \
	$(IMAGES:%=images/%.svg) \
)

ALL = $(HTML_OUTPUTS) $(HTML_SUPPORT) $(PDF_OUTPUTS)

all : $(ALL)

clean :
	rm -fr $(BUILDIR) pillarPostExport.sh

realclean : clean
	rm -fr $(DESTDIR)
	git worktree prune --verbose

$(DESTDIR) :
	git worktree prune
	git worktree add $(DESTDIR) gh-pages
	rm -f $(ALL)

$(HTML_OUTPUTS) $(PDF_OUTPUTS) : $(DESTDIR)/% : $(BUILDIR)/% | $(DESTDIR)
	cp $< $@

$(HTML_SUPPORT) : $(DESTDIR)/% : % | $(DESTDIR)
	mkdir -p $(@D) && cp $< $@

$(BUILDIR) :
	mkdir $(BUILDIR)

$(BUILDIR)/%.pdf %(BUILDIR)/%.d : $(BUILDIR)/%.tex
	TEXINPUTS=../:../latex/sbabook/: texfot latexmk -cd $<

$(BUILDIR)/*.html : template.html.mustache
$(BUILDIR)/*.tex : template.latex.mustache
$(BUILDIR)/%.html $(BUILDIR)/%.tex : %.pillar pillar.conf | $(BUILDIR)
	pillar/pillar export $<
	sed -ie '/^\\includegraphics/s/\.svg//' $(BUILDIR)/$*.tex

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
