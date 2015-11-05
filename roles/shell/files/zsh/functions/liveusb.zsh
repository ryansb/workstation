function liveusb {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: liveusb iso [/dev/sdb]' >&2
        echo 'If no device is provided, uses /dev/sdb' >&2
        return 1
    fi
    echo "Will run command:"
    echo "pv -s \$(du -sb ${1} | cut -f1) < ${1} | sudo dd of=${2:-/dev/sdb} bs=4K"
    echo "Press y to confirm"
    read choice
    echo    # (optional) move to a new line
    if [[ ! $choice =~ ^[Yy]$ ]]
    then
        return 1
    fi
    pv -s $(du -sb ${1} | cut -f1) < ${1} | sudo dd of=${2:-/dev/sdb} bs=4K
}
