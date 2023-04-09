# Setup script for Windows configuration.

# Configure symlinks for config files.
$Dotfiles = Split-Path $PSScriptRoot
pushd $Home

cmd /c mklink .gitconfig "$Dotfiles\git\gitconfig"
cmd /c mklink "$env:APPDATA\Code\User\settings.json" "$Dotfiles\vscode\settings.json"
cmd /c mklink "$env:APPDATA\Code\User\keybindings.json" "$Dotfiles\vscode\keybindings.json"
cmd /c mklink "$env:APPDATA\Aseprite\user.aseprite-brushes" "$Dotfiles\aseprite\user.aseprite-brushes"
cmd /c mklink "$env:APPDATA\Aseprite\user.aseprite-keys" "$Dotfiles\aseprite\user.aseprite-keys"
cmd /c mklink /D "$env:APPDATA\Aseprite\palettes" "$Dotfiles\aseprite\palettes"

popd