#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
fi

# Wrap nvm up to stop it slowing login to a crawl
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"

    loadnvm() {
        source "$NVM_DIR/nvm.sh"
        return $?;
    }

     nvm() {
        unset -f nvm;
        loadnvm && nvm $*;
    }

    # Add lowest alphanumeric nvm env to NVM_PATH. This obviously only works
    # well if you only have a single env available, if the first one is the one
    # you actually use, or you can symlink "0" to the actual version you use.
    # (Pick your preferred poison)
    NVM_PATH="$HOME/.nvm/versions/node/$(ls -1 "$HOME/.nvm/versions/node" | sort | head -n1)/bin"
    export PATH="$NVM_PATH:$PATH"
fi

export MAKEFLAGS="-j $(nproc --all) $MAKEFLAGS"

/usr/bin/setxkbmap -option ctrl:nocaps
xmodmap -e "keycode 37="



