SHELL := /bin/bash

protect:
	@echo ">>> Precise a target"

build:
	@for f in `find -name PKGBUILD`; do \
		( cd $$(dirname $$f) && sudo extra-x86_64-build ); \
	done

install: build
	@for f in `find -name PKGBUILD` ; do \
		dir="$$(dirname $$f)"; \
		name="$$(cd $${dir} && ls $$(basename $$(dirname $$f))*.tar.xz 2>/dev/null)" || continue; \
		( cd $${dir} && aura -U $${name} ); \
	done

source: update-patches
	@for f in `find -name PKGBUILD `; do \
		( cd $$(dirname $$f) && makepkg -S ); \
	done

burp:
	@echo -en "\e[91mAre you sure? [y/n]\e[0m "
	@read -n 1 -r REPLY; \
	echo ''; \
	if [[ $${REPLY} =~ ^[Yy]$$ ]] ; then \
		for f in $$(find -name PKGBUILD | sort); do \
			dir="$$(dirname $$f)"; \
			name="$$(cd $${dir} && ls $$(basename $$(dirname $$f))*.src.tar.gz 2>/dev/null)" || continue; \
			echo -en "\e[94m$$f [y/n]\e[0m "; \
			read -n 1 -r REPLY; \
			echo ''; \
			if [[ $${REPLY} =~ ^[Yy]$$ ]]; then \
				( cd $${dir} && burp $${name} ); \
			fi \
		done \
	else \
		echo -e "\e[93mAborting…\e[0m"; \
	fi

update-patches:
	@for d in **/patches/*.patch; do \
		cp "$${d}" "$$(dirname $$(dirname $${d}))/"; \
	done

clean:
	@echo -e "\e[91mThe following files will be cleaned:\e[0m"
	@git clean -n -d -x
	@echo -en "\e[91mAre you sure? [y/n/i]\e[0m "
	@read -n 1 -r REPLY; \
	echo ''; \
	if [[ $${REPLY} =~ ^[Ii]$$ ]]; then \
		git clean -d -x -i; \
	elif [[ $${REPLY} =~ ^[Yy]$$ ]]; then \
		git clean -d -x -f; \
	else \
		echo -e "\e[93mAborting…\e[0m"; \
	fi

