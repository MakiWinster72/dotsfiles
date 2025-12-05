# =======================================
#        Oh My Zsh 核心配置
# =======================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  fzf
)
source $ZSH/oh-my-zsh.sh

# =======================================
#        补全
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
alias ag='google-antigravity .'
alias win='dksr && sleep 2 && wau && sleep 2 && xfreerdp3 /u:maki /p:4722 /v:127.0.0.1:3389 /size:1800x980 /sound:sys:alsa'

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
alias resources='mount_aliyun "Aliyun" "res-guangzhou" "resources"'

# =======================================
#        快捷函数
# =======================================
nf() { nvim $(fzf); }
:q() { exit; }

alias ni='niri-session'
alias nd='neovide'
alias nib='~/.local/bin/niri --config ~/.config/niri/config_blur.kdl'
alias ipa='ip addr show | grep -E "192|172"'
alias smb='sudo systemctl start smb'
alias nmb='sudo systemctl start nmb'

# =======================================
#        加载密钥文件（可选）
# =======================================
[ -f ~/.env_keys ] && source ~/.env_keys

