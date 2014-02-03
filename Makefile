protect:
	@echo ">>> Precise a target"

verify-patches:
	@for d in **/patches/*.patch ; do \
		cp "$${d}" "$$(dirname $$(dirname $${d}))/" ; \
	done

clean:
	# Built packages and log
	rm **/src -rf
	rm **/pkg -rf
	rm **/*.log -rf
	rm **/*.tar.xz -rf
	rm **/*.tar.gz -rf
	# Quilt
	rm **/.pc -rf
	rm **/patches/series -rf
	rm **/patches/*.patch~ -rf
