#!/bin/bash

# stop if error
set -e 

if [ -z "$HOME" ]; then
  printf "The \$HOME variable is not set. Can't run the setup"
  exit 1
fi

TP_PWD=$(pwd)
TP_NVIM_CONFIG_SOURCE="$TP_PWD/.config/nvim"
TP_NVIM_CONFIG_TARGET="$HOME/.config/nvim"
TP_NVIM_AUTOLOAD="autoload"
TP_NVIM_PLUGGED="config-plugged"
TP_NVIM_CONFIG_BASH="bash_config.txt"
TP_TOOLS_NOK=

tools=(
    "git"
    "nvim"
    "tmux"
    "python3"
    "pip3"
    "node"
    "npm"
    "yarn"
    "bash")

# check if tools are installed
printf "Check if all required tools are installed:\n"
for i in "${!tools[@]}"; do
  if [ -x "$(command -v ${tools[$i]})" ]; then
    printf "OK  ${tools[$i]} is installed.\n"
  else
    printf "ERR ${tools[$i]} is not installed. Please install ${tools[$i]}.\n"
    TP_TOOLS_NOK="KO"
  fi
done

# exit if there is a tool missing
if ! [ -z "$TP_TOOLS_NOK" ]; then
  printf "Setup is aborted.\n"
  exit 1
fi

printf "All required tools are installed.\n"

# install python bindings
printf "Installing python3 bindings ...\n"
pip3 install pynvim
printf "Python3 bindings have been installed.\n"

# install python bindings
printf "Installing npm bindings ...\n"
npm install -g neovim
printf "Npm bindings have been installed.\n"

# cleanup nvim config folders
printf "Setting up symbolic links ...\n"
mkdir -p $TP_NVIM_CONFIG_TARGET
cd $TP_NVIM_CONFIG_TARGET
rm -rf $TP_NVIM_AUTOLOAD
rm -rf $TP_NVIM_PLUGGED

# generate symbolic links for tmux
cd $HOME 
ln -f -s "$TP_PWD/.tmux.conf" 

# generate symbolic links for nvim 
#cd ${TP_NVIM_CONFIG_TARGET}
cd $TP_NVIM_CONFIG_TARGET
ln -f -s "$TP_NVIM_CONFIG_SOURCE/init.vim" 
ln -f -s "$TP_NVIM_CONFIG_SOURCE/$TP_NVIM_PLUGGED"
ln -f -s "$TP_NVIM_CONFIG_SOURCE/$TP_NVIM_AUTOLOAD" 

printf "Symbolic link setup completed.\n"

# adjust bashrc config file
printf "Updating bash configuration ...\n"
if [ -f "$HOME/.bashrc" ]; then

  TP_SOURCE_CMD="source \"$TP_PWD/$TP_NVIM_CONFIG_BASH\""
  if [ $(grep -e "$TP_SOURCE_CMD" < "$HOME/.bashrc" | wc -l ) = 0 ]; then
    echo "" >> "$HOME/.bashrc"
    echo "# Import personal bash configuration" >> "$HOME/.bashrc"
    echo $TP_SOURCE_CMD >> "$HOME/.bashrc"
    printf "Appended the following line to $HOME/.bashrc: $TP_SOURCE_CMD\n"
    printf "Bash configuration updated.\n"
    cd $TP_PWD
    source $TP_NVIM_CONFIG_BASH
  else
    printf ".bashrc is already correctly configured. Nothing to do.\n"
  fi
  printf "Setup completed successfully.\n"

else
  printf "Didn't find the .bashrc file. Skipped .bashrc config.\n"
fi

cd $TP_PWD

