function td {
    if (( ${#argv} < 2 )) ; then
        echo 'usage: do "datelike" task...' >&2
        echo 'Adds to your todo list, with a due date attached' >&2
        return 1
    fi
    day=`date +%Y-%m-%d --date "${1}" 2>/dev/null`
    if (( $? == 0 )) ; then
        todo add $(date +%Y-%m-%d) ${@:2} due:`date +%Y-%m-%d --date "${1}"`
    else
        echo "Bad date \"${1}\", try again" >&2
        return 1
    fi
}
