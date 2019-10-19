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
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

export MAKEFLAGS="-j $(nproc --all) $MAKEFLAGS"

