# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========= 基础设置 =========
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"  # 推荐使用 p10k 主题
plugins=(
  git
  zsh-autosuggestions    # 自动命令建议
  zsh-syntax-highlighting # 语法高亮
  zsh-history-substring-search # 历史记录搜索
  fzf                    # 模糊查找
)

source $ZSH/oh-my-zsh.sh

# ========= 补全系统 =========
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # 忽略大小写补全

# ========= 历史记录设置 =========
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS   # 忽略重复命令
setopt HIST_IGNORE_SPACE  # 忽略以空格开头的命令
setopt HIST_VERIFY
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# ========= 自动建议 =========
# (插件 zsh-autosuggestions 必须安装)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# ========= 路径提示 =========
# 命令行提示符由 p10k 控制，支持路径缩写和图标
# 若未运行过配置，可执行： p10k configure
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ========= 文件/文件夹图标显示 =========
# 推荐使用 lsd 或 exa，替换 ls
if command -v lsd &>/dev/null; then
  alias ls='lsd --group-dirs=first --icons'
  alias ll='lsd -lh --group-dirs=first --icons'
  alias la='lsd -lha --group-dirs=first --icons'
elif command -v exa &>/dev/null; then
  alias ls='exa --icons --group-directories-first'
  alias ll='exa -lh --icons --group-directories-first'
  alias la='exa -lha --icons --group-directories-first'
fi

# ========= FZF 增强 =========
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ========= 常用别名 =========
alias cat='bat --style=plain --paging=never 2>/dev/null || cat'
alias grep='grep --color=auto'
alias cls='clear'


# 通用函数：挂载 Aliyun bucket 并进入目录
function mount_aliyun() {
    local CONFIG_NAME=$1
    local BUCKET=$2
    local MOUNT_POINT="/mnt/$3"

    # 创建挂载目录
    [ ! -d "$MOUNT_POINT" ] && mkdir -p "$MOUNT_POINT"

    # 挂载，如果已经挂载则提示
    if mountpoint -q "$MOUNT_POINT"; then
        echo "目录已挂载: $MOUNT_POINT"
    else
        echo "挂载 $CONFIG_NAME:$BUCKET 到 $MOUNT_POINT ..."
        rclone mount "$CONFIG_NAME:$BUCKET" "$MOUNT_POINT" --vfs-cache-mode writes &
        # 循环等待挂载完成
        local COUNT=0
        while ! mountpoint -q "$MOUNT_POINT" && [ $COUNT -lt 10 ]; do
            sleep 0.5
            ((COUNT++))
        done
    fi

    # 切换到挂载目录
    cd "$MOUNT_POINT" || echo "切换目录失败"
}

# 快捷函数/别名
function makislife() { mount_aliyun "Aliyun" "makislife" "makislife"; }
function img_makislife() { mount_aliyun "Aliyun" "aly-images472" "img-makislife"; }
function resources() { mount_aliyun "Aliyun-Shenzhen" "res-shenzhen" "resources"; }
