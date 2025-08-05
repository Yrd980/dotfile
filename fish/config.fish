source ~/.config/fish/user_variables.fish

export ALIYUNPAN_CONFIG_DIR=/home/yrd/documents/my_config/aliyunpan/
set -Ux CHROME_EXECUTABLE /sbin/google-chrome-stable
set -x CMAKE_PREFIX_PATH /usr/lib/cmake

set -x http_proxy http://127.0.0.1:7897
set -x https_proxy http://127.0.0.1:7897
set -x all_proxy socks5://127.0.0.1:7891
