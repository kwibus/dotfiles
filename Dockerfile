FROM archlinux:latest
RUN pacman -Syu --noconfirm zsh vim neovim stow git curl go make gcc rust yarn codespell zoxide
RUN useradd user -m
COPY . /home/user/dotfiles
RUN  chown -R user:user /home/user/  && chsh -s /bin/zsh
USER user
WORKDIR /home/user
RUN stow -d /home/user/dotfiles -t /home/user zsh 

RUN stow -d /home/user/dotfiles -t /home/user nvim \
  && nvim --headless "+Lazy! sync" +qa  \
  && nvim --headless "+checkhealth" +qa 



