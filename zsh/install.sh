#!/bin/bash -e

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
ln -fs `pwd`/zshrc ~/.zshrc
ln -fs `pwd`/zshenv ~/.zshenv
ln -fs `pwd`/zsh_alias ~/.zsh_alias


