# 环境检测与基础设置
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="$EDITOR"
umask 022

# 仅在存在 oh-my-zsh 时启用
if [ -d "$ZSH" ]; then
ZSH_THEME="refined" # set by `omz`
  plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    fzf
  )
  source "$ZSH/oh-my-zsh.sh"
fi

# 补全
autoload -Uz compinit
if compinit 2>/dev/null; then
  :
else
  echo "compinit: 检测到不安全的 completion 目录，尝试修复权限..."
  if command -v compaudit >/dev/null 2>&1; then
    compaudit | xargs -r chmod g-w 2>/dev/null || true
  fi
  compinit 2>/dev/null || echo "compinit: 仍然失败，继续但可能会遇到补全问题。"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# 历史记录
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

if typeset -f history-substring-search-up >/dev/null 2>&1; then
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

# 自动建议与语法高亮
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="${ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE:-fg=8}"

# 外观 / ls 显示增强
if command -v lsd >/dev/null 2>&1; then
  alias ls='lsd --group-dirs=first --icons'
  alias ll='lsd -lh --group-dirs=first --icons'
  alias la='lsd -lha --group-dirs=first --icons'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa --icons --group-directories-first'
  alias ll='exa -lh --icons --group-directories-first'
  alias la='exa -lha --icons --group-directories-first'
else
  alias ll='ls -lh --group-directories-first 2>/dev/null || ls -lh'
  alias la='ls -lha --group-directories-first 2>/dev/null || ls -lha'
fi

# FZF
if [ -f "${HOME}/.fzf.zsh" ]; then
  source "${HOME}/.fzf.zsh"
fi

if command -v grep >/dev/null 2>&1; then
  alias grep='grep --color=auto'
fi


# 启动 Docker 服务
dksr() {
  if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl start docker.service docker.socket
  else
    echo "systemctl 不可用，尝试直接启动 dockerd（如已安装）..."
    command -v dockerd >/dev/null 2>&1 && sudo dockerd & disown
  fi
}
dkst() {
  # 停止所有容器，然后停止服务
  if command -v docker >/dev/null 2>&1; then
    local running
    running="$(docker ps -q 2>/dev/null || true)"
    if [ -n "$running" ]; then
      docker stop $running 2>/dev/null || true
    fi
  fi
  if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl stop docker.service docker.socket
  fi
}

# ---------- Paperless ----------
alias pplsr='docker start paperless-ai paperless-webserver-1 paperless-broker-1 paperless-gotenberg-1 paperless-tika-1 paperless-db-1 2>/dev/null || true'
alias pplst='docker stop paperless-ai paperless-webserver-1 paperless-broker-1 paperless-gotenberg-1 paperless-tika-1 paperless-db-1 2>/dev/null || true'

# ---------- Immich ----------
alias imsr='docker start immich_server immich_machine_learning immich_postgres immich_redis 2>/dev/null || true'
alias imst='docker stop immich_server immich_machine_learning immich_postgres immich_redis 2>/dev/null || true'

# ---------- WinApps ----------
alias wau='docker start WinApps 2>/dev/null || true'
alias wad='docker stop WinApps 2>/dev/null || true'

mount_aliyun() {
  local CONFIG_NAME="$1"
  local BUCKET="$2"
  local MOUNT_SUBDIR="$3"
  local MOUNT_POINT="$HOME/Documents/aliy/${MOUNT_SUBDIR}"

  if [ -z "$CONFIG_NAME" ] || [ -z "$BUCKET" ] || [ -z "$MOUNT_SUBDIR" ]; then
    echo "用法: mount_aliyun <CONFIG_NAME> <BUCKET> <MOUNT_SUBDIR>"
    return 2
  fi

  mkdir -p "$MOUNT_POINT"

  if mountpoint -q "$MOUNT_POINT"; then
    echo "目录已挂载: $MOUNT_POINT"
  else
    if ! command -v rclone >/dev/null 2>&1; then
      echo "rclone 未安装或不可用，无法挂载 $CONFIG_NAME:$BUCKET"
      return 1
    fi
    echo "挂载 $CONFIG_NAME:$BUCKET 到 $MOUNT_POINT ..."
    nohup rclone mount "${CONFIG_NAME}:${BUCKET}" "${MOUNT_POINT}" --vfs-cache-mode writes \
      >/tmp/rclone-mount-${BUCKET}.log 2>&1 &
    disown

    # 等待短暂时间以确认挂载是否生效
    local COUNT=0
    while ! mountpoint -q "$MOUNT_POINT" && [ "$COUNT" -lt 10 ]; do
      sleep 0.5
      ((COUNT++))
    done

    if mountpoint -q "$MOUNT_POINT"; then
      echo "挂载成功：$MOUNT_POINT"
    else
      echo "挂载可能失败，请检查 /tmp/rclone-mount-${BUCKET}.log"
    fi
  fi

  # 尝试进入挂载点，但不要因为失败中断 shell
  cd "$MOUNT_POINT" 2>/dev/null || true
}

# 挂载命令
alias makislife='mount_aliyun "Aliyun" "makislife" "makislife"'
alias img_makislife='mount_aliyun "Aliyun" "aly-images472" "img-makislife"'
alias resources='mount_aliyun "Aliyun" "res-guangzhou" "resources"'


:q() { exit; }

alias ni='niri-session'
alias nd='neovide'
alias ipa='ip addr show | grep -E "192|172"'
alias lh='ls -lh'
alias t='tmux'
alias li="gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'"
alias dk="gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
alias dolphin='export ALL_PROXY= && dolphin'
alias web='browser-sync start --server --files "**/*.*"'

# 加载密钥
if [ -f "${HOME}/.env_keys" ]; then
  source "${HOME}/.env_keys"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# 在缓存行中打开输入
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# 切换目录的时候自动ls
chpwd() {
  ls
}

# 定义后缀操作
alias -s md='glow -p'
alias -s mov="open"
alias -s png="open"
alias -s mp4="open"
alias -s go="$EDITOR"
alias -s js="$EDITOR"
alias -s ts="$EDITOR"
alias -s yaml="bat -l yaml"
alias -s json="jless"

bindkey -s '^Xgc' 'git commit -m ""\C-b'

