function booksend {
    echo "This doesn't actually work"
    exit 99
    echo "none" | mail -s 'new book' ryansb_60@free.kindle.com -a "${@}"
    if [[ $? != 0 ]]
    then
        echo "failure $?"
    fi
}
