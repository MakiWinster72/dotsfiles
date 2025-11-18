# =======================================
#        PYENV 初始化（Python版本管理）
# =======================================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# =======================================
#        Powerlevel10k 提示符优化
# =======================================
# 必须放在最前以减少启动延迟
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =======================================
#        Oh My Zsh 核心配置
# =======================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="sammy"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  fzf
)
source $ZSH/oh-my-zsh.sh

# =======================================
#        补全系统
# =======================================
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# =======================================
#        历史记录
# =======================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# =======================================
#        自动建议与语法高亮
# =======================================
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# =======================================
#        Powerlevel10k 配置文件加载
# =======================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =======================================
#        文件/文件夹显示增强
# =======================================
if command -v lsd &>/dev/null; then
  alias ls='lsd --group-dirs=first --icons'
  alias ll='lsd -lh --group-dirs=first --icons'
  alias la='lsd -lha --group-dirs=first --icons'
elif command -v exa &>/dev/null; then
  alias ls='exa --icons --group-directories-first'
  alias ll='exa -lh --icons --group-directories-first'
  alias la='exa -lha --icons --group-directories-first'
fi

# =======================================
#        FZF（模糊查找）
# =======================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =======================================
#        常用别名
# =======================================
alias cat='bat --style=plain --paging=never 2>/dev/null || cat'
alias grep='grep --color=auto'
alias cls='clear'
alias wechat='/opt/wechat/wechat'
alias nz='nvim ~/.zshrc'
alias sz='source ~/.zshrc'

# =======================================
#        Docker 管理命令
# =======================================
alias dksr='sudo systemctl start docker.service docker.socket'
alias dkst='docker stop $(docker ps -q) 2>/dev/null; sudo systemctl stop docker.service docker.socket'

# ---------- Paperless ----------
alias pplsr='docker start paperless-ai paperless-webserver-1 paperless-broker-1 paperless-gotenberg-1 paperless-tika-1 paperless-db-1'
alias pplst='docker stop paperless-ai paperless-webserver-1 paperless-broker-1 paperless-gotenberg-1 paperless-tika-1 paperless-db-1'

# ---------- Immich ----------
alias imsr='docker start immich_server immich_machine_learning immich_postgres immich_redis'
alias imst='docker stop immich_server immich_machine_learning immich_postgres immich_redis'


# ---------- WinApps ----------
alias wau='docker start WinApps'
alias wad='docker stop WinApps'

# =======================================
#        挂载 Aliyun 云盘函数
# =======================================
function mount_aliyun() {
    local CONFIG_NAME=$1
    local BUCKET=$2
    local MOUNT_SUBDIR=$3
    local MOUNT_POINT="$HOME/Documents/aliy/$MOUNT_SUBDIR"

    [ ! -d "$MOUNT_POINT" ] && mkdir -p "$MOUNT_POINT"

    if mountpoint -q "$MOUNT_POINT"; then
        echo "目录已挂载: $MOUNT_POINT"
    else
        echo "挂载 $CONFIG_NAME:$BUCKET 到 $MOUNT_POINT ..."
        rclone mount "$CONFIG_NAME:$BUCKET" "$MOUNT_POINT" --vfs-cache-mode writes &
        local COUNT=0
        while ! mountpoint -q "$MOUNT_POINT" && [ $COUNT -lt 10 ]; do
            sleep 0.5
            ((COUNT++))
        done
    fi
    cd "$MOUNT_POINT" || echo "切换目录失败"
}

# 快捷挂载命令
alias makislife='mount_aliyun "Aliyun" "makislife" "makislife"'
alias img_makislife='mount_aliyun "Aliyun" "aly-images472" "img-makislife"'
alias resources='mount_aliyun "Aliyun-Shenzhen" "res-shenzhen" "resources"'

# =======================================
#        Node.js / Cargo / WinApps / zoxide
# =======================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export FREERDP_COMMAND="xfreerdp3"
export WINAPPS_SRC_DIR="$HOME/.local/bin/winapps-src"
export BROSWER="/usr/bin/firefox"

eval "$(zoxide init --cmd cd zsh)"

# =======================================
#        快捷函数
# =======================================
nf() { nvim $(fzf); }
:q() { exit; }
ggd() {
  # 如果目录未挂载则挂载
  if ! mount | grep -q "$HOME/googleDrive"; then
    echo "🔗 正在挂载 Google Drive..."
    rclone mount ggdrive: "$HOME/googleDrive" --vfs-cache-mode full --daemon
    sleep 2
  else
    echo "✅ Google Drive 已挂载"
  fi
  cd "$HOME/googleDrive" || return
}


alias ni='niri-session'
alias nd='neovide'
alias nib='~/.local/bin/niri --config ~/.config/niri/config_blur.kdl'


# =======================================
#        加载密钥文件（可选）
# =======================================
[ -f ~/.env_keys ] && source ~/.env_keys
