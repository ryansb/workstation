
function idid {
    echo "${@}" | mail -s 'Ryan did' hudl@team.idonethis.com
    if [[ $? != 0 ]]
    then
        echo "failure $?"
    fi
}
