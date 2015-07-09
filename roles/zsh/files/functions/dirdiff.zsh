function dirdiff {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: dirdiff directory [directory]' >&2
        return 1
    fi
    first_hash=$(find ${1} -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum | awk '{print $1}')
    if (( ${#argv} == 1 )) ; then
        echo "${first_hash} - ${1}"
        return 0
    fi
    second_hash=$(find ${2} -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum | awk '{print $1}')
    if [[ ! -z $second_hash ]] ; then
        echo "${first_hash} - ${1}"
        echo "${second_hash} - ${2}"
        if [[ ${first_hash} =~ ${second_hash} ]] ; then return 0 ; else return 1 ; fi
    fi
}
