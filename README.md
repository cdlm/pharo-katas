# Pharo development examples and exercises

This repository contains the code of small [Pharo][] tutorials and programs, to be used as development examples or use-cases during programming courses.

**Students:** This repository is only useful to you if you spotted an error in the tutorial, or if you want to load the full code snapshot.
[Follow the program explanations and tutorials here](http://cdlm.github.io/pharo-katas).

**Contributors:** The complete code is committed as a [FileTree][] snapshot in the `repository` subdirectory, and tutorials are written using [Pillar][].
The makefile automates building and deploying the tutorials:

- `make` or `make all`: regenerate the tutorial from Pillar; you can direcly open the resulting HTML files in the `output` directory.
- `make watch`: automagically do `make all` whenever you save files.
- `make clean`: cleanup compilation products.
- `make snapshot`: compile and make a snapshot for deployment.
- `make deploy`: compile, snapshot, and publish the tutorial online (requires access rights on GitHub).

[pharo]: http://pharo.org
[pillar]: https://github.com/pillar-markup/pillar
[filetree]: https://github.com/dalehenrich/filetree
