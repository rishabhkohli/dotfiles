# --- Speed Optimization: Auto-compile .zshrc ---
if [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc
fi

# Zinit configuration
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 1. Universal Punchy Prompt (Visible in Light & Dark Modes)
zstyle ':prompt:pure:path' color cyan
zstyle ':prompt:pure:prompt:success' color magenta
zstyle ':prompt:pure:git:branch' color blue
zstyle ':prompt:pure:git:dirty' color red

# 2. Load Plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

# 3. Pure prompt setup
zinit ice pick"pure.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# 4. History & Key bindings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate commands from history
setopt HIST_REDUCE_BLANKS    # Remove extra spaces from history entries
setopt HIST_IGNORE_SPACE     # Don't save commands starting with a space

# Bindings for autosuggestions and history search
bindkey '^ ' autosuggest-accept
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# 5. Modern Tools & Aliases
# eza (modern ls)
alias ls="eza --icons --git --group-directories-first"
alias ll="eza -l --icons --git --group-directories-first"
alias la="eza -la --icons --git --group-directories-first"

# zoxide (smart cd)
eval "$(zoxide init zsh --cmd cd)"

# Auto-Directory Navigation
setopt AUTO_CD
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# 6. Completion System Configuration
autoload -Uz colors && colors
zstyle ':completion:*' menu select=0
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Minimalist formatting for completion menu
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:messages' format ' %d'
zstyle ':completion:*:warnings' format '-- No matches found: %d --'
zstyle ':completion:*' group-name ''

# Initialize completion system
autoload -Uz compinit && compinit

# 7. fzf Integration & Customization
export FZF_DEFAULT_OPTS="
  --height 40% 
  --layout reverse 
  --border rounded
  --inline-info
  --color='fg:-1,bg:-1,header:3,prompt:1,hl:3'
  --color='info:2,pointer:1,marker:1,spinner:1'
"
eval "$(fzf --zsh)"

# 8. Syntax Highlighting (MUST BE LAST)
zinit light zsh-users/zsh-syntax-highlighting
