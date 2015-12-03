function osclone {
    # http://docs.aws.amazon.com/cli/latest/reference/ec2/authorize-security-group-ingress.html
    if (( ${#argv} < 1 )) ; then
        echo 'usage: osclone repo' >&2
        return 1
    fi
    cmd="git fastclone https://review.openstack.org/p/"
    if [[ $1 =~ '/' ]] then
        echo "${cmd}${1} ${@:2}"
    else
        echo "${cmd}openstack/${1} ${@:2}"
    fi
}
