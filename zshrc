# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$PATH
if [[ -d "~/.config/bin" ]]; then
  export PATH="~/.config/bin:$PATH"
fi
export BAT_THEME="Nord"
export EDITOR=nvim

alias gi=git
alias vim=nvim

eval "$(fnm env)"

fnm_echo() {
  command printf %s\\n "$*" 2>/dev/null
}
# Traverse up in directory tree to find containing folder
fnm_find_up() {
  local path_
  path_="${PWD}"
  while [ "${path_}" != "" ] && [ ! -f "${path_}/${1-}" ]; do
    path_=${path_%/*}
  done
  fnm_echo "${path_}"
}

fnm_find_nvmrc() {
  local dir
  dir="$(fnm_find_up '.nvmrc')"
  if [ -e "${dir}/.nvmrc" ]; then
    fnm_echo "${dir}/.nvmrc"
  fi
}

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(fnm current)"
  local nvmrc_path="$(fnm_find_nvmrc)"
  local default="$(fnm list | grep default)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version="$(cat "${nvmrc_path}")"

    if [ "$nvmrc_node_version" != "$node_version" ]; then
      fnm use --install-if-missing
    fi
  elif [[ "$default" != *"$node_version"* ]]; then
    fnm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load completion scripts
autoload -Uz compinit
compinit

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}● %f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}● %f" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b %m%c%u] ' # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'

function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue}● %f"
  fi
}
precmd () { vcs_info }

RPROMPT_BASE='${vcs_info_msg_0_}%F{blue}%~%f'
setopt PROMPT_SUBST

# Anonymous function to avoid leaking variables.
function () {
  # Check for tmux by looking at $TERM, because $TMUX won't be propagated to any
  # nested sudo shells but $TERM will.
  # For some reason I have screen as my $TERM in tmux because of reasons...
  local TMUXING=$([[ "$TERM" =~ "screen" ]] && echo tmux)
  if [ -n "$TMUXING" -a -n "$TMUX" ]; then
    # In a a tmux session created in a non-root or root shell.
    local LVL=$(($SHLVL - 1))
  elif [ -n "$XAUTHORITY" ]; then
    # Probably in X on Linux.
    local LVL=$(($SHLVL - 2))
  else
    # Either in a root shell created inside a non-root tmux session,
    # or not in a tmux session.
    local LVL=$SHLVL
  fi
  local SUFFIX='%(!.%F{yellow}%n%f.)%(!.%F{yellow}.%F{blue})'$(printf '\u276f%.0s' {1..$LVL})'%f'

  export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%B%1~%b%F{yellow}%B%(1j.*.)%(?..!)%b%f %B${SUFFIX}%b "
  if [[ -n "$TMUXING" ]]; then
    # Outside tmux, ZLE_RPROMPT_INDENT ends up eating the space after PS1, and
    # prompt still gets corrupted even if we add an extra space to compensate.
    export ZLE_RPROMPT_INDENT=0
  fi
}

export RPROMPT=$RPROMPT_BASE
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
