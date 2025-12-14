FROM archlinux:latest
RUN pacman-key --init &&  pacman -Syu --noconfirm  \
  git curl stow \
  zsh zsh-syntax-highlighting pkgfile zoxide \
  vim neovim go make gcc rustup yarn codespell unzip wget ripgrep fd fzf jq stylua terraform prettier python-pip tree-sitter-cli  npm uv
RUN useradd user -m

# SHELL ["bin/zsh", "-c"]
ENV PATH="$PATH:/home/user/.local/bin"
# RUN --mount=type=cache,target=/home/user/.local \

WORKDIR /home/user

COPY ./lazy_boostrap.lua  /home/user/.config/nvim/init.lua
COPY ./nvim/.config/nvim/lazy-lock.json   /home/user/.config/nvim/
RUN  chown -R user:user /home/user/  && chsh -s /bin/zsh
USER user
RUN  npm config set prefix '~/.local' \
  && rustup default stable \
  && tree-sitter init-config

RUN nvim --headless +Lazy restore +qa && rm -rf /home/user/.config/nvim/

COPY  --chown=user:user . /home/user/dotfiles
RUN stow -d /home/user/dotfiles -t /home/user zsh nvim
RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless "+checkhealth" +qa

ENTRYPOINT ["zsh"]
