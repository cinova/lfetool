compile-plugins:
	@echo "Compiling plugins ..."
	@ERL_LIBS=$(ERL_LIBS) PATH=$(SCRIPT_PATH) erl \
	-eval "'lfetool-plugin':'compile-plugins'('show-output')." \
	-noshell -s erlang halt
