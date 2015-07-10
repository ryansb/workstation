alias gap="git add -p"
alias gst="git status -s"
alias gps="git push --set-upstream"
alias gsss="echo \`gs -s|grep M|wc -l\`M,\`gs -s|grep D|wc -l\`D,\`gs -s|grep ??|wc -l\`?"
alias yolo="git commit -a -m 'deal with it.'; git push --force"
alias gcheat="echo 'Git
Branch (b)
Commit (c)
Conflict (C)
Data (d)
Fetch (f)
Grep (g)
Index (i)
Log (l)
Merge (m)
Push (p)
Rebase (r)
Remote (R)
Stash (s)
Submodule (S)
Working Copy (w)'"
alias gfull="less ~/.dotfiles/zsh/.zprezto/modules/git/alias.zsh"

# gh tool
alias ghpr="gh pull-request"

alias getgh="go get -u -v github.com/jingweno/gh"

function quickpr {
    if (( ${#argv} < 2 )) ; then
        echo 'usage: quickpr newBranchName "Some commit message/PR title"' >&2
        return 1
    fi
    git add -p
    git checkout -b ${1}
    git commit -m ${2}
    git push --set-upstream origin ${1}
    gh pull-request -b master -h ${1} -m "${2}"
}
