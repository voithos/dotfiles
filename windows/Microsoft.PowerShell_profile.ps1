# Aliases.
New-Alias -Name ll -Value Get-ChildItem
New-Alias -Name bazel -Value bazelisk
New-Alias -Name blaze -Value bazel
New-Alias -Name touch -Value New-Item

# Path aliases.
function Change-ProjectDir {
    Set-Location "C:\Users\Zaven\Projects"
}
function Change-ActiveDir {
    Set-Location "C:\Users\Zaven\Projects\Code\Active"
}
New-Alias -Name pd -Value Change-ProjectDir
New-Alias -Name pa -Value Change-ActiveDir