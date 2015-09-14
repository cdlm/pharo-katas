.phony : all gh-pages gh-push

all : output output/index.html output/lan-simulator.html output/css/remarkdown.css output/css/custom.css

output :
	git worktree add output gh-pages

output/%.html : %.pillar pillar.conf template.mustache
	pillar/pillar export

output/%.css : %.css
	cp $< $@

output-git = git -C output

snapshot : all
	$(output-git) diff --exit-code \
		|| $(output-git) commit --all --message "Pillar export on $(shell date '+%Y-%m-%d %H:%M:%S')"

deploy : snapshot
	$(output-git) push origin
