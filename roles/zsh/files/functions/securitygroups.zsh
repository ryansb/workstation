function sg-range {
    # http://docs.aws.amazon.com/cli/latest/reference/ec2/authorize-security-group-ingress.html
    if (( ${#argv} < 3 )) ; then
        echo 'usage: sg-range MYGROUP 0 65535 [1.2.3.4]' >&2
        echo 'if IP not provided automatically uses your public IP' >&2
        return 1
    fi
    IPTOADD="$(curl -s ipv4.icanhazip.com)/32"
    if (( ${#argv} == 4 )) ; then
        IPTOADD="${4}/32"
    fi
    aws ec2 authorize-security-group-ingress --group-name "${1}" --from-port "${2}" --to-port "${3}" --ip-protocol tcp --cidr-ip "${IPTOADD}"
}

function sg-range-rm {
    # http://docs.aws.amazon.com/cli/latest/reference/ec2/revoke-security-group-ingress.html
    if (( ${#argv} < 3 )) ; then
        echo 'usage: sg-range-rm MYGROUP 0 65535 [1.2.3.4]' >&2
        echo 'if IP not provided automatically uses your public IP' >&2
        return 1
    fi
    IPTOADD="$(curl -s ipv4.icanhazip.com)/32"
    if (( ${#argv} == 4 )) ; then
        IPTOADD="${4}/32"
    fi
    aws ec2 revoke-security-group-ingress --group-name "${1}" --from-port "${2}" --to-port "${3}" --ip-protocol tcp --cidr-ip "${IPTOADD}"
}

function sg-single {
    # http://docs.aws.amazon.com/cli/latest/reference/ec2/authorize-security-group-ingress.html
    if (( ${#argv} < 2 )) ; then
        echo 'usage: sg-single MYGROUP 0 [1.2.3.4]' >&2
        echo 'if IP not provided automatically uses your public IP' >&2
        return 1
    fi
    IPTOADD="$(curl -s ipv4.icanhazip.com)/32"
    if (( ${#argv} == 3 )) ; then
        IPTOADD="${3}/32"
    fi
    aws ec2 authorize-security-group-ingress --group-name "${1}" --port "${2}" --protocol tcp --cidr "${IPTOADD}"
}

function sg-single-rm {
    # http://docs.aws.amazon.com/cli/latest/reference/ec2/revoke-security-group-ingress.html
    if (( ${#argv} < 2 )) ; then
        echo 'usage: sg-single-rm MYGROUP 0 [1.2.3.4]' >&2
        echo 'if IP not provided automatically uses your public IP' >&2
        return 1
    fi
    IPTOADD="$(curl -s ipv4.icanhazip.com)/32"
    if (( ${#argv} == 3 )) ; then
        IPTOADD="${3}/32"
    fi
    aws ec2 revoke-security-group-ingress --group-name "${1}" --port "${2}" --protocol tcp --cidr "${IPTOADD}"
}

function sg-http {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: sg-http MYGROUP [1.2.3.4]' >&2
        echo 'if IP not provided automatically uses your public IP' >&2
        return 1
    fi
    sg-single "${1}" 80 "${2}"
    sg-single "${1}" 443 "${2}"
}

function sg-http-rm {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: sg-http-rm MYGROUP [1.2.3.4]' >&2
        echo 'if IP not provided automatically uses your public IP' >&2
        return 1
    fi
    sg-single-rm "${1}" 80 "${2}"
    sg-single-rm "${1}" 443 "${2}"
}

function lssg {
    # if an argument is provided, it is passed as an egrep expression
    aws ec2 describe-security-groups --region us-east-1 | grep GroupName | sed -e 's/ *"GroupName": "\(.*\)".*/\1/' | sort -f | uniq | egrep --color=never -i -e "${1}"
}
