# Run slack desktop app in a container
# docker build . -t ryansb/slack:latest
# (optional) xhost local:docker
#
# docker run -d \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e "DISPLAY=unix${DISPLAY}" \
#    --device /dev/snd \
#    --device /dev/dri \
#    --device /dev/video0 \
#    --group-add audio \
#    --group-add video \
#    -v "${HOME}/.slack/focused-slack:/root/.config/Slack" \
#    --ipc="host" \
#    --name focus-slack \
#    ryansb/slack
# docker run -d \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e "DISPLAY=unix${DISPLAY}" \
#    --device /dev/snd \
#    --device /dev/dri \
#    --device /dev/video0 \
#    --group-add audio \
#    --group-add video \
#    -v "${HOME}/.slack/all-slack:/root/.config/Slack" \
#    --ipc="host" \
#    --name all-slack \
#    ryansb/slack

FROM debian:jessie-slim
LABEL maintainer "Ryan Scott Brown <sb@ryansb.com>"

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	locales \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

# Add the slack debian repo
RUN curl -sSL https://packagecloud.io/slacktechnologies/slack/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" > /etc/apt/sources.list.d/slacktechnologies_slack.list

RUN apt-get update && apt-get -y install \
	libasound2 \
	libgtk-3-0 \
	libx11-xcb1 \
	libxkbfile1 \
	slack-desktop \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/lib/slack/slack"]
