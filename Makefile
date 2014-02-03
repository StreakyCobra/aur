SHELL := /bin/bash

protect:
	@echo ">>> Precise a target"

verify-patches:
	@for d in **/patches/*.patch ; do \
		cp "$${d}" "$$(dirname $$(dirname $${d}))/" ; \
	done

clean:
	@echo -e "\e[91mThe following files will be cleaned:\e[0m"
	@git clean -n -d -x
	@echo -en "\e[91mAre you sure? [y/n/i]\e[0m "
	@read -n 1 -r REPLY; \
	echo ''; \
	if [[ $${REPLY} =~ ^[Ii]$$  ]] ; then \
		git clean -d -x -i; \
	elif [[ $${REPLY} =~ ^[Yy]$$  ]] ; then \
		git clean -d -x -f; \
	else \
		echo -e "\e[93mAborting…\e[0m"; \
	fi
