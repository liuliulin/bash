SITES := site01 site02
.phony: all ${SITES} du

all: ${SITES}

site01:
	@echo "镜像 site01"
	@wget -p -r -l 2 -k -K -N http://www.flnet.com; true

site02:
	@echo "镜像 site02"
	@wget -p -r -l 2 -k -K -N http://www.efeihu.com; true

du:
	@for a in *; do du -sh $$a; done

