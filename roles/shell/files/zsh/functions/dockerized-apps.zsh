# copied from https://github.com/jessfraz/dotfiles/blob/master/.dockerfunc
function del_stopped {
	local state
	state=$(docker inspect --format "{{.State.Running}}" "${1}" 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm "${1}"
	fi
}

function slack-focused {
    del_stopped focus-slack
    docker run -d \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=unix${DISPLAY}" \
        --device /dev/snd \
        --device /dev/dri \
        --device /dev/video0 \
        --group-add audio \
        --group-add video \
        -v "${HOME}/.slack/focused-slack:/root/.config/Slack" \
        --ipc="host" \
        --name focus-slack \
        ryansb/slack
}

function slack-all {
    del_stopped all-slack
    docker run -d \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=unix${DISPLAY}" \
        --device /dev/snd \
        --device /dev/dri \
        --device /dev/video0 \
        --group-add audio \
        --group-add video \
        -v "${HOME}/.slack/all-slack:/root/.config/Slack" \
        --ipc="host" \
        --name all-slack \
        ryansb/slack
}

function shellcheck {
    del_stopped shellcheck >/dev/null 2>/dev/null
    docker run -it \
        -v /etc/localtime:/etc/localtime:ro \
        -v "${PWD}:/mnt:ro" \
        --device /dev/dri \
        --ipc="host" \
        --name shellcheck \
        ryansb/shellcheck shellcheck /mnt/"${1}"
}

function former {
    del_stopped former >/dev/null 2>/dev/null
    mkdir /tmp/former >/dev/null 2>/dev/null
    docker run -it \
        -v /etc/localtime:/etc/localtime:ro \
        -v "/tmp/former:/tmp" \
        --device /dev/dri \
        --ipc="host" \
        --name former \
        ryansb/former former "${@}"
}

function bluejeans {
    del_stopped bluejeans
    docker run -d \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=unix${DISPLAY}" \
        --device /dev/snd \
        --device /dev/dri \
        --device /dev/video0 \
        --group-add audio \
        --group-add video \
        --ipc="host" \
        --name bluejeans \
        ryansb/bluejeans
}

function zoom {
    del_stopped zoom
    docker run -d \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=unix${DISPLAY}" \
        --device /dev/snd \
        --device /dev/dri \
        --device /dev/video0 \
        --group-add audio \
        --group-add video \
        --ipc="host" \
        --name zoom \
        ryansb/zoom-us
}
