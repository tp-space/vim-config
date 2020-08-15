#!/bin/bash

TP_PWD=$(pwd)
TP_NVIM_CONFIG=".config/nvim"
TP_NVIM_AUTOLOAD="$TP_NVIM_CONFIG/autoload"
TP_NVIM_CONFIG_PLUGGED="$TP_NVIM_CONFIG/config-plugged"

all_tool_names=(
    "nvim", 
    "tmux", 
    "python3", 
    "pip3", 
    "npm", 
    "bash")
all_tool_msgs=(
    "From source: git clone https://github.com/neovim/neovim.git.\n 
    git checkout stable.\n 
    make CMAKE_BUILD_TPYE=RelWithDebInfo.\n 
    sudo make install.\n
    Major required build tools: autoconf automake cmake g++", 
    "", 
    "", 
    "", 
    "",
    "Setup assumes presence of bash")

# check if tools are installed
for i in "${all_tool_names[@]}"; do
  if ! [ -x "$(command -v nvim)" ]; then
    echo "$i is not installed. Please install $i"
    echo "${all_tool_msgs[$i]}"
    echo "Setup is aborted."
    exit 1
  fi
done

# make sure config folder for nvim exists
mkdir -p ~/$TP_NVIM_AUTOLOAD
mkdir -p ~/$TP_NVIM_CONFIG_PLUGGED

# generate symbolic links for tmux
ln -s -f -t "~/" "$TP_PWD/.tmux.conf"

# generate symbolic links for nvim 
ln -s -f -t "~/$TP_NVIM_AUTOLOAD" "$TP_PWD/$TP_NVIM_AUTOLOAD"
ln -s -f -t "~/$TP_NVIM_CONFIG_PLUGGED" "$TP_PWD/$TP_NVIM_CONFIG_PLUGGED"
ln -s -f -t "~/$TP_NVIM_CONFIG" "$TP_PWD/$TP_NVIM_CONFIG/init.vim"

if [ -f "~/.bashrc" ]; then

  # adjust bashrc config file
  tp_source_cmd="source $pwd/bash_config.txt"
  if [ $(grep -e "$tp_source_cmd" < ~/.bashrc | wc -l ) = 0 ]; then
    echo $tp_source_cmd >> ~/.bashrc
    echo "Appended the following line to ~/.bashrc: $tp_source_cmd"
  else
    echo ".bashrc config already present. Nothing to do"
  fi

else
  echo "Didn't found .bashrc file. Skipped .bashrc config"
fi
