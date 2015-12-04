function osclone {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: osclone repo' >&2
        return 1
    fi

    base="https://review.openstack.org/p/"
    if [[ $1 =~ '/' ]] then
        git fastclone ${base}${1} ${@:2}
    else
        git fastclone ${base}openstack/${1} ${@:2}
    fi
}
