.phony : all clean snapshot deploy

DESTDIR = output
OUTPUTS = $(addprefix $(DESTDIR)/, \
	index.html \
	lan-simulator.html )
SUPPORT = $(addprefix $(DESTDIR)/, \
	css/remarkdown.css \
	css/custom.css )

ALL = $(OUTPUTS) $(SUPPORT)

all : $(ALL)

clean :
	rm -fr $(DESTDIR)
	git worktree prune --verbose

$(DESTDIR) :
	git worktree add $(DESTDIR) gh-pages
	rm $(ALL)

$(OUTPUTS) : $(DESTDIR)/%.html : %.pillar pillar.conf template.mustache | $(DESTDIR)
	pillar/pillar export

$(SUPPORT) : $(DESTDIR)/% : % | $(DESTDIR)
	cp $< $@

output-git = git -C output

snapshot : all
	$(output-git) diff --exit-code \
		|| $(output-git) commit --all --message "Pillar export on $(shell date '+%Y-%m-%d %H:%M:%S')"

deploy : snapshot
	$(output-git) push origin
