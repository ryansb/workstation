FROM alpine:3.7

LABEL maintainer "Ryan Scott Brown <sb@ryansb.com>"

# current-stable https://shellcheck.storage.googleapis.com/index.html
ADD https://shellcheck.storage.googleapis.com/shellcheck-stable.linux /bin/shellcheck
RUN chmod a+x /bin/shellcheck

CMD ["/bin/shellcheck"]
