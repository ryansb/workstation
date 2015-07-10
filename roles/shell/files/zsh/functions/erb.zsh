function erbcheck {
    if (( $# < 1 )) ; then
        echo 'usage: erbcheck first.erb second.erb ...' >&2
        echo 'Checks syntax of all ERB templates provided' >&2
        return 1
    fi
    for tmpl
    do
        echo "Checking ${tmpl}: $(erb -x -T '-' $tmpl | ruby -c)"
    done
}
