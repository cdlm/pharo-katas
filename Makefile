.phony : all clean snapshot deploy watch

DESTDIR = output
OUTPUTS = $(addprefix $(DESTDIR)/, \
	index.html \
	lan-simulator.html )
SUPPORT = $(addprefix $(DESTDIR)/, \
	css/remarkdown.css \
	css/custom.css \
	images/lan-star.svg )

ALL = $(OUTPUTS) $(SUPPORT)
DIRS = $(sort $(foreach f,$(SUPPORT),$(dir $(f))))

all : $(ALL)

clean :
	rm -fr $(DESTDIR)
	git worktree prune --verbose

$(DESTDIR) :
	git worktree add $(DESTDIR) gh-pages
	rm -f $(ALL)

$(OUTPUTS) : $(DESTDIR)/%.html : %.pillar pillar.conf template.mustache | $(DESTDIR)
	pillar/pillar export

$(DIRS) : | $(DESTDIR)
	mkdir -p $@

$(SUPPORT) : $(DESTDIR)/% : % | $(DIRS)
	cp $< $@

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
	watchman-make -p pillar.conf template.mustache 'css/*.css' '*.pillar' -t all
