function trackage() {
    if (( ${#argv} < 1 )) ; then
        echo 'usage: trackage <tracking number>...' >&2
        return 1
    fi

    boxoh="http://www.boxoh.com/?PageSpeed=noscript"

    for pkg
    do
        pkg_stat=$(curl -L -s "${boxoh}&rss=1&t=${pkg}" | xmllint --xpath '//item[1]/description/text()' - | sed -e 's/&gt;/>/g' -e 's/&lt;/</g' -e 's/<br\/>/ /g' -e 's/&..;/ /g' | nohtml | head -n1)
        pkg_target=$(curl -L -s "${boxoh}&t=${pkg}" | grep Target | nohtml | head -n1 | cut -d' ' -f2)
        echo "${pkg} target: ${pkg_target} status: ${pkg_stat}"
    done
}
