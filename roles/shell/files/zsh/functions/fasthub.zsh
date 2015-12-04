function fasthub {
    if (( ${#argv} < 1 )) ; then
        echo "usage: \`fasthub user/project\`" >&2
        echo "or: \`fasthub project\` IFF the project is under your username's user" >&2
        return 1
    fi

    base="git@github.com:"
    if [[ $1 =~ '/' ]] then
        git fastclone ${base}${1} ${@:2}
    else
        git fastclone ${base}$(whoami)/${1} ${@:2}
    fi
}
alias fh=fasthub

function sbhub {
    if (( ${#argv} < 1 )) ; then
        echo "usage: \`sbhub project\`" >&2
        return 1
    fi

    git fastclone git@git.ryansb.com:${1}.git ${1}
}
