function up --wraps='yay -Syu --noconfirm' --description 'alias up=yay -Syu --noconfirm'
    if type -f yay &>/dev/null
        yay -Syu $argv --noconfirm
    else
        pacman -Syu $argv
    end
end
