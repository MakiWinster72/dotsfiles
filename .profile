export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
# export FCITX5_USE_WAYLAND=1 # 这是必要的，用于支持 Wayland 输入法

export NO_PROXY=maki,localhost,master,192.168.1.0/24,172.20.10.0/28

# =======================================
#        环境变量配置
# =======================================
# JAVA
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk/
export PATH=$JAVA_HOME/bin:$PATH

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Node.js / NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PATH=/home/maki/.local/bin:$PATH
export EDITOR="nvim"
export FREERDP_COMMAND="xfreerdp3"
export WINAPPS_SRC_DIR="$HOME/.local/bin/winapps-src"
export BROSWER="/usr/bin/firefox"
eval "$(zoxide init --cmd cd zsh)"
