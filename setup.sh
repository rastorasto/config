#!/bin/bash

# Create required directories
mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd
mkdir -p ~/.config/nvim/lua/plugins

# Create symbolic links
ln -sf "$PWD/.zprofile" "$HOME/.zprofile"
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/nvim" "$HOME/.config/nvim"
ln -sf "$PWD/.vimrc" "$HOME/.vimrc"
ln -sf "$PWD/.hushlogin" "$HOME/.hushlogin"
ln -sf "$PWD/skhdrc" "$HOME/.config/skhd/skhdrc"
# ln -sf "$PWD/openiterm2.sh" "$HOME/.config/skhd/openiterm2.sh"
ln -sf "$PWD/yabairc" "$HOME/.config/yabai/yabairc"

echo "Symlinks created"

# Define an array of symlink checks
declare -A symlinks=(
    ["$HOME/.zprofile"]="$PWD/.zprofile"
    ["$HOME/.zshrc"]="$PWD/.zshrc"
    ["$HOME/.config/"]="$PWD/nvim"
    ["$HOME/.vimrc"]="$PWD/.vimrc"
    ["$HOME/.hushlogin"]="$PWD/.hushlogin"
    ["$HOME/.config/skhd/skhdrc"]="$PWD/skhdrc"
    ["$HOME/.config/skhd/openiterm2.sh"]="$PWD/openiterm2.sh"
    ["$HOME/.config/yabai/yabairc"]="$PWD/yabairc"
)

# Check if all symlinks were created correctly
echo "Checking symlinks..."
for link in "${!symlinks[@]}"; do
    target=${symlinks[$link]}
    resolved_link=$(readlink -f "$link" 2>/dev/null || echo "NOT FOUND")
    resolved_target=$(readlink -f "$target" 2>/dev/null || echo "NOT FOUND")

    if [ "$resolved_link" = "$resolved_target" ]; then
        echo "✔ Symlink verified: $link -> $target"
    else
        echo "✘ Symlink FAILED: $link (expected $target, found $resolved_link)"
    fi
done

