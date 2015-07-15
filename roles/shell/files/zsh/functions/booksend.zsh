function booksend {
    echo 'body' | mail -s 'new book' -a "${@}" ryansb_60@free.kindle.com
    out=$?
    if [[ $out != 0 ]]
    then
        echo "failure $out"
    fi
}
