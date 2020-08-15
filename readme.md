# How to setup vim+tmux config on a new machine
1. mkdir ~/.dotfiles
1. cd ~/.dotfiles
1. git clone https://github.com/tp-space/vim-config.git .
1. ./setup.sh

# Install NVIM from source
Within an empty folder, do:
1. git clone https://github.com/neovim/neovim.git
1. cd neovim
1. git checkout stable
1. make CMAKE\_BUILD\_TPYE=RelWithDebInfo
1. sudo make install
Major required build tools: autoconf automake cmake g++."

# Launch nvim the first time
1. Make sure to exit all existing vim, tmux and bash instances
1. Launch a new bash shell
1. Launch tmux
1. Launch nvim
1. Check if everything is fine with :checkhealth
1. Install plugin with :PluginInstall
Now your are all set

# Commit changes to github
First you need to provide information about the user committing the changes.
To configure the git settings, enter below command:
- git config --\<flag\> user.name "\<name\>"
- git config --\<flag\> user.email "\<email\>"
The flag can be set to _local_, _global_ or _system_. The default value is _local_.

You can't use nvim to push the repository to github (no iterative session to receive pwd).
So just type in the bash: git push origin master

