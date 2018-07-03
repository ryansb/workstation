# Run bluejeans app in a container
# docker build . -t ryansb/bluejeans:latest
# (optional) xhost local:docker
# docker run -d \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e "DISPLAY=unix${DISPLAY}" \
#    --device /dev/snd \
#    --device /dev/dri \
#    --device /dev/video0 \
#    --group-add audio \
#    --group-add video \
#    --ipc="host" \
#    --name bluejeans \
#    ryansb/bluejeans

FROM fedora:27
LABEL maintainer "Ryan Scott Brown <sb@ryansb.com>"

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN dnf update -y && dnf install -y gtk2 GConf2 alsa-lib libXtst libnotify libglvnd-glx mesa-dri-drivers \
	&& dnf clean all

RUN dnf install -y --nogpgcheck https://swdl.bluejeans.com/desktop/linux/1.35/1.35.15/bluejeans-1.35.15.x86_64.rpm \
	&& dnf clean all

ENTRYPOINT ["bluejeans"]
