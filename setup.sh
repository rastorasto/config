
#!/bin/bash

#ohmyzsh theme name kafeitu

# Create required directories
mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd
mkdir -p ~/.config/nvim/lua/plugins

# Create symbolic links
ln -sf $PWD/.zprofile ~/.zprofile
ln -sf $PWD/.zshrc ~/.zshrc
ln -sf $PWD/nvim ~/.config/nvim
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.hushlogin ~/.hushlogin
ln -sf $PWD/skhdrc ~/.config/skhd/skhdrc
ln -sf $PWD/openiterm2.sh ~/.config/skhd/openiterm2.sh
ln -sf $PWD/yabairc ~/.config/yabai/yabairc

echo "Symlinks created"

# Define an array of symlink checks
declare -A symlinks=(
    ["~/.zprofile"]="$PWD/.zprofile"
    ["~/.zshrc"]="$PWD/.zshrc"
    ["~/.config/nvim"]="$PWD/nvim"
    ["~/.vimrc"]="$PWD/.vimrc"
    ["~/.hushlogin"]="$PWD/.hushlogin"
    ["~/.config/skhd/skhdrc"]="$PWD/skhdrc"
    ["~/.config/skhd/openiterm2.sh"]="$PWD/openiterm2.sh"
    ["~/.config/yabai/yabairc"]="$PWD/yabairc"
)

# Check if all symlinks were created correctly
echo "Checking symlinks..."
for link in "${!symlinks[@]}"; do
    target=${symlinks[$link]}
    resolved_link=$(readlink -f "${link/#\~/$HOME}")
    resolved_target=$(readlink -f "${target/#\~/$HOME}")

    if [ "$resolved_link" = "$resolved_target" ]; then
        echo "✔ Symlink verified: $link -> $target"
    else
        echo "✘ Symlink FAILED: $link (expected $target)"
    fi
done

