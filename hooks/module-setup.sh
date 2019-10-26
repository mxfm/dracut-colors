#!/bin/bash

# called by dracut
check() {
    require_binaries /bin/setcolors
}

# called by dracut
depends() {
    return 0
}

# called by dracut
install() {

    [[ -s /etc/vconsole.conf ]] && . /etc/vconsole.conf
        
    COLORS=""
        
    for COLOR_ID in $(seq 0 15)
    do
        COLOR=$(eval "echo \$COLOR_${COLOR_ID}")

        if [[ ! "$COLOR" ]]
        then
            warn "colors: Not all colors specified in configuration"
        fi

        COLORS="${COLORS}${COLOR_ID}#${COLOR}\n"
    done

    echo -ne "$COLORS" > "$moddir/colors"
    
    inst /bin/setcolors
    inst "$moddir/colors" "/etc/colors"
    inst_hook cmdline 10 "$moddir/setcolors.sh"
}
