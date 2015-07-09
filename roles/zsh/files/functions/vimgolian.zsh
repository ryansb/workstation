function vimgolian {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: vimgolian mongouri' >&2
        return 1
    fi
    (echo "rs.status()" | mongo "${1}" >/dev/null) || return 1
    orig_rs_conf=$(echo 'rs.conf()' | mongo "${1}" | sed -e 1,2d | head -n-1)
    new_rs_conf=$(echo "${orig_rs_conf}" | vipe)
    if [ "${new_rs_conf}" = "${orig_rs_conf}" ] ; then
        echo "Same stuff. Doing nothing"
    else
        echo "differences exist. Validating JSON"
        (echo "${new_rs_conf}" | jq . >/dev/null) || return 1
        echo "Executing rs.reconfig"
        echo "rs.reconfig(${new_rs_conf})" | mongo "${1}"
    fi
}

function vimgolian-status {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: vimgolian-status mongouri' >&2
        return 1
    fi
    (echo "rs.status()" | mongo "${1}" | sed -e 1,2d | head -n-1 | $PAGER ) || return 1
}

function vimgolian-summary {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: vimgolian-summary rsmem [p|s]' >&2
        return 1
    fi
    PRE=${2-p}

    DOMAIN=""
    if [ "${PRE}" = "s" ] ; then
        DOMAIN="app.staghudl.com"
    else
        DOMAIN="app.hudl.com"
    fi

    MONGO_HOST="${PRE}-mongo-rs${1}.${DOMAIN}:27018"
    (echo "rs.status()" | mongo "${MONGO_HOST}" | grep stateStr | sed -e 's/^.*: "\(.*\)".*$/\1/' | sort | uniq -c) || return 1
}
