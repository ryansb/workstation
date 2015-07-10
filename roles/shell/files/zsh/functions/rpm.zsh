# which rpm owns this executable
rpmwhich () { rpm -qf "$(which ${1})" }

# find installed rpms matching provided query
rpmgrep () { rpm -qa | grep "${1}" }

# find . shortcut
ff () { find . -name "*${1}*" }

# rpmbuild for specfile in current dir (use: `rpmb -bb` or `rpmb -bs`)
rpmb () {
    rpmbuild ./*.spec --define "_sourcedir ${PWD}" \
                      --define "_specdir ${PWD}" \
                      --define "_srcrpmdir ${PWD}" \
                      --define "_rpmdir ${PWD}" \
                      ${@}
}
