#
# Makefile
#
# Requires:
#	- multipass
#

# tbd. Bun
# 	sudo apt install unzip
#	curl -fsSL https://bun.sh/install | bash

_MP_INSTANCE:=a746ae
	# nothing magic about that name - just use anything that's unique (and starts with a letter)

_MP_SUBFOLDER:=work
	# where current folder is mapped within MP (actual name doesn't matter)

_MP_PARAMS=--memory 2G --disk 2G --cpus 2
	#
	# Hint: use 'multipass info <instance>' to tune these

all: _mp-image
	#multipass exec $(_MP_INSTANCE) -d $(_MP_SUBFOLDER) -- sh -c 'pwd && bun run start'
	multipass exec $(_MP_INSTANCE) -- sh -c 'pwd && bun run start'

# TEMP: testing
_tst_v: _mp-image
	multipass exec $(_MP_INSTANCE) -- /home/ubuntu/.bun/bin/bun --version
	  # WORKS

_tst_2: _mp-image
	multipass exec $(_MP_INSTANCE) -d $(_MP_SUBFOLDER) -- /home/ubuntu/.bun/bin/bun --version
	  # WORKS

# Checks that a) 'multipass' exists as a command, b) downloads the Ubuntu image we use.
#
# Note: Downloading would happen also automatically, but wanted to make it explicit.
#
# Note: Need to create a link to '/usr/local/bin' (or add '/home/ubuntu/.bun/bin/bun' to the PATH); 'bun' is otherwise
#		NOT found by 'multipass exec [...] sh -c '...''.
#
_mp-image: _mp-exists
	(multipass list | grep $(_MP_INSTANCE) > /dev/null) || ( \
      multipass launch lts --name $(_MP_INSTANCE) --mount $(shell pwd):/home/ubuntu/$(_MP_SUBFOLDER) $(_MP_PARAMS) && \
      multipass exec $(_MP_INSTANCE) -- sudo apt-get update && \
      multipass exec $(_MP_INSTANCE) -- sudo apt-get install unzip && \
      multipass exec $(_MP_INSTANCE) -- sh -c 'curl -fsSL https://bun.sh/install | bash' && \
      (cd /usr/local/bin && ln -s /home/ubuntu/.bun/bin/bun .) \
	)

_mp-exists:
	@multipass --version >/dev/null


# Manual: shell
shell: _mp-image
	multipass shell $(_MP_INSTANCE)

#---
echo:
	@echo A

.PHONY: all _mp-image _mp-exists shell echo
