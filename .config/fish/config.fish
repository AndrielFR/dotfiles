set -U fish_greeting

if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin jorgebucaran/autopair.fish
fundle plugin nickeb96/puffer-fish
fundle plugin franciscolourenco/done
fundle plugin PatrickF1/fzf.fish

fundle init

if status is-interactive
    fish_config theme choose Base16\ Default\ Dark
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block
end

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf accept-autosuggestion
end

if status is-login
    set -U DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

    set -U XDG_CONFIG_HOME "$HOME/.config"
    set -U XDG_CACHE_HOME "$HOME/.cache"
    set -U XDG_USER_LOCAL "$HOME/.local"
    set -U XDG_DATA_HOME "$HOME/.local/share"

    set -x GOPATH "$XDG_DATA_HOME/go"
    set -x CARGO_HOME "$XDG_DATA_HOME/.cargo"
    set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
    set -U XCURSOR_PATH "/usr/share/icons:$XDG_DATA_HOME/icons"

    fish_add_path "$HOME/.local/bin" "$CARGO_HOME/bin" "$GOPATH/bin"

    if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]
        set -U QT_STYLE_OVERRIDE "adwaita"
        set -U QT_QPA_PLATFORMTHEME "qt6ct"

	exec sx 2>/dev/null
    end
end

alias cdl 'cd ~/.local'
alias cdc 'cd ~/.config'
alias cdca 'cd ~/.cache'
alias g 'git'
alias gp 'git push'
alias wttr 'curl "wttr.in/?Q"'
alias vi 'nvim'
alias cp 'cp -iv'
alias mv 'mv -iv'
alias rm 'rm -iv'
alias df 'df -h'
alias diff 'diff --color=auto'
alias xrdb-update 'xrdb $HOME/.Xresources'
alias activate 'source .venv/bin/activate.fish'
alias orphans 'pacman -Qtdq | doas pacman -Rns -'
alias grep 'rg --hidden --smart-case --color=auto'
alias l 'ls --group-directories-first --color=auto'
alias ls 'ls --group-directories-first --color=auto'
alias la 'ls -A --group-directories-first --color=auto'
alias ll 'ls -lh --group-directories-first --color=auto'
alias lla 'ls -lAh --group-directories-first --color=auto'

starship init fish | source
