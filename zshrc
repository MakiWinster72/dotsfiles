# -------------------------------
# zplug 插件管理
# -------------------------------
export ZPLUG_HOME="$HOME/.zplug"
if [[ -f $ZPLUG_HOME/init.zsh ]]; then
    source $ZPLUG_HOME/init.zsh

    # 插件列表
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    # zplug "marlonrichert/zsh-autocomplete"
    zplug "wting/autojump"

    # 检查插件是否已安装
    if ! zplug check --verbose; then
        echo 'Run "zplug install" to install'
    fi

    # 加载插件并设置 PATH
    zplug load
fi

# 历史搜索快捷键
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# -------------------------------
# Oh My Zsh 配置
# -------------------------------
export ZSH="$HOME/.oh-my-zsh"

# 主题设置
ZSH_THEME="mgutz"
# 随机主题列表（仅在 ZSH_THEME=random 时生效）
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# 补全设置
# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# 自动更新设置
zstyle ':omz:update' mode auto
# zstyle ':omz:update' frequency 13

# ENABLE_CORRECTION="true"

# -------------------------------
# 插件与自定义配置
# -------------------------------
autoload -U compinit
compinit

# Oh My Zsh 插件
plugins=(git)

# 加载 Oh My Zsh
source $ZSH/oh-my-zsh.sh

# 自定义别名
alias zshconfig="nvim ~/.zshrc"

# -------------------------------
# 自定义函数
# -------------------------------
riji() {
    cd ~/project/daily || return
    gemini
}

makislife() {
    rclone mount Aliyun:makislife /mnt/makislife --vfs-cache-mode writes &
    sleep 2
    cd /mnt/makislife || return
}

pcstorage() {
    rclone mount Aliyun:pcstorage /mnt/pcstorage --vfs-cache-mode writes &
    sleep 2
    cd /mnt/pcstorage || return
}

# 本地环境变量
if [ -f ~/.zshrc.env.local ]; then
    source ~/.zshrc.env.local
fi
